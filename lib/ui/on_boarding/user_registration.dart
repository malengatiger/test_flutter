import 'package:busha_app/services/auth.dart';
import 'package:busha_app/ui/on_boarding/user_form.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
  static const mm = '🌿🌿 UserRegistrationWidget';
  final bool _busy = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  Future registerUser() async {
    pp('$mm register user ...');
    User user = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
    try {
      var resp = await _authService.register(user);
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        pp('$mm user registered: ${resp.body}');
      } else {
        if (mounted) {
          showErrorDialog(
              message: 'Bad registration response', context: context);
        }
      }
    } catch (e) {
      pp(e);
      if (mounted) {
        showErrorDialog(message: '$e', context: context);
      }
    }
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
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    busy: _busy,
                    onSubmit: () {
                      registerUser();
                    },
                    formKey: _formKey,
                    isRegistration: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
