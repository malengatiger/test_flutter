
import 'package:busha_app/misc/animated_widget.dart';
import 'package:busha_app/misc/busy_indicator.dart';
import 'package:busha_app/misc/settings.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/ui/on_boarding/user_form.dart';
import 'package:busha_app/util/navigation_util.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:busha_app/util/styles.dart';
import 'package:busha_app/util/toasts.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:email_validator/email_validator.dart';

import '../../models/user.dart';
import '../../util/functions.dart';

class UserRegistrationWidget extends StatefulWidget {
  const UserRegistrationWidget({super.key, required this.onUserRegistered});

  final Function(User) onUserRegistered;

  @override
  UserRegistrationWidgetState createState() => UserRegistrationWidgetState();
}

class UserRegistrationWidgetState extends State<UserRegistrationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = GetIt.instance<AuthService>();

  final Prefs _prefs = GetIt.instance<Prefs>();
  static const mm = '🌿🌿 UserRegistrationWidget';
  bool _busy = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  Future _registerUser() async {
    pp('$mm ........................ register user starting ...');
    if (!EmailValidator.validate(_emailController.text)) {
      pp('$mm _registerUser: EmailValidator says NO!');
      showToast(
          backgroundColor: Colors.red.shade700,
          textStyle: const TextStyle(color: Colors.white),
          padding: 20.0,
          message: 'Please enter properly formatted email address', context: context);
      return;
    }
    User user = User(
        name: _nameController.text,
        email: _emailController.text,
        uid: '',
        password: _passwordController.text);
    setState(() {
      _busy = true;
    });
    try {
      var resp = await _authService.register(user);
      if (resp) {
        pp('$mm user registered: 🍐');
        if (mounted) {
          var user = _prefs.getUser();
          if (user != null) {
            widget.onUserRegistered(user);
          }
        }
      } else {
        if (mounted) {
          showErrorDialog(
              message:
                  'Registration failed. The email ${_emailController.text} is already in use. '
                      '\n\nChange the email address or use another one. Please try again!',
              context: context);
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Busha Dev Assessment', style: myTextStyleMediumBoldPrimaryColor(context),),
        actions:  [
          AnimatedBushaLogo(onTapped: (){
            pp('$mm ... logo tapped ... navigate to settings');
            NavigationUtils.navigateToPage(context: context, widget: const SettingsWidget());
          },),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                    : SingleChildScrollView(
                        child: UserForm(
                            nameController: _nameController,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            onSubmit: () {
                              pp('$mm onSubmit: validate form');
                              if (_formKey.currentState!.validate()) {
                                _registerUser();
                              }
                            },
                            formKey: _formKey,
                            isRegistration: true),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
