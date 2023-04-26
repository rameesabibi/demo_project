// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:convert';

// import '../flutter_flow/flutter_flow_icon_button.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import 'QuranTranslation.dart';
// import 'flutter_flow/flutter_flow_icon_button copy.dart';
// import 'flutter_flow/flutter_flow_theme copy.dart';
// import 'package:quran/quran.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class QuranVerse {
//   final String? suraId;
//   final String? aya;
//   final String? text;

//   QuranVerse({
//     this.suraId,
//     this.aya,
//     this.text,
//   });

//   factory QuranVerse.fromJson(Map<String, dynamic> json) {
//     return QuranVerse(
//       suraId: json['sura_id'] as String,
//       aya: json['aya'] as String,
//       text: json['text'] as String,
//     );
//   }

//   get ayahNumber => null;
// }

// //quran_translation
// // class QuranTranslation {
// //   final String? suraId_translation;
// //   final String? aya_translation;
// //   final String? text_translation;

// //   QuranTranslation({
// //     this.suraId_translation,
// //     this.aya_translation,
// //     this.text_translation,
// //   });

// //   factory QuranTranslation.fromJson(Map<String, dynamic> json) {
// //     return QuranTranslation(
// //       suraId_translation: json['sura_id'] as String,
// //       aya_translation: json['aya'] as String,
// //       text_translation: json['text'] as String,
// //     );
// //   }
// // }

// class QuranVerseScreen extends StatefulWidget {
//   const QuranVerseScreen({Key? key}) : super(key: key);

//   @override
//   _QuranVerseScreenState createState() => _QuranVerseScreenState();
// }

// class _QuranVerseScreenState extends State<QuranVerseScreen> {
//   List<QuranVerse>? quranWord;

//   //quran_translation
//   List? translation;

//   List<String> surahIds = [];
//   String selectedSurahId = '1';

//   get surahNames => null;

//   Future<String> _loadQuranVerseAsset() async {
//     return await rootBundle.loadString('assets/new_quran_fonttext1.json');
//   }

// //quran_translation
//   Future<String> _loadQuranTranslationAsset() async {
//     return await rootBundle
//         .loadString('assets/quran_translations-1680683324.json');
//   }

//   Future<List<QuranVerse>> fetchData() async {
//     String jsonString = await _loadQuranVerseAsset();
//     final jsonResponse = json.decode(jsonString);
//     List<QuranVerse> data = [];
//     for (var item in jsonResponse.values) {
//       data.add(QuranVerse.fromJson(item));
//     }

//     // print(jsonResponse);
//     return data;
//   }

// //quran_translation
//   Future<List> translationData() async {
//     // print('fetching');
//     String jsonString1 = await _loadQuranTranslationAsset();
//     final jsonResponse1 = json.decode(jsonString1);

//     // for (var item1 in jsonResponse1.values) {
//     //   print(item1);
//     //   data1.add(QuranTranslation.fromJson(item1));
//     // }
//     var jsons = jsonResponse1['data'];
//     var ayahData =
//         jsons.entries.map((e) => QuranTranslation.fromJson(e.value)).toList();

//     // var data = ayahData.map((e) => QuranTranslation.fromJson(e)).toList();
//     // print(data);
//     return ayahData;
//   }

