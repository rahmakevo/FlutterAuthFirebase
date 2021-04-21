import 'package:flutter/material.dart';
import 'package:sample/services/authentication.dart';
import 'package:sample/ui/auth/loginsignuppage.dart';
import 'package:sample/ui/home_page.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  State<StatefulWidget> createState() => new __RootPageState();
}

enum AuthStatus { NOT_DETERMINED, LOGGED_OUT, LOGGED_IN }

class __RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();

    widget.auth.getCurrentUser().then((user) => {
          setState(() {
            if (user != null) {
              _userId = user.uid;
            }
            authStatus =
                user.uid == null ? AuthStatus.LOGGED_OUT : AuthStatus.LOGGED_IN;
          })
        });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user) => {
          setState(() {
            _userId = user.uid.toString();
          })
        });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.LOGGED_OUT;
      _userId = "";
    });
  }

  Widget progressScreenWidget() {
    return Scaffold(
      body: Container(
          alignment: Alignment.center, child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return progressScreenWidget();
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomePage(
              userId: _userId, auth: widget.auth, onSignedOut: _onSignedOut);
        } else
          return progressScreenWidget();
        break;
      case AuthStatus.LOGGED_OUT:
        return new LoginSignupPage(auth: widget.auth, onSignedIn: _onLoggedIn);
        break;
      default:
        return progressScreenWidget();
    }
  }
}
