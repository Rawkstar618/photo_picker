import 'package:flutter/material.dart';
import 'package:photo_picker_test/image_input_screen.dart';
import 'package:photo_picker_test/widget/hs_button_template.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int noOfPhotos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            style: TextStyle(color: Color.fromARGB(255, 250, 250, 250)),
            'Home Page'),
        backgroundColor: const Color.fromARGB(255, 36, 31, 45),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.background,
              const Color.fromARGB(255, 175, 63, 195)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HSButtonTemplate(
                  onPressed: () {
                    noOfPhotos = 4;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ImageInputScreen(noOfPhotos),
                      ),
                    );
                  },
                  text: '4\nPhotos'),
              const SizedBox(
                height: 50,
              ),
              HSButtonTemplate(
                  onPressed: () {
                    noOfPhotos = 6;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ImageInputScreen(noOfPhotos),
                      ),
                    );
                  },
                  text: '6\nPhotos'),
              const SizedBox(
                height: 50,
              ),
              HSButtonTemplate(
                  onPressed: () {
                    noOfPhotos = 8;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ImageInputScreen(noOfPhotos),
                      ),
                    );
                  },
                  text: '8\nPhotos')
            ],
          ),
        ),
      ),
    );
  }
}
