
class RayChemState {
  final String imagePath;
  RayChemState({required this.imagePath});

  factory RayChemState.initial() => RayChemState(imagePath: "");

  RayChemState copyWith({String? imagePath}) {
    return RayChemState(imagePath: imagePath ?? this.imagePath);
  }
}
