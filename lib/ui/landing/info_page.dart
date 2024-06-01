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
import 'package:busha_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/user.dart';
import '../../util/gaps.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({
    super.key,
  });

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
      NavigationUtils.navigateToPage(
          context: context, widget: const LandingPage());
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
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user == null ? '' : '${user?.name}',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    gapH32,
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
                    gapH8,
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(desc),
                    ),
                    TextButton(
                        onPressed: () {
                          _navigateToGitFrontEnd();
                        },
                        child: Text('View Busha Flutter code on GitHub',
                            style: myTextStyleMediumBoldPrimaryColor(context))),
                    TextButton(
                      onPressed: () {
                        _navigateToGitBackEnd();
                      },
                      child: Text('View Busha Backend code on GitHub',
                          style: myTextStyleMediumBoldPrimaryColor(context)),
                    ),
                    gapH8,
                    TextButton(
                      onPressed: () {
                        _navigateToGitProfile();
                      },
                      child: Text('View Developer Profile on GitHub',
                          style: myTextStyleMediumBoldPrimaryColor(context)),
                    ),
                    gapH16,
                    ElevatedButton(
                        onPressed: () async {
                          _close();
                        },
                        child: Text('Close',
                            style: myTextStyleMediumBoldPrimaryColor(context))),
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

const desc = '''
Welcome to the Busha Mobile Dev Assessment app! This app is built using Flutter for the front end, with a robust backend powered by NodeJS, NestJS, and Firebase, all hosted as a Docker container on Google Cloud Run.
\nThe app runs on iOS and Android.
''';
