import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecart/_util/common_function.dart';
import 'package:ecart/module/ecart_landing/controller/ecart_landing_event.dart';
import 'package:ecart/module/ecart_landing/controller/ecart_landing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ECartLandingBloc extends Bloc<ECartLandingEvent, ECartLandingState> {
  FirebaseFirestore? firebaseFirestore = FirebaseFirestore.instance;
  ECartLandingBloc() : super(ECartLandingState()) {
    on<AddItem>(
      (event, emit) async {
        CollectionReference collectionReference =
            firebaseFirestore!.collection("myitem");

        Map<String, dynamic> itemData = {
          "id": event.id,
          "itemName": event.itemName,
          "image": event.image
        };

        try {
          await collectionReference.doc().set(itemData);
          "Item Successfully added to the cart".logIt;
        } catch (error) {
          "$error".logIt;
        }
      },
    );
  }
}
