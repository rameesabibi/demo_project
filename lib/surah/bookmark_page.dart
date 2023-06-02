import 'package:demo_project/surah/QuranVerseModel.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow/flutter_flow_theme copy.dart';
import 'package:flutter/material.dart';

class Folder {
  final String name;
  final List<Map<String, dynamic>> data;
  bool isExpanded;

  Folder(this.name, this.data, {this.isExpanded = false});
}

class BookmarkPage extends StatefulWidget {
  final String surahId;

  const BookmarkPage({
    Key? key,
    required this.surahId,
    required String selectedFolder,
    required String aya,
  }) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late List<int> _bookmarked;
  List<Folder> _folders = []; // List to store folders
  TextEditingController _folderNameController =
      TextEditingController(); // Controller for folder name text field

  void _deleteFolder(Folder folder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Folder'),
          content: Text('Are you sure you want to delete ${folder.name}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _folders.remove(folder);
                  _saveFolders();
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveBookmarkedVerses() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarkedVerses = _bookmarked.map((v) => v.toString()).toList();
    await prefs.setStringList('bookmarkedVerses', bookmarkedVerses);
  }

  Future<void> _getFolders() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFolders = prefs.getStringList('folders');
    if (savedFolders != null) {
      setState(() {
        _folders = savedFolders
            .map((folderString) => Folder(folderString, []))
            .toList();
      });
    }
  }

  void _createFolder() {
    setState(() {
      final folderName = _folderNameController.text.trim();
      if (folderName.isNotEmpty) {
        _folders.add(Folder(folderName, []));
        _folderNameController.clear();
        _saveFolders();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Folder created: $folderName'),
          ),
        );
      }
    });
  }

  void _editFolder(Folder folder, String newFolderName) {
    setState(() {
      final index = _folders.indexOf(folder);
      if (index != -1) {
        _folders[index] = Folder(newFolderName, folder.data);
        _saveFolders();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Folder edited: $newFolderName'),
          ),
        );
      }
    });
  }

  Future<void> _saveFolders() async {
    final prefs = await SharedPreferences.getInstance();
    final folderNames = _folders.map((folder) => folder.name).toList();
    await prefs.setStringList('folders', folderNames);
  }

  @override
  void initState() {
    super.initState();
    _getFolders(); // Load saved folders
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (_folders.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _folders.length,
                itemBuilder: (context, index) {
                  final folder = _folders[index];
                  return Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.blue,
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.folder,
                            color:
                                folder.isExpanded ? Colors.blue : Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text(
                            folder.name,
                            style: TextStyle(
                              color: folder.isExpanded
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        folder.isExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          folder.isExpanded = expanded;
                        });
                      },
                      children: [
                        if (folder.data.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: folder.data.length,
                            itemBuilder: (context, index) {
                              final data = folder.data[index];
                              final number = data['aya'];
                              final verse = data['verse'];
                              return ListTile(
                                title: Text(''),
                                // Add your verse-specific logic here
                              );
                            },
                          ),
                        if (folder.data.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('No verses added.'),
                          ),
                        ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Edit Folder'),
                          onTap: () {
                            _showEditFolderDialog(folder);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Delete Folder'),
                          onTap: () {
                            _deleteFolder(folder);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          if (_folders.isEmpty)
            const Expanded(
              child: Center(
                child: Text('No folders yet.'),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateFolderDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEditFolderDialog(Folder folder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newFolderName = folder.name;
        TextEditingController _editFolderNameController = TextEditingController(
          text: folder.name,
        ); // Controller for edit folder name text field

        return AlertDialog(
          title: const Text('Edit Folder Name'),
          content: TextField(
            controller: _editFolderNameController,
            onChanged: (value) {
              newFolderName = value;
            },
            decoration: InputDecoration(
              labelText: 'New Folder Name',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _editFolder(folder, newFolderName);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showCreateFolderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Folder'),
          content: TextField(
            controller: _folderNameController,
            decoration: const InputDecoration(
              labelText: 'Folder Name',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _createFolder();
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
