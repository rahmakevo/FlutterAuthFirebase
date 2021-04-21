import 'package:flutter/material.dart';
import 'package:sample/services/authentication.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _signOut() async {
    try {
      // ignore: await_only_futures
      await widget.auth.signOut;
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome'),
        actions: <Widget>[
          new FlatButton(
              onPressed: _signOut(),
              child: new Text(
                'Logout',
                style: new TextStyle(fontSize: 17.0, color: Colors.white),
              ))
        ],
      ),
      body: Center(
        child: Text('hello'),
      ),
    );
  }
}