//   @override
//   void initState() {
//     super.initState();
//     updateData();
//     updateTranslation();
//     // filterTranslation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFF1E2F2),
//         automaticallyImplyLeading: false,
//         leading: FlutterFlowIconButton(
//           borderColor: Colors.transparent,
//           borderRadius: 30,
//           borderWidth: 1,
//           buttonSize: 60,
//           icon: Icon(
//             Icons.arrow_back_rounded,
//             color: Color(0xFF424242),
//             size: 30,
//           ),
//           onPressed: () async {
//             context.pop();
//           },
//         ),
//         title: Text(
//           getSurahName(int.parse(selectedSurahId)),
//           style: FlutterFlowTheme.of(context).title2.override(
//                 fontFamily: 'Poppins',
//                 color: Color(0xFFBE6CC6),
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             color: Color(0xFF424242),
//             onPressed: () {
//               // Do something when the search button is pressed
//             },
//           ),
//         ],
//         centerTitle: false,
//         elevation: 2,
//       ),
//       body: Center(
//         child: quranWord == null && translation == null
//             ? const CircularProgressIndicator()
//             : Column(
//                 children: [
//                   DropdownButton<String>(
//                     value: selectedSurahId.isNotEmpty ? selectedSurahId : null,
//                     hint: const Text('Select Surah'),
//                     items: surahIds
//                         .map<DropdownMenuItem<String>>((String surahId) {
//                       return DropdownMenuItem<String>(
//                         value: surahId,
//                         child: Text('Surah $surahId'),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedSurahId = newValue!;
//                       });
//                     },
//                   ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
//                     child: Container(
//                       width: double.infinity,
//                       height: 280,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 12,
//                             color: Color(0x33000000),
//                             offset: Offset(0, 5),
//                           )
//                         ],
//                         gradient: LinearGradient(
//                           colors: [Color(0xFFA469A8), Color(0xFFDAADDB)],
//                           stops: [0, 1],
//                           begin: AlignmentDirectional(1, -1),
//                           end: AlignmentDirectional(-1, 1),
//                         ),
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 20, 0, 15),
//                             child: Text(
//                               getSurahName(int.parse(selectedSurahId)),
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyText1
//                                   .override(
//                                     fontFamily: 'Poppins',
//                                     color: Colors.white,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                             child: Text(
//                               getSurahNameEnglish(int.parse(selectedSurahId)),
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyText1
//                                   .override(
//                                     fontFamily: 'Poppins',
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
//                             child: Text(
//                               getPlaceOfRevelation(int.parse(selectedSurahId)) +
//                                   " - " +
//                                   getVerseCount(int.parse(selectedSurahId))
//                                       .toString() +
//                                   " VERSES ",
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyText1
//                                   .override(
//                                       fontFamily: 'Poppins',
//                                       color: Colors.white,
//                                       fontSize: 20),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                             child: Text(
//                               'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 30,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: quranWord!.length,
//                       itemBuilder: (context, index) {
//                         if (selectedSurahId.isNotEmpty &&
//                             quranWord![index].suraId != selectedSurahId) {
//                           return SizedBox.shrink();
//                         }

