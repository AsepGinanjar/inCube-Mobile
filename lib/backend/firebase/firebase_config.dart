import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD80LpLQFky7pnFkDkVKgGdY3gpF0Q71dY",
            authDomain: "prokimnas-87b7d.firebaseapp.com",
            projectId: "prokimnas-87b7d",
            storageBucket: "prokimnas-87b7d.appspot.com",
            messagingSenderId: "675108066038",
            appId: "1:675108066038:web:2bcacf2d8048cfc6fa52d7",
            measurementId: "G-GR3NTKQ9LS"));
  } else {
    await Firebase.initializeApp();
  }
}
