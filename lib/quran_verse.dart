import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import 'flutter_flow/flutter_flow_icon_button copy.dart';
import 'flutter_flow/flutter_flow_theme copy.dart';

class QuranVerse {
  final String? suraId;
  final String? aya;
  final String? text;
  final _searchController = TextEditingController();

  QuranVerse({
    this.suraId,
    this.aya,
    this.text,
  });

  factory QuranVerse.fromJson(Map<String, dynamic> json) {
    return QuranVerse(
      suraId: json['sura_id'] as String,
      aya: json['aya'] as String,
      text: json['text'] as String,
    );
  }

  get ayahNumber => null;
}

class QuranVerseScreen extends StatefulWidget {
  const QuranVerseScreen({Key? key}) : super(key: key);

  @override
  _QuranVerseScreenState createState() => _QuranVerseScreenState();
}

class _QuranVerseScreenState extends State<QuranVerseScreen> {
  List<QuranVerse>? data;
  List<String> surahIds = [];
  String selectedSurahId = '1';

  Future<String> _loadQuranVerseAsset() async {
    return await rootBundle.loadString('assets/new_quran_fonttext1.json');
  }

  Future<List<QuranVerse>> fetchData() async {
    String jsonString = await _loadQuranVerseAsset();
    final jsonResponse = json.decode(jsonString);
    List<QuranVerse> data = [];
    for (var item in jsonResponse.values) {
      data.add(QuranVerse.fromJson(item));
    }
    print(jsonResponse);
    return data;
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF1E2F2),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF424242),
            size: 30,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Text(
          'Al-Fatihah',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Color(0xFFBE6CC6),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Color(0xFF424242),
            onPressed: () {
              // Do something when the search button is pressed
            },
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: Center(
        child: data == null
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  DropdownButton<String>(
                    value: selectedSurahId.isNotEmpty ? selectedSurahId : null,
                    hint: const Text('Select Surah'),
                    items: surahIds
                        .map<DropdownMenuItem<String>>((String surahId) {
                      return DropdownMenuItem<String>(
                        value: surahId,
                        child: Text('Surah $surahId'),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSurahId = newValue!;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: Container(
                      width: double.infinity,
                      height: 280,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            color: Color(0x33000000),
                            offset: Offset(0, 5),
                          )
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xFFA469A8), Color(0xFFDAADDB)],
                          stops: [0, 1],
                          begin: AlignmentDirectional(1, -1),
                          end: AlignmentDirectional(-1, 1),
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 25, 0, 15),
                            child: Text(
                              'Al-Fatihah',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                            child: Text(
                              'The Opening ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                            child: Text(
                              'MECCAH - 7 VERSES',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                            child: Text(
                              'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        if (selectedSurahId.isNotEmpty &&
                            data![index].suraId != selectedSurahId) {
                          return SizedBox.shrink();
                        }

                        return Column(
                          children: [
                            // if (index == 0 ||
                            //     data![index].suraId != data![index - 1].suraId)
                            //   SizedBox(height: 10),
                            // if (index == 0 ||
                            //     data![index].suraId != data![index - 1].suraId)
                            //   Text(
                            //     'Surah ${data![index].suraId}',
                            //     style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 18,
                            //     ),
                            //   ),

                            SizedBox(height: 20),

                            SizedBox(
                              height: 240,
                              width: 380,
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return Container(
                                    width: double.infinity,
                                    height: null,
                                    constraints: BoxConstraints(
                                      maxWidth: double.infinity,
                                      maxHeight: constraints.maxHeight,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEDD1EE),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 12,
                                          color: Color(0x33000000),
                                          offset: Offset(0, 5),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(50),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFA469A8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 12,
                                                      color: Color(0x33000000),
                                                      offset: Offset(0, 5),
                                                    )
                                                  ],
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: FittedBox(
                                                      child: Text(
                                                        data![index].aya!,
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Lato',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                buttonSize: 45,
                                                icon: Icon(
                                                  Icons.share_outlined,
                                                  color: Color(0xFFBE6CC6),
                                                  size: 25,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                              SizedBox(width: 10),
                                              FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                buttonSize: 45,
                                                icon: Icon(
                                                  Icons.bookmark_border_rounded,
                                                  color: Color(0xFFBE6CC6),
                                                  size: 25,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Text(
                                                data![index].text!,
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                  fontFamily: 'QuranIrab',
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> updateData() async {
    try {
      data = await fetchData();
      surahIds = data!.map((verse) => verse.suraId!).toSet().toList();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
}
