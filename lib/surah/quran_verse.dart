import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import '../bookmark_page.dart';
import '../flutter_flow/flutter_flow_icon_button copy.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme copy.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'QuranTranslation.dart';
import 'QuranVerseModel.dart';

import 'flutter_flow/flutter_flow_icon_button copy.dart';
import 'flutter_flow/flutter_flow_theme copy.dart';
import 'package:quran/quran.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

//quran_translation
//test

class QuranVerseScreen extends StatefulWidget {
  final String surahId;
  const QuranVerseScreen({required this.surahId, Key? key}) : super(key: key);

  @override
  _QuranVerseScreenState createState() => _QuranVerseScreenState();
}

class _QuranVerseScreenState extends State<QuranVerseScreen> {
  List<QuranVerse>? quranWord;

  //quran_translation
  List<QuranTranslation>? translation1;
  List<QuranTranslation>? translation2;
  List<String> surahIds = [];
  List<QuranTranslation>? translation;
  late List<int> _bookmarkedVerses;

  // String selectedSurahId = '1';

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

    // print(jsonResponse);
    return data;
  }

  //quran_translation
  Future<String> _loadQuranTranslationAsset() async {
    return await rootBundle.loadString('assets/quran_translations.json');
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateData();
      updateTranslation();
      _getBookmarkedVerses();
    });
  }

  Future<void> _getBookmarkedVerses() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarkedVerses = prefs.getStringList('bookmarkedVerses') ?? [];
    setState(() {
      _bookmarkedVerses = bookmarkedVerses.map(int.parse).toList();
    });
  }

  Future<void> _saveBookmarkedVerses() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarkedVerses =
        _bookmarkedVerses.map((v) => v.toString()).toList();
    await prefs.setStringList('bookmarkedVerses', bookmarkedVerses);
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          getSurahName(int.parse(widget.surahId)),
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
            color: Color(0xFFBE6CC6),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: QuranVerseSearchDelegate(
                    quranWord,
                    widget.surahId,
                    translation1,
                    translation2,
                  ));
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: quranWord!.length,
                      itemBuilder: (context, index) {
                        if (widget.surahId.isNotEmpty &&
                            quranWord![index].suraId != widget.surahId) {
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
                                                        _bookmarkedVerses
                                                                .contains(index)
                                                            ? Icons.bookmark
                                                            : Icons
                                                                .bookmark_border_rounded,
                                                        color:
                                                            Color(0xFFBE6CC6),
                                                        size: 25,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          if (_bookmarkedVerses
                                                              .contains(
                                                                  index)) {
                                                            _bookmarkedVerses
                                                                .remove(index);
                                                          } else {
                                                            _bookmarkedVerses
                                                                .add(index);
                                                          }
                                                          _saveBookmarkedVerses();
                                                        });
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                BookmarkPage(
                                                              bookmarkedVerses:
                                                                  _bookmarkedVerses,
                                                              quranBookmark:
                                                                  quranWord!,
                                                              surahId: widget
                                                                  .surahId, // Pass the value
                                                            ),
                                                          ),
                                                        );
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
    try {
      quranWord = await fetchData();
      surahIds = quranWord!.map((verse) => verse.suraId!).toSet().toList();
      setState(() {});
      print(surahIds);
    } catch (e) {
      print(e);
    }
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
}

class QuranVerseSearchDelegate extends SearchDelegate<QuranVerse> {
  final List<QuranVerse>? quranWord;
  final List<QuranTranslation>? translation1;
  final List<QuranTranslation>? translation2;
  final String surahId;

  QuranVerseSearchDelegate(
      this.quranWord, this.surahId, this.translation1, this.translation2);

