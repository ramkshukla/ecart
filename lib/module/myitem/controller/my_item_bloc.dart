import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecart/_util/common_function.dart';
import 'package:ecart/module/ecart_landing/model/ecart_landing_dto.dart';
import 'package:ecart/module/myitem/controller/my_item_event.dart';
import 'package:ecart/module/myitem/controller/my_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyItemBloc extends Bloc<MyItemEvent, MyItemState> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  MyItemBloc()
      : super(MyItemState(data: [], isFetching: false, isDeleting: false)) {
    on<GetUserDataEvent>((event, emit) async {
      "Inside Get User Event called".logIt;
      emit(state.copyWith(isFetching: true));
      CollectionReference collectionReference =
          firebaseFirestore.collection("myitem");

      QuerySnapshot querySnapshot = await collectionReference.get();

      List<Map<String, dynamic>> userData = querySnapshot.docs
          .map((e) => e.data() as Map<String, dynamic>)
          .toList();

      final data = userData
          .map(
            (e) => ECartLandingDTO.fromJson(e),
          )
          .toList();

      emit(state.copyWith(data: data, isFetching: false));
    });

    on<DeleteMyCartItem>(
      (event, emit) async {
        "Inside Delete Event Called".logIt;
        emit(state.copyWith(isDeleting: true));
        CollectionReference collectionReference =
            firebaseFirestore.collection("myitem");
        Query query = collectionReference.where("id", isEqualTo: event.id);

        await query.get().then(
          (QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              // Delete each document found in the query.
              doc.reference.delete().then((_) {
                'Document successfully deleted.'.logIt;
              }).catchError((error) {
                'Error deleting document: $error'.logIt;
              });
            }
          },
        );
        final updatedList =
            state.data.where((item) => item.id != event.id).toList();
        emit(state.copyWith(data: updatedList, isDeleting: false));
      },
    );
  }
}
