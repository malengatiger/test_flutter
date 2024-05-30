import 'package:busha_app/misc/settings.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/ui/dashboard/dash_widget.dart';
import 'package:busha_app/ui/github/github_viewer.dart';
import 'package:busha_app/ui/landing/landing_page.dart';
import 'package:busha_app/ui/on_boarding/user_registration.dart';
import 'package:busha_app/ui/on_boarding/user_sign_in.dart';
import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/navigation_util.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/user.dart';
import '../../util/gaps.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key,});

  @override
  InfoPageState createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  static const mm = '🌍 🌍 InfoPage 🍎';
  AuthService authService = GetIt.instance<AuthService>();
  Prefs prefs = GetIt.instance<Prefs>();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _checkStatus();
  }
  _checkStatus() async {
    pp('$mm ... checking Firebase Auth status ...');
    user = prefs.getUser();
    setState(() {});
  }

  User? user;
  _navigateToGitHub() {
    NavigationUtils.navigateToPage(
        context: context, widget: const GithubViewer());
  }

  _navigateToSettings() {
    pp('$mm _navigateToSettings');
    NavigationUtils.navigateToPage(
        context: context, widget: const SettingsWidget());
  }

  _close() {
    Navigator.of(context).pop();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _logOut() async {
    await AuthService.signOut();
    if (mounted) {
      Navigator.of(context).pop();
      NavigationUtils.navigateToPage(context: context, widget: const LandingPage(stickAround: false));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Busha Mobile Dev Assessment',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        actions: [
          IconButton(
              onPressed: () {
                _navigateToSettings();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    user == null ? '' : '${user?.name}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  gapH16,
                  gapH16,
                  GestureDetector(
                    onDoubleTap: () async {
                       _logOut();
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 2000),
                        curve: Curves.bounceIn,
                        child: Image.asset(
                          'assets/banner1.webp',
                          fit: BoxFit.fill,
                        )),
                  ),
                  gapH16,
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                        'Welcome to the Busha Mobile Dev Assessment app built with Flutter with support from backend BushaBackend, built with NodeJS, NestJS and Firebase'),
                  ),
                  gapH32,
                  TextButton(
                      onPressed: () {
                        _navigateToGitHub();
                      },
                      child: const Text('View the code on GitHub')),
                  gapH32,
                  ElevatedButton(onPressed: () async {
                    _close();
                    Navigator.of(context).pop();
                  }, child: const Text('Close')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