  @override
  String get searchFieldLabel => 'Search Quran...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Please enter a search term'));
    }

    final results = quranWord!
        .where((verse) =>
            verse.text!.toLowerCase().contains(query.toLowerCase()) &&
                verse.suraId!.toString().toLowerCase() == query.toLowerCase() &&
                verse.text == surahId ||
            verse.aya!.toLowerCase() == query.toLowerCase() &&
                verse.suraId == surahId)
        .toList();

    if (results.isEmpty) {
      return Center(child: Text('No results found'));
    }

    final translation1Result = translation1!
        .where((t1) =>
            t1.text.toLowerCase().contains(query.toLowerCase()) &&
                t1.sura_id.toString().toLowerCase() == query.toLowerCase() &&
                t1.sura_id == surahId ||
            t1.aya.toLowerCase() == query.toLowerCase() &&
                t1.sura_id == surahId)
        .toList();

    if (translation1Result.isEmpty) {
      return Center(child: Text('No results found'));
    }

    final translation2Result = translation2!
        .where((t2) =>
            t2.text.toLowerCase().contains(query.toLowerCase()) &&
                t2.sura_id.toString().toLowerCase() == query.toLowerCase() &&
                t2.sura_id == surahId ||
            t2.aya.toLowerCase() == query.toLowerCase() &&
                t2.sura_id == surahId)
        .toList();

    if (translation2Result.isEmpty) {
      return Center(child: Text('No results found'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final verse = results[index];
        final t1 = translation1Result[index];
        final t2 = translation2Result[index];

        return GestureDetector(
          onTap: () {
            // Jump to the original result
            Navigator.pop(context, verse);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              width: double.infinity,
              height: null,
              constraints: BoxConstraints(
                maxWidth: double.infinity,
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 233, 198, 235),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    offset: Offset(0, 5),
                  )
                ],
                borderRadius: BorderRadius.circular(50),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: FittedBox(
                                child: Text(
                                  verse.aya!,
                                  style: GoogleFonts.getFont(
                                    'Lato',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Text(
                        verse.text!,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontFamily: 'QuranIrab',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: SingleChildScrollView(
                          child: Text(
                            t1.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'QuranIrab',
                              fontSize: 15,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 234, 212, 237),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              color: Color.fromARGB(51, 0, 0, 0),
                              offset: Offset(0, 5),
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                          shape: BoxShape.rectangle,
                          // border: Border.all(
                          //   color: Color.fromARGB(
                          //       255, 137, 52, 139),
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: SingleChildScrollView(
                          child: Text(
                            t2.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'QuranIrab',
                              fontSize: 15,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 234, 212, 237),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              color: Color.fromARGB(51, 0, 0, 0),
                              offset: Offset(0, 5),
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                          shape: BoxShape.rectangle,
                          // border: Border.all(
                          //   color: Color.fromARGB(
                          //       255, 137, 52, 139),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    final results = quranWord!
        .where((verse) =>
            verse.text!.toLowerCase().contains(query.toLowerCase()) &&
                verse.suraId!.toString().toLowerCase() == query.toLowerCase() &&
                verse.text == surahId ||
            verse.aya!.toLowerCase() == query.toLowerCase() &&
                verse.suraId == surahId)
        .toList();

    if (results.isEmpty) {
      return Center(child: Text('No results found'));
    }

    final translation1Result = translation1!
        .where((t1) =>
            t1.text.toLowerCase().contains(query.toLowerCase()) &&
                t1.sura_id.toString().toLowerCase() == query.toLowerCase() &&
                t1.sura_id == surahId ||
            t1.aya.toLowerCase() == query.toLowerCase() &&
                t1.sura_id == surahId)
        .toList();

    if (translation1Result.isEmpty) {
      return Center(child: Text('No results found'));
    }
    final translation2Result = translation2!
        .where((t2) =>
            t2.text.toLowerCase().contains(query.toLowerCase()) &&
                t2.sura_id.toString().toLowerCase() == query.toLowerCase() &&
                t2.sura_id == surahId ||
            t2.aya.toLowerCase() == query.toLowerCase() &&
                t2.sura_id == surahId)
        .toList();

    if (translation2Result.isEmpty) {
      return Center(child: Text('No results found'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final verse = results[index];
        final t1 = translation1Result[index];
        final t2 = translation2Result[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            width: double.infinity,
            height: null,
            constraints: BoxConstraints(
              maxWidth: double.infinity,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 233, 198, 235),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12,
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  offset: Offset(0, 5),
                )
              ],
              borderRadius: BorderRadius.circular(50),
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Text(
                                verse.aya!,
                                style: GoogleFonts.getFont(
                                  'Lato',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Text(
                      verse.text!,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontFamily: 'QuranIrab',
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: SingleChildScrollView(
                        child: Text(
                          t1.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'QuranIrab',
                            fontSize: 15,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 212, 237),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            color: Color.fromARGB(51, 0, 0, 0),
                            offset: Offset(0, 5),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        // border: Border.all(
                        //   color: Color.fromARGB(
                        //       255, 137, 52, 139),
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: SingleChildScrollView(
                        child: Text(
                          t2.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'QuranIrab',
                            fontSize: 15,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 212, 237),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            color: Color.fromARGB(51, 0, 0, 0),
                            offset: Offset(0, 5),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        // border: Border.all(
                        //   color: Color.fromARGB(
                        //       255, 137, 52, 139),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
