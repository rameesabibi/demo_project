import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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
        title: Text('Quran Verses'),
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
                            if (index == 0 ||
                                data![index].suraId != data![index - 1].suraId)
                              SizedBox(height: 10),
                            if (index == 0 ||
                                data![index].suraId != data![index - 1].suraId)
                              Text(
                                'Surah ${data![index].suraId}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ListTile(
                              title: Text(
                                data![index].aya!,
                                style: const TextStyle(
                                  fontFamily: 'QuranIrab',
                                  fontSize: 20,
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                              subtitle: Text(
                                data![index].text!,
                                style: const TextStyle(
                                  fontFamily: 'QuranIrab',
                                  fontSize: 20,
                                ),
                                textDirection: TextDirection.rtl,
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
