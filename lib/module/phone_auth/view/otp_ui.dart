import 'package:ecart/_util/common_function.dart';
import 'package:ecart/module/ecart_landing/view/ecart_landing_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpUI extends StatefulWidget {
  final String verificationId;
  const OtpUI({super.key, required this.verificationId});

  @override
  State<OtpUI> createState() => _OtpUIState();
}

class _OtpUIState extends State<OtpUI> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP UI"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          const Text("Please Enter 6 Digit OTP "),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputField(_fieldOne, smsCode),
              const SizedBox(width: 8),
              inputField(_fieldTwo, smsCode),
              const SizedBox(width: 8),
              inputField(_fieldThree, smsCode),
              const SizedBox(width: 8),
              inputField(_fieldFour, smsCode),
              const SizedBox(width: 8),
              inputField(_fieldFive, smsCode),
              const SizedBox(width: 8),
              inputField(_fieldSix, smsCode),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                smsCode = _fieldOne.text +
                    _fieldTwo.text +
                    _fieldThree.text +
                    _fieldFour.text +
                    _fieldFive.text +
                    _fieldSix.text;
                "SMS Code: $smsCode".logIt;
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId, smsCode: smsCode);
                await FirebaseAuth.instance.signInWithCredential(credential);
                "Sucessfully Logged In".logIt;
                UserCredential userCredential = await FirebaseAuth.instance
                    .signInWithCredential(credential);
                var firebaseAccessToken =
                    await userCredential.user!.getIdToken();
                "FirebaseAccessToken: $firebaseAccessToken".logIt;

                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ECartLanding(
                      firebaseToken: firebaseAccessToken,
                    ),
                  ),
                );
              },
              child: const Text("Verify OTP"),
            ),
          )
        ],
      ),
    );
  }
}

Widget inputField(
  TextEditingController controller,
  String smsCode,
) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          counterText: '',
          hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        // onChanged: (value) {
        //   // if (value.length == 1) {
        //   //   FocusScope.of(context).nextFocus();
        //   // }
        //   smsCode += value;
        //   "SMSCode: $smsCode".logIt;
        // },
      ),
    ),
  );
}
