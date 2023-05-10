import 'package:demo_project/surah/QuranVerseModel.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

import 'flutter_flow/flutter_flow_theme copy.dart';

class BookmarkPage extends StatefulWidget {
  final List<int> bookmarkedVerses;
  final List<QuranVerse> quranBookmark;
  final String surahId;
  // New parameter

  const BookmarkPage({
    Key? key,
    required this.bookmarkedVerses,
    required this.quranBookmark,
    required this.surahId,
    // Updated constructor
  }) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late List<int> _bookmarked;

  void _removeBookmark(int index) {
    setState(() {
      _bookmarked.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _bookmarked = widget.bookmarkedVerses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        centerTitle: true,
      ),
      body: _bookmarked.isEmpty
          ? const Center(
              child: Text('No bookmarks yet.'),
            )
          : ListView.builder(
              itemCount: _bookmarked.length,
              itemBuilder: (context, index) {
                final int itemIndex = _bookmarked[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      getSurahName(
                          int.parse(widget.quranBookmark[itemIndex].suraId!)),
                      style: FlutterFlowTheme.of(context).title2.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFFBE6CC6),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.quranBookmark[itemIndex].aya!,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontFamily: 'QuranIrab',
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.quranBookmark[itemIndex].text!,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontFamily: 'QuranIrab',
                        fontSize: 25,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _removeBookmark(index),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
