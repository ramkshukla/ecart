import 'package:ecart/module/phone_auth/controller/phone_auth_event.dart';
import 'package:ecart/module/phone_auth/controller/phone_auth_state.dart';
import 'package:ecart/module/phone_auth/repo/phone_auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  PhoneAuthBloc()
      : super(PhoneAuthState(
            verificationId: "", isLoading: false, isOtpGenerated: false)) {
    on<SendOtpEvent>(
      (event, emit) async {},
    );

    on<VerifyPhoneEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final result =
            await PhoneAuthRepoImp().phoneAuth(phoneNumber: event.value);
        final updatedState = result.fold(
          (l) => state.copyWith(isLoading: false),
          (r) => state.copyWith(
            isLoading: false,
            isOtpGenerated: true,
          ),
        );

        emit(updatedState);

        // await FirebaseAuth.instance.verifyPhoneNumber(
        //   phoneNumber: "+91${event.value}",
        //   verificationCompleted: (PhoneAuthCredential credential) {
        //     ">>>>>Verification COmpleted: $credential".logIt;
        //   },
        //   verificationFailed: (FirebaseAuthException e) {
        //     ">>>>>Verification Failed: $e".logIt;
        //   },
        //   codeSent: (String verificationId, int? resendToken) {
        //     "Verification Id: $verificationId".logIt;
        //     "Resent Token: $resendToken".logIt;
        //     // verificationid = verificationId;
        //     emit(state.copyWith(verificationId: verificationId));
        //   },
        //   codeAutoRetrievalTimeout: (String verificationId) {},
        // );
      },
    );
  }
}
