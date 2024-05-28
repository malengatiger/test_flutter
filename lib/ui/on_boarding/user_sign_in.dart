import 'package:busha_app/services/auth.dart';
import 'package:busha_app/ui/on_boarding/user_form.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/user.dart';
import '../../util/functions.dart';

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

  Future signInUser() async {
   pp('$mm signInUser ...');
    try {
      setState(() {
        _busy = true;
      });
      var user = await _authService.signIn(_emailController.text, _passwordController.text);
      if (user != null) {
        pp('$mm user signed in: ${user.toJson()}');
      } else {
        if (mounted) {
          showErrorDialog(
              message: 'Bad signIn response', context: context);
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
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: UserForm(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    busy: _busy,
                    onSubmit: () {
                      if (_formKey.currentState!.validate()) {
                        signInUser();
                      }
                    },
                    formKey: _formKey,
                    isRegistration: false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
