class ECartLandingDTO {
  final String image;
  final String itemName;
  final int id;

  ECartLandingDTO({
    required this.image,
    required this.itemName,
    required this.id,
  });

  factory ECartLandingDTO.fromJson(Map<String, dynamic> json) {
    return ECartLandingDTO(
      image: json["image"],
      itemName: json["itemName"],
      id: json["id"],
    );
  }
}
