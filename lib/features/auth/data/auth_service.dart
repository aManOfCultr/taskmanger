import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  final BuildContext context;

  AuthService(this.context);

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password, String username) async {
    final userCreds = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await FirebaseFirestore.instance.collection('users').doc(userCreds.user!.uid).set({
      'username': username,
      'email': email,
    });
  }
}
