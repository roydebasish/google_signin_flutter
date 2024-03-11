import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  Future<void> _checkSignInStatus() async {
    bool isSignedIn = await _googleSignIn.isSignedIn();
    setState(() {
      _isSignedIn = isSignedIn;
    });
  }

  Future<void> _handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        setState(() {
          _isSignedIn = true;
        });

        GoogleSignInAuthentication authentication = await account.authentication;
        String? accessToken = authentication.accessToken;
        String? idToken = authentication.idToken;

        print("Access Token: $accessToken");
        print("ID Token: $idToken");
        print("Access Token: ${_googleSignIn.currentUser?.email}");
        print("Access Token: ${_googleSignIn.currentUser?.displayName}");
        print("Access Token: ${_googleSignIn.currentUser?.photoUrl}");

      }

    } catch (error) {
      print(error);
    }
  }

  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              _isSignedIn ? "Welcome" : "Sign In With Google",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleSignIn,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
