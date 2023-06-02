// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class BookmarkProvider with ChangeNotifier {
//   late List<int> _bookmarked;
//   List<String> _folders = [];
//   String? _selectedFolderName;

//   List<int> get bookmarkedVerses => _bookmarked;
//   List<String> get folders => _folders;
//   String? get selectedFolderName => _selectedFolderName;

//   BookmarkProvider(String surahId) {
//     _loadBookmarks(surahId);
//     _loadFolders();
//   }

//   get surahId => null;

//   get selectedVerses => null;

//   set newFolderName(String newFolderName) {}

//   void _loadBookmarks(String surahId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final key = 'bookmarks_$surahId';
//     _bookmarked = prefs.getStringList(key)?.map(int.parse).toList() ?? [];
//   }

//   void addBookmark(int verse) {
//     _bookmarked.add(verse);
//     _saveBookmarks();
//     notifyListeners();
//   }

//   void removeBookmark(int index) {
//     _bookmarked.removeAt(index);
//     _saveBookmarks();
//     notifyListeners();
//   }

//   void _loadFolders() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _folders = prefs.getStringList('folders') ?? [];
//     notifyListeners();
//   }

//   void addFolder(String name) {
//     _folders.add(name);
//     _saveFolders();
//     notifyListeners();
//   }

//   void removeFolder(int index) {
//     _folders.removeAt(index);
//     _saveFolders();
//     notifyListeners();
//   }

//   void _saveFolders() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('folders', _folders);
//   }

//   void _saveBookmarks() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final key = 'bookmarks_${surahId}';
//     await prefs.setStringList(
//         key, _bookmarked.map((v) => v.toString()).toList());
//   }

//   void selectFolder(String name) {
//     _selectedFolderName = name;
//     notifyListeners();
//   }

//   void updateNewFolderName(String name) {
//     notifyListeners();
//   }

//   void clearSelectedFolder() {
//     _selectedFolderName = null;
//     notifyListeners();
//   }

//   void clearNewFolderName() {
//     notifyListeners();
//   }

//   void addNewFolder() {}
// }
