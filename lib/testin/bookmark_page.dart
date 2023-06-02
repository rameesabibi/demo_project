// import 'package:demo_project/surah/QuranVerseModel.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class BookmarkPage extends StatefulWidget {
//   const BookmarkPage({
//     Key? key,
//     required this.bookmarkedVerses,
//     required this.quranVerses,
//     required List<QuranVerse> quranBookmark,
//     required String surahId,
//     required bookmarks,
//     required folderNames,
//   }) : super(key: key);

//   final List<int> bookmarkedVerses;
//   final List<QuranVerse> quranVerses;

//   @override
//   _BookmarkPageState createState() => _BookmarkPageState();
// }

// class _BookmarkPageState extends State<BookmarkPage> {
//   late List<int> _bookmarked;
//   late List<String> _folderNames;

//   @override
//   void initState() {
//     super.initState();
//     _bookmarked = widget.bookmarkedVerses;
//     _loadFolderNames();
//   }

//   Future<void> _loadFolderNames() async {
//     final prefs = await SharedPreferences.getInstance();
//     final folderNames = prefs.getStringList('folderNames') ?? [];
//     setState(() {
//       _folderNames = folderNames;
//     });
//   }

//   Future<void> _saveFolderNames(List<String> folderNames) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('folderNames', folderNames);
//   }

//   void _removeBookmark(int index) {
//     setState(() {
//       _bookmarked.removeAt(index);
//     });
//   }

//   void _addFolder() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         String newFolderName = '';

//         return AlertDialog(
//           title: const Text('Add Folder'),
//           content: TextField(
//             onChanged: (value) {
//               newFolderName = value;
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 setState(() {
//                   _folderNames.add(newFolderName);
//                 });
//                 await _saveFolderNames(_folderNames);
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Add'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteFolder(int index) async {
//     setState(() {
//       _folderNames.removeAt(index);
//     });
//     await _saveFolderNames(_folderNames);
//   }

//   void _navigateToFolderPage(String folderName) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FolderPage(
//             folderName:
//                 folderName), // Replace FolderPage with the actual page you want to navigate to
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bookmarks'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           if (_folderNames.isNotEmpty)
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _folderNames.length,
//                 itemBuilder: (context, index) {
//                   final folderName = _folderNames[index];
//                   return Dismissible(
//                     key: UniqueKey(),
//                     onDismissed: (direction) => _deleteFolder(index),
//                     background: Container(color: Colors.red),
//                     child: ListTile(
//                       title: Text(
//                         folderName,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       onTap: () => _navigateToFolderPage(folderName),
//                     ),
//                   );
//                 },
//               ),
//             )
//           else
//             const Center(
//               child: Text('No bookmarks yet.'),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addFolder,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class FolderPage extends StatelessWidget {
//   final String folderName;

//   const FolderPage({Key? key, required this.folderName}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(folderName),
//       ),
//       body: Center(
//         child: Text('Folder Content'),
//       ),
//     );
//   }
// }
