import
 
'package:firebase_auth/firebase_auth.dart';
import
 
'package:flutter/material.dart';

class AuthProvider   extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      _currentUser = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle error.
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      final UserCredential userCredential = await _auth.signInWithPopup(googleAuthProvider);
      _currentUser = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle error.
    }
  }

  Future<void> signInWithOtp(String phoneNumber, String otp) async {
    try {
      final PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: '', smsCode: otp);
      final UserCredential userCredential = await _auth.signInWithCredential(phoneAuthCredential);
      _currentUser = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle error.
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final
 
UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _currentUser = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle error.
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      final UserCredential userCredential = await _auth.signInWithPopup(googleAuthProvider);
      _currentUser = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle error.
    }
  }

 
  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }
}