//                         return Column(
//                           children: [
//                             Column(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 10,
//                                       vertical: 8), // Add padding here
//                                   child: Container(
//                                     height: null, // Set height to null
//                                     width: 380,
//                                     child: LayoutBuilder(
//                                       builder: (BuildContext context,
//                                           BoxConstraints constraints) {
//                                         return Container(
//                                           width: double.infinity,
//                                           height: null,
//                                           constraints: BoxConstraints(
//                                             maxWidth: double.infinity,
//                                             maxHeight: constraints.maxHeight,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Color(0xFFEDD1EE),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 blurRadius: 12,
//                                                 color: Color(0x33000000),
//                                                 offset: Offset(0, 5),
//                                               )
//                                             ],
//                                             borderRadius:
//                                                 BorderRadius.circular(50),
//                                             shape: BoxShape.rectangle,
//                                           ),
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 20, vertical: 15),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.stretch,
//                                               children: [
//                                                 Row(
//                                                   mainAxisSize:
//                                                       MainAxisSize.max,
//                                                   children: [
//                                                     Container(
//                                                       decoration: BoxDecoration(
//                                                         color:
//                                                             Color(0xFFA469A8),
//                                                         boxShadow: [
//                                                           BoxShadow(
//                                                             blurRadius: 12,
//                                                             color: Color(
//                                                                 0x33000000),
//                                                             offset:
//                                                                 Offset(0, 5),
//                                                           )
//                                                         ],
//                                                         shape: BoxShape.circle,
//                                                       ),
//                                                       child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Align(
//                                                           alignment:
//                                                               Alignment.center,
//                                                           child: FittedBox(
//                                                             child: Text(
//                                                               quranWord![index]
//                                                                   .aya!,
//                                                               style: GoogleFonts
//                                                                   .getFont(
//                                                                 'Lato',
//                                                                 color: Colors
//                                                                     .white,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w800,
//                                                                 fontSize: 20,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Spacer(),
//                                                     FlutterFlowIconButton(
//                                                       borderColor:
//                                                           Colors.transparent,
//                                                       buttonSize: 45,
//                                                       icon: Icon(
//                                                         Icons.share_outlined,
//                                                         color:
//                                                             Color(0xFFBE6CC6),
//                                                         size: 25,
//                                                       ),
//                                                       onPressed: () {
//                                                         print(
//                                                             'IconButton pressed ...');
//                                                       },
//                                                     ),
//                                                     SizedBox(width: 10),
//                                                     FlutterFlowIconButton(
//                                                       borderColor:
//                                                           Colors.transparent,
//                                                       buttonSize: 45,
//                                                       icon: Icon(
//                                                         Icons
//                                                             .bookmark_border_rounded,
//                                                         color:
//                                                             Color(0xFFBE6CC6),
//                                                         size: 25,
//                                                       ),
//                                                       onPressed: () async {
//                                                         final CollectionReference
//                                                             bookmarksCollection =
//                                                             FirebaseFirestore
//                                                                 .instance
//                                                                 .collection(
//                                                                     'bookmarks');
//                                                         try {
//                                                           await bookmarksCollection
//                                                               .add({
//                                                             'userId':
//                                                                 'user123', // replace with the actual user ID
//                                                             'timestamp':
//                                                                 DateTime.now(),
//                                                             // add other bookmark properties as needed
//                                                           });
//                                                           showDialog(
//                                                             context: context,
//                                                             builder:
//                                                                 (BuildContext
//                                                                     context) {
//                                                               return AlertDialog(
//                                                                 title: Text(
//                                                                     'Bookmark'),
//                                                                 content: Text(
//                                                                     'Bookmark added.'),
//                                                                 actions: [
//                                                                   TextButton(
//                                                                     child: Text(
//                                                                         'OK'),
//                                                                     onPressed:
//                                                                         () {
//                                                                       Navigator.of(
//                                                                               context)
//                                                                           .pop();
//                                                                     },
//                                                                   ),
//                                                                 ],
//                                                               );
//                                                             },
//                                                           );
//                                                         } catch (e) {
//                                                           print(e.toString());
//                                                         }
//                                                       },
//                                                     )
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: 10),
//                                                 SingleChildScrollView(
//                                                   child: Text(
//                                                     quranWord![index].text!,
//                                                     textAlign: TextAlign.end,
//                                                     style: const TextStyle(
//                                                       fontFamily: 'QuranIrab',
//                                                       fontSize: 20,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 10),
//                                                 SingleChildScrollView(
//                                                   child: Text(
//                                                     translation?[index].text ??
//                                                         '',
//                                                     textAlign: TextAlign.end,
//                                                     style: const TextStyle(
//                                                       fontFamily: 'QuranIrab',
//                                                       fontSize: 20,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }

//   Future<void> updateData() async {
//     try {
//       quranWord = await fetchData();
//       surahIds = quranWord!.map((verse) => verse.suraId!).toSet().toList();
//       setState(() {});
//       // translation = await translationData();
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> updateTranslation() async {
//     try {
//       translation = await translationData();
//       // surahIds = quranWord!.map((verse) => verse.suraId!).toSet().toList();
//       setState(() {});

//       // translation = await translationData();
//     } catch (e) {
//       print('translation' + e.toString());
//     }
//   }
// }
