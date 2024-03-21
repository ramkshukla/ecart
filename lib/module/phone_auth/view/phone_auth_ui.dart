import 'dart:async';

import 'package:ecart/_util/common_function.dart';
import 'package:ecart/module/phone_auth/controller/phone_auth_bloc.dart';
import 'package:ecart/module/phone_auth/controller/phone_auth_event.dart';
import 'package:ecart/module/phone_auth/controller/phone_auth_state.dart';
import 'package:ecart/module/phone_auth/view/otp_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class PhoneAuthUI extends StatefulWidget {
  const PhoneAuthUI({super.key});

  @override
  State<PhoneAuthUI> createState() => _PhoneAuthUIState();
}

class _PhoneAuthUIState extends State<PhoneAuthUI> {
  FirebaseAuth instance = FirebaseAuth.instance;
  TextEditingController controller = TextEditingController();
  String phoneNumber = "";
  String code = "";
  String verificationid = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthBloc(),
      child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          body: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.blue[100]!.withOpacity(0.4),
                borderRadius: const BorderRadius.all(Radius.circular(18))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Login"),
                TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    phoneNumber = value;
                    // context.read<PhoneAuthBloc>().add(
                    //       SendOtpEvent(value: value),
                    //     );

                    // code = value;

                    // "Code: $code".logIt;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    "---> ${FirebaseAuth.instance.app}".logIt;
                    context
                        .read<PhoneAuthBloc>()
                        .add(VerifyPhoneEvent(value: phoneNumber));
                    state.isOtpGenerated
                        ? OtpUI(verificationId: state.verificationId)
                        : const PhoneAuthUI();
                    // Timer(const Duration(seconds: 20), () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //          ,
                    //     ),
                    //   );
                    // });
                  },
                  child: const Text("Send OTP"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
