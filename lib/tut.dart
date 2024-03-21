import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecart/_util/common_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tut extends StatefulWidget {
  const Tut({super.key});

  @override
  State<Tut> createState() => _TutState();
}

class _TutState extends State<Tut> {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  FirebaseFirestore? firebaseFirestore;
  String firstname = "";
  String lastname = "";
  List<Map<String, dynamic>> userData = [];

  
  @override
  void initState() {
    super.initState();
    firebaseFirestore = FirebaseFirestore.instance;
  }

  //Firestore Data Saved
  Future<void> postUser(String firstName, String lastName) async {
    CollectionReference collectionReference =
        firebaseFirestore!.collection("userTut");
    Map<String, dynamic> userData = {
      "firstName": firstName,
      "lastName": lastName,
    };

    try {
      await collectionReference.doc().set(userData);
      "Data Saved Successfully".logIt;
    } catch (error) {
      "$error".logIt;
    }
  }

  //Firestore Data Get
  Future<void> getUser() async {
    CollectionReference collectionReference =
        firebaseFirestore!.collection("userTut");
    QuerySnapshot dataSnapshot = await collectionReference.get();
    userData =
        dataSnapshot.docs.map((e) => e.data() as Map<String, dynamic>).toList();
  }

  //Firestore Update User
  Future<void> updateUser(String firstNewName, String lastNewName) async {
    QuerySnapshot querySnapshot = await firebaseFirestore!
        .collection("userTut")
        .where("firstName", isEqualTo: firstNewName)
        .get();
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      try {
        DocumentReference documentReference =
            firebaseFirestore!.collection("userTut").doc(documentSnapshot.id);
        await documentReference.update({
          "firstName": firstNewName,
          "lastName": lastNewName,
        });
        "Documented Updated Successfully".logIt;
      } catch (error) {
        "$error".logIt;
      }
    }
  }

  //Firestore Delete User
  Future<void> deleteUser(String nameToDelete) async {
    // DocumentReference documentReference =
    //     firebaseFirestore!.collection("userTut").doc("/qeDoXxNMhccm1WPsXadB");
    // try {
    //   await documentReference.delete();
    //   "Document Delete Successfully".logIt;
    // } catch (error) {
    //   "$error".logIt;
    // }

    QuerySnapshot querySnapshot = await firebaseFirestore!
        .collection("userTut")
        .where('firstName', isEqualTo: nameToDelete)
        .get();
    for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {
      try {
        //Get the Documentreference  for the document
        DocumentReference documentReference = firebaseFirestore!
            .collection("userTut")
            .doc(queryDocumentSnapshot.id);
        await documentReference.delete();
        'Document with name $nameToDelete deleted successfully.'.logIt;
      } catch (error) {
        "$error".logIt;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FireStore Tutorial")),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            
            
            
            const SizedBox(height: 32),
            
            
            TextFormField(
              controller: firstController,
              decoration: const InputDecoration(
                hintText: "First Name",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                    strokeAlign: 3.0,
                    style: BorderStyle.solid,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                    strokeAlign: 3.0,
                    style: BorderStyle.solid,
                  ),
                ),
                enabled: true,
              ),
              onChanged: (value) {
                firstname = value;
                "First Name : $firstname".logIt;
              },
            ),
            
            
            const SizedBox(height: 16),
            TextFormField(
              controller: lastController,
              decoration: const InputDecoration(
                hintText: "Last Name",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                    strokeAlign: 3.0,
                    style: BorderStyle.solid,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                    strokeAlign: 3.0,
                    style: BorderStyle.solid,
                  ),
                ),
                enabled: true,
              ),
              onChanged: (value) {
                lastname = value;
                "First Name : $firstname".logIt;
              },
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    postUser(firstname, lastname);
                    setState(() {});
                  },
                  child: Text(
                    "Post",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
                OutlinedButton(
                    onPressed: () async {
                      await getUser();
                      firstController.clear();
                      lastController.clear();
                      setState(() {});
                    },
                    child: const Text("Get Data")),
                OutlinedButton(
                    onPressed: () async {
                      await updateUser(firstname, lastname);
                      firstController.clear();
                      lastController.clear();
                      setState(() {});
                    },
                    child: const Text("Upd Data")),
                OutlinedButton(
                    onPressed: () async {
                      await deleteUser(firstname);
                      setState(() {});
                    },
                    child: const Text("Del Data")),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  return Text(
                      "${userData[index]["firstName"]} ${userData[index]["lastName"]}");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
