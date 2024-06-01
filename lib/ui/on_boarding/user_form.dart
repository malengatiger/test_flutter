import 'package:busha_app/util/styles.dart';
import 'package:flutter/material.dart';

import '../../util/gaps.dart';

class UserForm extends StatelessWidget {
  final TextEditingController? nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onSubmit;
  final GlobalKey<FormState> formKey;
  final bool isRegistration;

  const UserForm({
    super.key,
    this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.formKey,
    required this.isRegistration,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 48.0,
                backgroundImage: AssetImage('assets/busha_logo.jpeg'),
              ),
              gapH16,
              Text(
                isRegistration ? 'Busha Registration' : 'Busha SignIn',
                style: myTextStyleLargePrimaryColor(context),
              ),
              gapH32,
              gapH32,
              isRegistration
                  ? TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Your Name')),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.length < 2) {
                          return 'Please enter your name, use more than 2 characters';
                        }
                        return null;
                      },
                    )
                  : gapW8,
              gapH16,
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Email Address')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  return null;
                },
              ),
              gapH16,
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Password'),
                    hintText: 'Please enter your password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              gapH32,
              gapH32,
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    onSubmit();
                  },
                  style: const ButtonStyle(
                    elevation: WidgetStatePropertyAll(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Submit',
                      style: myTextStyleMediumLarge(context, 24),
                    ),
                  ),
                ),
              ),
              gapH32,
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              gapH32,
            ],
          ),
        ),
      ),
    );
  }
}
