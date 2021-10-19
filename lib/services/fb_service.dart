import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  late String verifid;
  Future<bool> phoneSignIn({
    required String phoneNumber,
  }) async {
    bool signin = false;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted:
            (PhoneAuthCredential phoneauthcredential) async {},
        codeAutoRetrievalTimeout: (String verificationId) {},
        codeSent: (String verificationId, int? forceResendingToken) {
          verifid = verificationId;
        },
        verificationFailed: (FirebaseAuthException error) {},
      );
      signin = true;
    } catch (e) {
      signin = false;
    }
    return signin;
  }

  //MAKE SURE THIS IS ONLY CALLED AFTER THE ABOVE METHOD HAS BEEN CALLED TO OBTAIN THE VERIFID
  Future<bool> signinwithOTP(String OTP) async {
    bool signin = false;

    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verifid, smsCode: OTP);

      await FirebaseAuth.instance.signInWithCredential(credential);
      signin = true;
    } catch (e) {
      signin = false;
      print(e);
    }
    return signin;
  }

  Future<bool> signout() async {
    bool signedout = false;
    try {
      await FirebaseAuth.instance.signOut();
      signedout = true;
    } catch (e) {
      signedout = false;
      print(e);
    }
    return signedout;
  }
}
