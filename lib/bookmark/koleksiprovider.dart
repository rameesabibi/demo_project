import 'package:flutter/material.dart';
import 'package:demo_project/bookmark/koleksidata.dart';


import 'koleksidata.dart';

// _listViewBuilder() {
//   return StreamBuilder<List<KoleksiData>>(
//     stream: FirebaseFirestore.instance
//         .collection("User")
//         .doc(FirebaseAuth.instance.currentUser!.uid!)
//         .collection('bookmarks')
//         .snapshots()
//         .map((query) =>
//             query.docs.map((map) => KoleksiData.fromMap(map.data())).toList()),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) {
//         return const Center(child: CircularProgressIndicator());
//       }
//       final koleksiList = snapshot.data!;
//       return ListView.builder(
//           itemCount: koleksiList.length,
//           itemBuilder: (context, index) {
//             final bookmarks = koleksiList[index];
//             return ListView.builder(
//                 itemCount: koleksiList.length,
//                 itemBuilder: (context, index) {});
//           });
//     },
//   );
// }

class KoleksiProvider extends ChangeNotifier {
  final List<KoleksiData> _koleksiList = [];
  Color? color = Colors.red.shade100;

  void updateColor(int colorValue) {
    color = Color(colorValue);
    notifyListeners();
    printValue(colorValue);
  }

  void setDefault() {
    color = Colors.red.shade100;
    notifyListeners();
  }

  void addItem(KoleksiData itemData) {
    _koleksiList.add(itemData);

    notifyListeners();
  }

  List<KoleksiData> get koleksiItem {
    return _koleksiList;
  }
  
  void printValue(int colorValue) {}
}
