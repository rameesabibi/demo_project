import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/flutter_flow/flutter_flow_theme%20copy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_project/bookmark/koleksidata.dart';
import 'package:demo_project/bookmark/koleksiprovider.dart';
import 'package:demo_project/bookmark/view_bookmark.dart';

import '../flutter_flow/flutter_flow_icon_button copy.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class ListData {
  final String listName;

  ListData({required this.listName});
}

class BookmarkWidget extends StatefulWidget {
  const BookmarkWidget({Key? key}) : super(key: key);

  @override
  BookmarkWidgetState createState() => BookmarkWidgetState();
}

class BookmarkWidgetState extends State<BookmarkWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  get koleksiColor => null;
  CollectionReference users = FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('bookmarks');

  Future<void> addBookmarks(nama, warna, bilangan) {
    return users
        .add({'nama': nama, 'warna': warna, 'bilangan': bilangan})
        .then((value) => printValue("Bookmark Added"))
        .catchError((error) => printValue("Failed to add bookmark: $error"));
  }

  Widget _listViewBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('bookmarks')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data found'));
        }
        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        final List<KoleksiData> bookmarks = documents
            .map((doc) =>
                KoleksiData.fromMap(doc.data()! as Map<String, dynamic>))
            .toList();

        return ListView.builder(
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.zero,
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  title: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: bookmarks[index].warna,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color.fromARGB(157, 56, 56, 56),
                            width: 2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Text(bookmarks[index].nama),
                    ],
                  ),
                  subtitle: const Text(''),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: const Color.fromARGB(157, 56, 56, 56),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        bookmarks[index].bilangan.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    printValue("Tapped Koleksi");
                    if (!mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewBookmark(
                          listdata: ListData(listName: bookmarks[index].nama),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _koleksiMaker(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    String? newKoleksiName;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          var newKoleksiColor = Provider.of<KoleksiProvider>(context).color;
          printValue(newKoleksiColor as String);
          return AlertDialog(
            title: const Text('Tambah Koleksi'),
            content: SizedBox(
              width: double.minPositive,
              child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  onChanged: () {
                    Form.of(primaryFocus!.context!).save();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Text(newKoleksiColor.toString()),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.folder),
                          hintText: 'Namakan Koleksi anda',
                          labelText: 'Nama Koleksi',
                        ),
                        onSaved: (String? value) {
                          newKoleksiName = value;
                        },
                        validator: (String? value) {
                          return (value != null && value.contains('@'))
                              ? 'Do not use the @ char.'
                              : null;
                        },
                      ),
                      const Padding(
                          padding: EdgeInsets.only(top: 24.0, bottom: 8),
                          child: Text("Pilih Warna Koleksi")),
                      const MultiSelectChip(),
                    ],
                  )),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text(
                  'Kembali',
                  style: TextStyle(
                    color: Color(0xFF8B63C1),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text(
                  'Teruskan',
                  style: TextStyle(
                    color: Color(0xFF8B63C1),
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    // newKoleksiColor = MultiSelectChipState.newKoleksiColor;
                    Provider.of<KoleksiProvider>(context, listen: false)
                        .addItem(KoleksiData(
                            nama: newKoleksiName ?? 'Koleksi Baru',
                            bilangan: 0,
                            warna: newKoleksiColor));
                    await addBookmarks(newKoleksiName ?? 'Koleksi Baru',
                        newKoleksiColor!.value, 0);
                    MultiSelectChipState.setDefault();
                    if (!mounted) return;
                    Provider.of<KoleksiProvider>(context, listen: false)
                        .setDefault();
                    if (!mounted) return;
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: FlutterFlowTheme.of(context).primaryColor,
        ),
        automaticallyImplyLeading: true,
        title: Align(
          alignment: const AlignmentDirectional(-0.9, 0),
          child: Text(
            'Penanda',
            style: FlutterFlowTheme.of(context).title3.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        actions: [
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.search_sharp,
              color: FlutterFlowTheme.of(context).primaryColor,
              size: 30,
            ),
            onPressed: () {
              printValue('IconButton pressed ...');
            },
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(17, 60, 0, 0),
                      child: InkWell(
                        onTap: () async {},
                        child: Text(
                          'Umum',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        icon: const Icon(
                          Icons.bookmarks_sharp,
                          color: Color(0xFF672EBD),
                          size: 30,
                        ),
                        onPressed: () {
                          printValue('IconButton pressed ...');
                        },
                      ),
                      Text(
                        'Semua Penanda',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        icon: const Icon(
                          Icons.local_fire_department_outlined,
                          color: Color(0xFF672EBD),
                          size: 30,
                        ),
                        onPressed: () {
                          printValue('IconButton pressed ...');
                        },
                      ),
                      Text(
                        'Popular Hari Ini',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(17, 20, 0, 0),
                      child: InkWell(
                        onTap: () async {},
                        child: Text(
                          'Koleksi Saya',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.3,
                  child: _listViewBuilder(),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 390,
                            height: 30,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 50,
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                      color: Color(0xFF8B63C1),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    printValue("Tapped Koleksi Baru");
                    _koleksiMaker(context);
                  },
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 60,
                          icon: Icon(
                            Icons.queue,
                            color: Color(0xFF672EBD),
                            size: 30,
                          ),
                        ),
                        Text(
                          'Koleksi Baru',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  printValue(String s) {}
}

class MultiSelectChip extends StatefulWidget {
  const MultiSelectChip({super.key});

  @override
  MultiSelectChipState createState() => MultiSelectChipState();
}

class MultiSelectChipState extends State<MultiSelectChip> {
  int? _value = 0;
  List<Color> color = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.yellow.shade100,
    Colors.orange.shade100,
    Colors.green.shade100
  ];
  List<String> colorName = ["Merah", "Biru", "Kuning", "Oren", "Hijau"];
  late final Color? selectedColor;
  static var newKoleksiColor = Colors.red.shade100.value;
  static Color? borderColor = Colors.black;

  int get koleksiColor {
    return newKoleksiColor;
  }

  static void setDefault() {
    newKoleksiColor = Colors.red.shade100.value;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      children: List<Widget>.generate(
        5,
        (int index) {
          return ChoiceChip(
            label: Text(colorName[index]),
            labelStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.normal),
            backgroundColor: color[index],
            shape: StadiumBorder(
                side: BorderSide(
              width: 2.5,
              color: _value == index ? Colors.cyan : Colors.transparent,
            )),
            selected: _value == index,
            selectedColor: color[index],
            onSelected: (bool selected) {
              Provider.of<KoleksiProvider>(context, listen: false)
                  .updateColor(color[index].value);
              setState(() {
                _value = selected ? index : null;
                newKoleksiColor = color[index].value;
              });
            },
          );
        },
      ).toList(),
    );
  }
}
