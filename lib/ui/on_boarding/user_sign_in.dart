import 'package:busha_app/misc/animated_widget.dart';
import 'package:busha_app/misc/settings.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/ui/dashboard/dash_widget.dart';
import 'package:busha_app/ui/on_boarding/user_form.dart';
import 'package:busha_app/util/navigation_util.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:email_validator/email_validator.dart';
import '../../misc/busy_indicator.dart';
import '../../models/user.dart';
import '../../util/functions.dart';
import '../../util/toasts.dart';

class UserSignInWidget extends StatefulWidget {
  const UserSignInWidget({super.key, required this.onUserSignedIn});

  final Function(User) onUserSignedIn;

  @override
  UserSignInWidgetState createState() => UserSignInWidgetState();
}

class UserSignInWidgetState extends State<UserSignInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = GetIt.instance<AuthService>();

  static const mm = '🌿🌿 UserSignInWidget';
  bool _busy = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  Future _signInUser() async {
    pp('$mm ................... signInUser ...');
    if (!EmailValidator.validate(_emailController.text)) {
      pp('$mm _signInUser: EmailValidator says NO!');
      showToast(
          message: 'Please enter properly formatted email address',
          backgroundColor: Colors.red.shade600,
          textStyle: const TextStyle(color: Colors.white),
          padding: 24.0,
          context: context);
      return;
    }
    try {
      setState(() {
        _busy = true;
      });
      var user = await _authService.signIn(
          _emailController.text, _passwordController.text);
      if (user != null) {
        pp('$mm user signed in: ${user.toJson()}');
        _navigateToDashboard();
      } else {
        if (mounted) {
          showErrorDialog(message: 'Bad signIn response', context: context);
        }
      }
    } catch (e) {
      pp(e);
      if (mounted) {
        showErrorDialog(message: '$e', context: context);
      }
    }
    setState(() {
      _busy = false;
    });
  }

  _navigateToDashboard() {
    Navigator.of(context).pop();
    NavigationUtils.navigateToPage(
        context: context, widget: const DashWidget());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busha Dev Assessment'),
        actions: [
          AnimatedBushaLogo(onTapped: (){
            NavigationUtils.navigateToPage(context: context, widget: const SettingsWidget());
          }),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _busy
                  ? const Center(
                    child: BusyIndicator(
                      caption: 'Busha signing you up so you can play with the app and see whether it meets requirements. \n\n😎😎😎',

                    ),
                  )
                  : UserForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      onSubmit: () {
                        pp('$mm onSubmit: validate sign in form ..');
                        if (_formKey.currentState!.validate()) {
                          _signInUser();
                        }
                      },
                      formKey: _formKey,
                      isRegistration: false),
            ),
          ],
        ),
      ),
    );
  }
}
