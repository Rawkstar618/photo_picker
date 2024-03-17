import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:photo_picker_test/widget/select_image.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'images.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE images_table(index REAL PRIMARY KEY, image TEXT)');
    },
    version: 1,
  );
  return db;
}

class ImageInputScreen extends StatefulWidget {
  final int noOfPhotos;
  const ImageInputScreen(this.noOfPhotos, {super.key});

  @override
  State<ImageInputScreen> createState() {
    return _ImageInputScreenState();
  }
}

class _ImageInputScreenState extends State<ImageInputScreen> {
  void loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('images_table');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).colorScheme.background,
              const Color.fromARGB(255, 175, 63, 195)
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectImage(noOfPhotos: widget.noOfPhotos, index: 1),
                  const SizedBox(width: 10),
                  SelectImage(noOfPhotos: widget.noOfPhotos, index: 2),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectImage(noOfPhotos: widget.noOfPhotos, index: 3),
                  const SizedBox(width: 10),
                  SelectImage(noOfPhotos: widget.noOfPhotos, index: 4),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            if (widget.noOfPhotos >= 6)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectImage(noOfPhotos: widget.noOfPhotos, index: 5),
                    const SizedBox(width: 10),
                    SelectImage(noOfPhotos: widget.noOfPhotos, index: 6),
                  ],
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            if (widget.noOfPhotos == 8)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectImage(noOfPhotos: widget.noOfPhotos, index: 7),
                    const SizedBox(width: 10),
                    SelectImage(noOfPhotos: widget.noOfPhotos, index: 8),
                  ],
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 214, 171, 237),
                    ),
                  ),
                  onPressed: () async {
                    final imgDir =
                        await syspaths.getApplicationDocumentsDirectory();
                    //final fileName = path.basename(imageList[])
                    if (imageList[widget.noOfPhotos] == null) {
                      return;
                    }
                    final Map<int, String> saveDataCopy = {};
                    String fileName;
                    File imgCopy;
                    for (var key in imageList[widget.noOfPhotos]!.keys) {
                      fileName = path
                          .basename(imageList[widget.noOfPhotos]![key]!.path);
                      imgCopy = await imageList[widget.noOfPhotos]![key]!
                          .copy('${imgDir.path}/$fileName');
                      saveDataCopy.addAll({key: imgCopy.path});
                    }
                    double index;
                    for (var key in saveDataCopy.keys) {
                      index = widget.noOfPhotos + (0.1 * key);
                      final db = await _getDatabase();
                      db.insert(
                        'images_table',
                        {
                          'index': index,
                          'image': saveDataCopy[key],
                        },
                      );
                    }
                  },
                  child: const Text(
                      style: TextStyle(
                        color: Color.fromARGB(255, 65, 1, 76),
                      ),
                      'Save'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 214, 171, 237),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                      style: TextStyle(
                        color: Color.fromARGB(255, 65, 1, 76),
                      ),
                      'Done'),
                ),
                const SizedBox(
                  width: 50,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
