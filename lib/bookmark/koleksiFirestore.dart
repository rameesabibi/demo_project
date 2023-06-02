import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddBookmarks {
  final String nama;
  final int bilangan;
  final Color? warna;

  AddBookmarks(this.nama, this.bilangan, this.warna);

  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('bookmarks');

    Future<void> addBookmarks() {
      return user
          .add({'nama': nama, 'warna': warna})
          .then((value) => printValue("User Added"))
          .catchError((error) => printValue("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addBookmarks,
      child: const Text(
        "Add User",
      ),
    );
  }
  
  printValue(String s) {}
}

class GetUserName extends StatelessWidget {
  final String documentId;

  const GetUserName(this.documentId, {super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }
        return const Text("loading");
      },
    );
  }
}

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  UserInformationState createState() => UserInformationState();
}

class UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('User').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['nama']),
              subtitle: Text(data['bilangan']),
            );
          }).toList(),
        );
      },
    );
  }
}
