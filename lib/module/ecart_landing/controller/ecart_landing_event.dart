abstract class ECartLandingEvent {
  ECartLandingEvent();
}

class AddItem extends ECartLandingEvent {
  final int id;
  final String itemName;
  final String image;
  AddItem({required this.id, required this.image, required this.itemName});
}
