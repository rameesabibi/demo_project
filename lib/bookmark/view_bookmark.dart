import 'package:demo_project/flutter_flow/flutter_flow_theme%20copy.dart';
import 'package:flutter/material.dart';
import 'package:demo_project/bookmark/bookmark.dart';

import '../flutter_flow/flutter_flow_icon_button copy.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'bookmark.dart';

class ViewBookmark extends StatefulWidget {
  final ListData listdata;

  const ViewBookmark({Key? key, required this.listdata}) : super(key: key);

  @override
  ViewBookmarkState createState() => ViewBookmarkState();
}

class ViewBookmarkState extends State<ViewBookmark> {
  List<String> itemList = ['Item 1', 'Item 2', 'Item 3'];

  void deleteItem(int index) {
    setState(() {
      itemList.removeAt(index);
    });
    Navigator.of(context).pop();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  _listViewBuilder() {
    return ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 16, 8, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 8, 8, 8),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://picsum.photos/seed/931/600',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 8, 0, 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Text(
                                    'beep boop',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Text(
                                    'some text here beep boop',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 8, 8, 8),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.09,
                              // height: 90,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 60,
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  printValue('IconButton pressed ...');
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 150,
                                        color: Colors.white,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                leading: Icon(
                                                  Icons.edit,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                ),
                                                title: Text(
                                                  'Edit',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .title1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                      ),
                                                ),
                                                tileColor:
                                                    const Color(0xFFF5F5F5),
                                                dense: false,
                                                contentPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(40, 0, 0, 0),
                                              ),
                                              ListTile(
                                                onTap: () => deleteItem(index),
                                                leading: Icon(
                                                  Icons.delete,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                ),
                                                title: Text(
                                                  'Delete',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .title3
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                      ),
                                                ),
                                                tileColor:
                                                    const Color(0xFFF5F5F5),
                                                dense: false,
                                                contentPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(40, 0, 0, 0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF672EBD)),
        automaticallyImplyLeading: true,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Color(0xFF672EBD),
            size: 30,
          ),
          onPressed: () {
            printValue('IconButton pressed ...');
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: const AlignmentDirectional(-0.9, 0),
          child: Text(
            'Penanda',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  color: const Color(0xFF672EBD),
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        actions: [
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: const Icon(
              Icons.search_sharp,
              color: Color(0xFF672EBD),
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Padding(
              //   padding: const EdgeInsetsDirectional.fromSTEB(24, 32, 0, 16),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     children: [
              //       Text(
              //         // "> ${itemList.listName}",
              //         style: FlutterFlowTheme.of(context).bodyText1.override(
              //               fontFamily: 'Poppins',
              //               fontSize: 24,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.black,
              //             ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: size.height * 0.7,
                                child: _listViewBuilder(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void printValue(String s) {}
}
