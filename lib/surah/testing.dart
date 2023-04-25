import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
// import 'QuranTranslation.dart';
import '../flutter_flow/flutter_flow_icon_button copy.dart';
import '../flutter_flow/flutter_flow_theme copy.dart';
import 'package:quran/quran.dart';

class QuranVerse {
  final String? suraId;
  final String? aya;
  final String? text;

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

//quran_translation
//test
class QuranTranslation {
  String aya;
  String created_at;
  String id;
  String quran_text_id;
  String sura_id;
  String text;
  String translation_id;
  String updated_at;

  QuranTranslation(this.aya, this.created_at, this.id, this.quran_text_id,
      this.sura_id, this.text, this.updated_at, this.translation_id);

  factory QuranTranslation.fromJson(Map<String, dynamic> json) {
    return QuranTranslation(
      json['aya'] ?? '',
      json['created_at'] ?? '',
      json['id'] ?? '',
      json['quran_text_id'] ?? '',
      json['sura_id'] ?? '',
      json['text'] ?? '',
      json['translation_id'] ?? '',
      json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aya'] = this.aya;
    data['created_at'] = this.created_at;
    data['id'] = this.id;
    data['quran_text_id'] = this.quran_text_id;
    data['sura_id'] = this.sura_id;
    data['text'] = this.text;
    data['translation_id'] = this.translation_id;
    data['updated_at'] = this.updated_at;
    return data;
  }

  // @override
  // String toString() {
  //   return '{aya: $aya, created_at: $created_at, id: $id, quran_text_id: $quran_text_id, sura_id: $sura_id, text: $text, translation_id: $translation_id , updated_at: $updated_at}';
  // }
}

class QuranVerseScreen extends StatefulWidget {
  const QuranVerseScreen({Key? key}) : super(key: key);

  @override
  _QuranVerseScreenState createState() => _QuranVerseScreenState();
}

class _QuranVerseScreenState extends State<QuranVerseScreen> {
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  List<QuranVerse>? quranWord;
  List<QuranVerse>? filteredData;

  //quran_translation
  List? translation1;
  List? translation2;
  List<String> surahIds = [];

  String selectedSurahId = '1';

  var surahNameById;

  get surahNames => null;

  Future<String> _loadQuranVerseAsset() async {
    return await rootBundle.loadString('assets/new_quran_fonttext1.json');
  }

  //quran_translation
  Future<String> _loadQuranTranslationAsset() async {
    return await rootBundle.loadString('assets/quran_translations.json');
  }

  Future<List<QuranVerse>> fetchData() async {
    String jsonString = await _loadQuranVerseAsset();
    final jsonResponse = json.decode(jsonString);
    List<QuranVerse> data = [];
    for (var item in jsonResponse.values) {
      data.add(QuranVerse.fromJson(item));
    }

    // print(jsonResponse);
    return data;
  }

  //quran_translation
  Future<List<QuranTranslation>> translationData() async {
    String jsonString = await _loadQuranTranslationAsset();
    final jsonResponse = json.decode(jsonString);

    List<QuranTranslation> translations = [];
    for (var translationData in jsonResponse['data'].values) {
      if (translationData['translation_id'] == '2') {
        translations.add(QuranTranslation.fromJson(translationData));
      }
    }

    return translations;
  }

