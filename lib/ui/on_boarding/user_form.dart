import 'package:flutter/material.dart';

import '../../util/gaps.dart';

class UserForm extends StatelessWidget {
  final TextEditingController? nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool busy;
  final VoidCallback onSubmit;
  final GlobalKey<FormState> formKey;
  final bool isRegistration;

  const UserForm({
    super.key,
    this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.busy,
    required this.onSubmit,
    required this.formKey,
    required this.isRegistration,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(isRegistration? 'User Registration': 'User SignIn',
          style: Theme.of(context).textTheme.headlineMedium,),
          gapH16,
          !isRegistration
              ? TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                )
              : gapW8,
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address';
              }
              return null;
            },
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),
          busy
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    backgroundColor: Colors.pink,
                  ),
                )
              : ElevatedButton(
                  onPressed: onSubmit,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Submit'),
                  ),
                ),
        ],
      ),
    );
  }
}
