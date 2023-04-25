// class QuranVerseSearchDelegate extends SearchDelegate<QuranVerse> {
//   final List<QuranVerse>? quranWord;
//   final String surahId;

//   QuranVerseSearchDelegate(this.quranWord, this.surahId);

//   @override
//   String get searchFieldLabel => 'Search Quran...';

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     if (query.isEmpty) {
//       return Center(child: Text('Please enter a search term'));
//     }

//     final results = quranWord!
//         .where((verse) =>
//             verse.text!.toLowerCase().contains(query.toLowerCase()) &&
//                 verse.suraId!.toString().toLowerCase() == query.toLowerCase() &&
//                 verse.suraId == surahId ||
//             verse.aya!.toLowerCase() == query.toLowerCase() &&
//                 verse.suraId == surahId)
//         .toList();

//     if (results.isEmpty) {
//       return Center(child: Text('No results found'));
//     }

//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final verse = results[index];
//         return GestureDetector(
//           onTap: () {
//             // Jump to the original result
//             Navigator.pop(context, verse);
//           },
//           child: Container(
//             width: double.infinity,
//             height: null,
//             constraints: BoxConstraints(
//               maxWidth: double.infinity,
//             ),
//             decoration: BoxDecoration(
//               color: Color.fromARGB(255, 233, 198, 235),
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 12,
//                   color: Color.fromRGBO(0, 0, 0, 0.2),
//                   offset: Offset(0, 5),
//                 )
//               ],
//               borderRadius: BorderRadius.circular(50),
//               shape: BoxShape.rectangle,
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Color(0xFFA469A8),
//                           boxShadow: [
//                             BoxShadow(
//                               blurRadius: 12,
//                               color: Color(0x33000000),
//                               offset: Offset(0, 5),
//                             )
//                           ],
//                           shape: BoxShape.circle,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: FittedBox(
//                               child: Text(
//                                 verse.aya!,
//                                 style: GoogleFonts.getFont(
//                                   'Lato',
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w800,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SingleChildScrollView(
//                     child: Text(
//                       verse.text!,
//                       textAlign: TextAlign.right,
//                       style: const TextStyle(
//                         fontFamily: 'QuranIrab',
//                         fontSize: 25,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     if (query.isEmpty) {
//       return Container();
//     }

//     final results = quranWord!
//         .where((verse) =>
//             verse.text!.toLowerCase().contains(query.toLowerCase()) &&
//                 verse.suraId!.toString().toLowerCase() == query.toLowerCase() &&
//                 verse.suraId == surahId ||
//             verse.aya!.toLowerCase() == query.toLowerCase() &&
//                 verse.suraId == surahId)
//         .toList();

//     if (results.isEmpty) {
//       return Center(child: Text('No results found'));
//     }

//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final verse = results[index];
//         return Container(
//           width: double.infinity,
//           height: null,
//           constraints: BoxConstraints(
//             maxWidth: double.infinity,
//           ),
//           decoration: BoxDecoration(
//             color: Color.fromARGB(255, 233, 198, 235),
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 12,
//                 color: Color.fromRGBO(0, 0, 0, 0.2),
//                 offset: Offset(0, 5),
//               )
//             ],
//             borderRadius: BorderRadius.circular(50),
//             shape: BoxShape.rectangle,
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFFA469A8),
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 12,
//                             color: Color(0x33000000),
//                             offset: Offset(0, 5),
//                           )
//                         ],
//                         shape: BoxShape.circle,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: FittedBox(
//                             child: Text(
//                               verse.aya!,
//                               style: GoogleFonts.getFont(
//                                 'Lato',
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w800,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SingleChildScrollView(
//                   child: Text(
//                     verse.text!,
//                     textAlign: TextAlign.right,
//                     style: const TextStyle(
//                       fontFamily: 'QuranIrab',
//                       fontSize: 25,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           onTap: () {},
//         );
//       },
//     );
//   }
// }
