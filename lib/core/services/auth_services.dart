// import 'package:delivery_app/core/models/appUser.dart';
// import 'package:delivery_app/core/services/database_services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthServices {
//   final DatabaseServices _databaseServices = DatabaseServices();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

// // bool  get isLoggedIn => _auth.currentUser != null;
//   // bool? isLogin;
//   // User? get currentUser => _auth.currentUser;
//   User? user;
//   AppUser appUser = AppUser();

//   AuthServices() {
//     init();
//   }

//   // init fn
//   init() async {
//     user = _auth.currentUser;

//     if (user != null) {
//       appUser = await _databaseServices.getUser(user!.uid) ?? AppUser();
//       // isLogin = true;
//     } else {
//       // isLogin = false;
//     }
//   }

//   Future<void> verifyPhoneNumber(String phoneNumber, onCodeSent) async {
//     await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) {},
//         verificationFailed: (FirebaseAuthException e) {},
//         codeSent: onCodeSent,
//         codeAutoRetrievalTimeout: (String verificationId) {});
//   }

//   Future<UserCredential> signInWithPhoneNumber(
//       String verificationId, String smsCode) async {
//     return await _auth.signInWithCredential(
//       PhoneAuthProvider.credential(
//           verificationId: verificationId, smsCode: smsCode),
//     );
//   }

//   Future<void> register(AppUser appUser) async {
//     this.appUser = appUser;

//     await _databaseServices.createUser(appUser);
//     return;
//   }
// }
