abstract class MyItemEvent {}

class GetUserDataEvent extends MyItemEvent {
  GetUserDataEvent();
}

class DeleteMyCartItem extends MyItemEvent {
  final int id;
  DeleteMyCartItem({
    required this.id,
  });
}
