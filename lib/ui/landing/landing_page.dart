import 'package:busha_app/misc/animated_widget.dart';
import 'package:busha_app/misc/settings.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/ui/dashboard/dash_widget.dart';
import 'package:busha_app/ui/github/github_viewer.dart';
import 'package:busha_app/ui/on_boarding/user_registration.dart';
import 'package:busha_app/ui/on_boarding/user_sign_in.dart';
import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/navigation_util.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:busha_app/util/toasts.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/user.dart';
import '../../util/gaps.dart';
import '../../util/styles.dart';
import 'info_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    super.key,
  });

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
    if (await AuthService.isSignedIn()) {
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
          await Future.delayed(const Duration(milliseconds: 200));
          if (mounted) {
            showToast(
                message:
                    'You are registered on the Busha Assessment App. \n\n🍎🍎🍎 Welcome aboard!! ',
                context: context);
            Navigator.of(context).pop();
            _navigateToDashboard();
          }
        }));
  }

  _navigateToSignIn() {
    pp('$mm _navigateToSignIn');
    NavigationUtils.navigateToPage(
        context: context,
        widget: UserSignInWidget(onUserSignedIn: (u) {
          pp('$mm ... user is signed in ok: ${u.toJson()}');
          if (mounted) {
            showToast(
                message:
                    'You are signed in on the Busha Assessment App. \n\n🍎🍎🍎 Welcome back!! ',
                context: context);
            Navigator.of(context).pop();
            _navigateToDashboard();
          }
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
        context: context,
        widget: const GithubViewer(
          gitHubIndex: 0,
        ));
  }

  _navigateToGitBackEnd() {
    NavigationUtils.navigateToPage(
        context: context,
        widget: const GithubViewer(
          gitHubIndex: 1,
        ));
  }

  _navigateToGitProfile() {
    NavigationUtils.navigateToPage(
        context: context,
        widget: const GithubViewer(
          gitHubIndex: 2,
        ));
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
    var style = myTextStyle(
        context, Theme.of(context).primaryColor, 16, FontWeight.w900);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Busha Mobile Dev Assessment',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        actions: [
          AnimatedBushaLogo(onTapped: () {
            NavigationUtils.navigateToPage(
                context: context, widget: const SettingsWidget());
          }),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 64,
                              child: Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        _navigateToSignIn();
                                      },
                                      child: Text(
                                        'Sign In',
                                        style: myTextStyleMediumLarge(context, 20),
                                      )),
                                  Text(
                                    'Go to your account',
                                    style: myTextStyleSmallWithColor(
                                        context, Colors.grey.shade700),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 64,
                              child: Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        _navigateToRegistration();
                                      },
                                      child: Text(
                                        'Register',
                                        style: myTextStyleMediumLarge(context, 20),
                                      )),
                                  Text(
                                    'No account yet?',
                                    style: myTextStyleSmallWithColor(
                                        context, Colors.grey.shade700),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    gapH32,
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 2000),
                        curve: Curves.bounceIn,
                        child: Image.asset(
                          'assets/banner1.webp',
                          fit: BoxFit.fill,
                        )),
                    gapH32,
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(desc),
                    ),
                    TextButton(
                        onPressed: () {
                          _navigateToGitFrontEnd();
                        },
                        child:
                            Text('Busha Flutter code on GitHub', style: style)),
                    TextButton(
                      onPressed: () {
                        _navigateToGitBackEnd();
                      },
                      child: Text('Busha Backend code on GitHub', style: style),
                    ),
                    gapH8,
                    TextButton(
                      onPressed: () {
                        _navigateToGitProfile();
                      },
                      child: Text('Developer Profile on GitHub', style: style),
                    ),
                    gapH16,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