  Future<List<QuranTranslation>> translationData1() async {
    String jsonString = await _loadQuranTranslationAsset();
    final jsonResponse = json.decode(jsonString);

    List<QuranTranslation> translations1 = [];
    for (var translationData in jsonResponse['data'].values) {
      if (translationData['translation_id'] == '3') {
        translations1.add(QuranTranslation.fromJson(translationData));
      }
    }

    return translations1;
  }

  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateData();
      updateTranslation();
    });
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
        title: !isSearchMode
            ? Text(
                getSurahName(int.parse(selectedSurahId)),
                style: FlutterFlowTheme.of(context).title2.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFFBE6CC6),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
              )
            : TextField(
                controller: searchController,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                    icon: Icon(Icons.search,
                        color: Color.fromARGB(255, 28, 28, 28)),
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              ),
        actions: [
          IconButton(
            icon: isSearchMode ? Icon(Icons.close) : Icon(Icons.search),
            color: Color.fromARGB(255, 0, 0, 0),
            onPressed: () {
              setState(() {
                isSearchMode = !isSearchMode;
              });
            },
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: Center(
        child: quranWord == null && translation1 == null && translation2 == null
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  // DropdownButton<String>(
                  //   value: selectedSurahId.isNotEmpty ? selectedSurahId : null,
                  //   hint: const Text('Select Surah'),
                  //   items: surahIds
                  //       .map<DropdownMenuItem<String>>((String surahId) {
                  //     return DropdownMenuItem<String>(
                  //       value: surahId,
                  //       child: Text('Surah $surahId'),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       selectedSurahId = newValue!;
                  //     });
                  //   },
                  // ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: 280,
                  //     decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //           blurRadius: 12,
                  //           color: Color(0x33000000),
                  //           offset: Offset(0, 5),
                  //         )
                  //       ],
                  //       gradient: LinearGradient(
                  //         colors: [Color(0xFFA469A8), Color(0xFFDAADDB)],
                  //         stops: [0, 1],
                  //         begin: AlignmentDirectional(1, -1),
                  //         end: AlignmentDirectional(-1, 1),
                  //       ),
                  //       borderRadius: BorderRadius.circular(40),
                  //     ),
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         Padding(
                  //           padding:
                  //               EdgeInsetsDirectional.fromSTEB(0, 40, 0, 15),
                  //           child: Text(
                  //             getSurahName(int.parse(selectedSurahId)),
                  //             style: FlutterFlowTheme.of(context)
                  //                 .bodyText1
                  //                 .override(
                  //                   fontFamily: 'Poppins',
                  //                   color: Colors.white,
                  //                   fontSize: 22,
                  //                   fontWeight: FontWeight.w600,
                  //                 ),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding:
                  //               EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                  //           child: Text(
                  //             getSurahNameEnglish(int.parse(selectedSurahId)),
                  //             style: FlutterFlowTheme.of(context)
                  //                 .bodyText1
                  //                 .override(
                  //                   fontFamily: 'Poppins',
                  //                   color: Colors.white,
                  //                   fontSize: 20,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding:
                  //               EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  //           child: Text(
                  //             getPlaceOfRevelation(int.parse(selectedSurahId)) +
                  //                 " - " +
                  //                 getVerseCount(int.parse(selectedSurahId))
                  //                     .toString() +
                  //                 " VERSES ",
                  //             style: FlutterFlowTheme.of(context)
                  //                 .bodyText1
                  //                 .override(
                  //                     fontFamily: 'Poppins',
                  //                     color: Colors.white,
                  //                     fontSize: 20),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding:
                  //               EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  //           child: Text(
                  //             'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 35,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredData!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (selectedSurahId.isNotEmpty &&
                            quranWord![index].suraId != selectedSurahId) {
                          return SizedBox.shrink();
                        }

                        return Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10), // Add padding here
                                  child: Container(
                                    height: null, // Set height to null
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
                                            color: Color.fromARGB(
                                                255, 233, 198, 235),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 12,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.2),
                                                offset: Offset(0, 5),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 25),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFA469A8),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 12,
                                                            color: Color(
                                                                0x33000000),
                                                            offset:
                                                                Offset(0, 5),
                                                          )
                                                        ],
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: FittedBox(
                                                            child: Text(
                                                              quranWord![index]
                                                                  .aya!,
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Lato',
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      buttonSize: 45,
                                                      icon: Icon(
                                                        Icons.share_outlined,
                                                        color:
                                                            Color(0xFFBE6CC6),
                                                        size: 25,
                                                      ),
                                                      onPressed: () {
                                                        print(
                                                            'IconButton pressed ...');
                                                      },
                                                    ),
                                                    SizedBox(width: 10),
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      buttonSize: 45,
                                                      icon: Icon(
                                                        Icons
                                                            .bookmark_border_rounded,
                                                        color:
                                                            Color(0xFFBE6CC6),
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
                                                SingleChildScrollView(
                                                  child: Text(
                                                    quranWord![index].text!,
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                      fontFamily: 'QuranIrab',
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                SizedBox(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 10),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Text(
                                                        translation1?[index]
                                                                .text ??
                                                            '',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'QuranIrab',
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 234, 212, 237),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 12,
                                                          color: Color.fromARGB(
                                                              51, 0, 0, 0),
                                                          offset: Offset(0, 5),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      shape: BoxShape.rectangle,
                                                      // border: Border.all(
                                                      //   color: Color.fromARGB(
                                                      //       255, 137, 52, 139),
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                SizedBox(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 10),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Text(
                                                        translation2?[index]
                                                                .text ??
                                                            '',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'QuranIrab',
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 234, 212, 237),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 12,
                                                          color: Color.fromARGB(
                                                              51, 0, 0, 0),
                                                          offset: Offset(0, 5),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      shape: BoxShape.rectangle,
                                                      // border: Border.all(
                                                      //   color: Color.fromARGB(
                                                      //       255, 137, 52, 139),
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
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
    setState(() async {
      quranWord = await fetchData();
      surahIds = quranWord!.map((verse) => verse.suraId!).toSet().toList();
      filteredData = filterData(searchController.text);
    });
    // translation = await translationData();
  }

  Future<void> updateTranslation() async {
    var newData = await translationData();
    var newData1 = await translationData1();
    setState(() {
      // filter translations with translation_id = 2
      translation1 = newData;
    });
    setState(() {
      // filter translations with translation_id = 2
      translation2 = newData1;
    });
  }

  List<QuranVerse>? filterData(String query) {
    if (query.isNotEmpty) {
      return quranWord!.where((verse) {
        final suraName = surahNameById[verse.suraId!].toString().toLowerCase();
        final ayahText = verse.text!.toLowerCase();
        final queryLower = query.toLowerCase();
        return suraName.contains(queryLower) || ayahText.contains(queryLower);
      }).toList();
    } else {
      return quranWord;
    }
  }
}
