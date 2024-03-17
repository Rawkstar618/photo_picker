import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final Map<int, Map<int, File>> imageList = {};

class SelectImage extends StatefulWidget {
  const SelectImage({required this.noOfPhotos, required this.index, super.key});
  final int index, noOfPhotos;

  @override
  State<SelectImage> createState() {
    return _SelectImageState();
  }
}

class _SelectImageState extends State<SelectImage> {
  late File _selectedPicture;
  void _selectPicture() async {
    final imgPicker = ImagePicker();
    final pickedImg =
        await imgPicker.pickImage(source: ImageSource.gallery, maxHeight: 250);
    if (pickedImg == null) {
      return;
    }
    setState(
      () {
        _selectedPicture = File(pickedImg.path);
        imageList.addAll(
          {
            widget.noOfPhotos: {widget.index: _selectedPicture},
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
        backgroundColor: const MaterialStatePropertyAll(
          Color.fromARGB(255, 214, 171, 237),
        ),
        minimumSize: MaterialStateProperty.all(
          const Size.square(150),
        ),
      ),
      icon:
          const Icon(color: Color.fromARGB(255, 65, 1, 76), Icons.add_a_photo),
      onPressed: _selectPicture,
      label: const Text(
          style: TextStyle(
            color: Color.fromARGB(255, 65, 1, 76),
          ),
          'Select'),
    );
    if (imageList.containsKey(widget.noOfPhotos)) {
      if (imageList[widget.noOfPhotos]!.containsKey(widget.index)) {
        content = GestureDetector(
          onTap: _selectPicture,
          child: Image.file(
            _selectedPicture,
            fit: BoxFit.cover,
            height: 150,
            width: 150,
          ),
        );
      }
    }
    return content;
  }
}
