class PhoneAuthState {
  final String verificationId;
  final bool isLoading;
  final bool isOtpGenerated;
  PhoneAuthState({
    required this.verificationId,
    required this.isLoading,
    required this.isOtpGenerated,
  });

  PhoneAuthState copyWith(
      {String? verificationId, bool? isLoading, bool? isOtpGenerated}) {
    return PhoneAuthState(
        verificationId: verificationId ?? this.verificationId,
        isLoading: isLoading ?? this.isLoading,
        isOtpGenerated: isOtpGenerated ?? this.isOtpGenerated);
  }

  @override
  String toString() {
    return "PhoneAuthState(verificationId: $verificationId, isLoading: $isLoading, isOtpGenerated: $isOtpGenerated)";
  }
}
