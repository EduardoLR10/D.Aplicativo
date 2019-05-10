import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'cadastro_pessoal_elementos.dart';
import '../icons/custom_icons.dart';
import '../common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginPage extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xff88c9bf),
    ));
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xfffafafa),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ContBar(
            text: 'Login',
            scaffoldKey: scaffoldKey,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
          ),
          LoginForm(),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _GoogleSignInSection(),
          //StreamBuilder(
          //   stream: Firestore.instance
          //        .collection('users')
          //        .where('estado', isEqualTo: "DF")
          //        .snapshots()
          //        .map((snap) => snap.documents.map((snap) => snap.data)),
          //    builder: (context, snapshot) {
          //      switch (snapshot.connectionState) {
          //        case ConnectionState.waiting:
          //          return new Text("carregando");
          //          break;
          //        default:
          //          //print(snapshot.data);
          //          return new Text(snapshot.data.toString());
          //          break;
          //      }
          //    }),
        ],
      ),
    );
  }
}

class TextFaceGoogle extends StatelessWidget {
  TextFaceGoogle(this.string);

  final String string;
  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xfff7f7f7),
        fontSize: 12.0,
      ),
    );
  }
}

class FaceGoogleCont extends StatelessWidget {
  FaceGoogleCont({this.text, this.color, this.icon});

  final Widget text, icon;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 232.0,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 1.0,
            spreadRadius: 1.0,
            offset: Offset(
              0.0,
              1.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(2.0),
        color: Color(color),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          text,
        ],
      ),
    );
  }
}

class FaceIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      CustomIcons.facebook,
      color: Color(0xfff7f7f7),
      size: 13,
    );
  }
}

class GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      CustomIcons.gplus,
      color: Color(0xfff7f7f7),
      size: 13,
    );
  }
}

class _GoogleSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleSignInSectionState();
}

class _GoogleSignInSectionState extends State<_GoogleSignInSection> {
  bool _success;

  var _token;

  final FirebaseMessaging _messaging = FirebaseMessaging();

  void initState() {
    super.initState();
    _messaging.getToken().then((token) {setState(() {
      _token = token;
    });});
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: FaceGoogleCont(
        text: TextFaceGoogle("  SIGN IN WITH GOOGLE"),
        color: 0xfff15f5c,
        icon: GoogleIcon(),
      ),
      onPressed: () async {
        _signInWithGoogle();
      },
    );
  }

  // Example code of how to sign in with google.
  void _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    Firestore.instance.collection('users').document(user.uid).setData(
        {'nome_user': (user.displayName), 'profile_photo': (user.photoUrl), 'token': _token},
        merge: true);

    final FirebaseUser currentUser = await _auth.currentUser();

    assert(user.uid == currentUser.uid);
    if (user != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Sucessfully signed in'),
        ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Sign in failed'),
        ));
    }
  }
}
