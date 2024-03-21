import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ecart/_util/api_response.dart';
import 'package:ecart/_util/common_function.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class PhoneAuthRepo {
  Future<APIResponse<String>> phoneAuth({required String phoneNumber});
}

class PhoneAuthRepoImp extends PhoneAuthRepo {
  Completer completer = Completer<APIResponse<String>>();

  @override
  Future<APIResponse<String>> phoneAuth({
    required String phoneNumber,
  }) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        timeout: const Duration(seconds: 30),
        verificationCompleted: _verificatioCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _smscodesent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
      );
      final result = await completer.future;
      return result;
    } on FirebaseAuthException catch (ex) {
      return left(
        Failure(
          response: ex.message ?? "Some error occurred. Please try again!",
        ),
      );
    } catch (e) {
      return left(
        Failure(
          response: e.toString(),
        ),
      );
    }
  }

  void _verificatioCompleted(AuthCredential credential) {
    "verification completed: ${credential.accessToken}".logIt;
  }

  void _smscodesent(String verificationCode, int? token) {
    "code sent: $token and verif code: $verificationCode".logIt;
    completer.complete(verificationCode);
  }

  String _verificationFailed(FirebaseAuthException authException) {
    "verification failed: ${authException.code}:- ${authException.message}"
        .logIt;
    completer.complete(
      left(
        Failure(
          response: authException.code == "invalid-phone-number"
              ? "Please enter valid phone number"
              : authException.message ??
                  "Some error occurred. Please try again",
        ),
      ),
    );

    return authException.message ?? "Error occurred. Please try again";
  }

  void _codeAutoRetrievalTimeout(String verificationCode) {
    "========>>>>VerificationCode: $verificationCode}".logIt;
    if (!completer.isCompleted) completer.complete(right(verificationCode));
  }
}
