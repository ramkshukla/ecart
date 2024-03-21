abstract class PhoneAuthEvent {
  PhoneAuthEvent();
}

class SendOtpEvent extends PhoneAuthEvent {
  String value;
  SendOtpEvent({required this.value});
}

class VerifyPhoneEvent extends PhoneAuthEvent {
  String value;
  VerifyPhoneEvent({required this.value});
}
