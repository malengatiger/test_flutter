import 'package:busha_app/misc/settings.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/ui/dashboard/dash_widget.dart';
import 'package:busha_app/ui/github/github_viewer.dart';
import 'package:busha_app/ui/on_boarding/user_registration.dart';
import 'package:busha_app/ui/on_boarding/user_sign_in.dart';
import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/navigation_util.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/user.dart';
import '../../util/gaps.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.stickAround});

  final bool stickAround;

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  static const mm = '🌍 🌍 LandingPage 🍎';
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
    await Future.delayed(const Duration(milliseconds: 100));
    if (await AuthService.isSignedIn() && widget.stickAround == false) {
      _navigateToDashboard();
      return;
    }
    pp('$mm ... User is NOT signed in ... expecting choice of Registration or SignIn');
    setState(() {});
  }

  User? user;

  _navigateToRegistration() {
    pp('$mm _navigateToRegistration');
    NavigationUtils.navigateToPage(
        context: context,
        widget: UserRegistrationWidget(onUserRegistered: (u) async {
          pp('$mm user is registered real kool: ${u.toJson()}');
          user = u;
          if (mounted) {
            setState(() {});
          }
          await Future.delayed(const Duration(milliseconds: 2000));
          if (mounted) {
            _navigateToDashboard();
          }
        }));
  }

  _navigateToSignIn() {
    pp('$mm _navigateToSignIn');
    NavigationUtils.navigateToPage(
        context: context,
        widget: UserSignInWidget(onUserSignedIn: (u) {
          pp('$mm user is signed in ok: ${u.toJson()}');
          _navigateToDashboard();
        }));
  }

  _navigateToDashboard() {
    pp('$mm _navigateToDashboard');
    Navigator.of(context).pop();
    NavigationUtils.navigateToPage(
        context: context, widget: const DashWidget());
  }

  _navigateToGitFrontEnd() {
    NavigationUtils.navigateToPage(
        context: context, widget: const GithubViewer(gitHubIndex: 0,));
  }
  _navigateToGitBackEnd() {
    NavigationUtils.navigateToPage(
        context: context, widget: const GithubViewer(gitHubIndex: 1,));
  }
  _navigateToGitProfile() {
    NavigationUtils.navigateToPage(
        context: context, widget: const GithubViewer(gitHubIndex: 3,));
  }
  _navigateToSettings() {
    pp('$mm _navigateToSettings');
    NavigationUtils.navigateToPage(
        context: context, widget: const SettingsWidget());
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
                  gapH8,
                  widget.stickAround
                      ? gapH16
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  _navigateToSignIn();
                                },
                                child: const Text('Sign In')),
                            TextButton(
                                onPressed: () {
                                  _navigateToRegistration();
                                },
                                child: const Text('Register')),
                          ],
                        ),
                  gapH8,
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 2000),
                      curve: Curves.bounceIn,
                      child: Image.asset(
                        'assets/banner1.webp',
                        fit: BoxFit.fill,
                      )),
                  gapH8,
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                        'Welcome to the Busha Mobile Dev Assessment app built with Flutter with support from backend BushaBackend, built with NodeJS, NestJS and Firebase'),
                  ),
                  gapH16,
                  TextButton(
                      onPressed: () {
                        _navigateToGitFrontEnd();
                      },
                      child: const Text('View the Flutter code on GitHub')),
                  gapH16,
                  TextButton(
                      onPressed: () {
                        _navigateToGitBackEnd();
                      },
                      child: const Text('View the NodeJS code on GitHub')),
                  gapH16,
                  TextButton(
                      onPressed: () {
                        _navigateToGitProfile();
                      },
                      child: const Text('View personal profile GitHub')),
                  gapH16,
                  ElevatedButton(
                      onPressed: () async {
                        _checkStatus();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
