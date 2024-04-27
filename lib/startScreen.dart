import 'package:flutter/material.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _pageController = PageController();
  File? _image;
  List<String> images = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image3.jpeg',
    'assets/images/image4.jpeg',
  ]; // Replace with your images
  int currentImageIndex = 0;

  _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    _pageController.nextPage(
      duration: Duration(milliseconds: 2000),
      curve: Curves.ease,
    );
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        _image = File(croppedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Face Search',
            style: TextStyle(
                color: Color(0xFF895EF5),
                fontWeight: FontWeight.bold,
                fontSize: 24.0),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 2.0,
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0), // Adjust this value as needed
              Text(
                'Find that dude',
                style: TextStyle(
                    color: Color(0xFF895EF5),
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0),
              ),
              SizedBox(height: 20.0), // Adjust this value as needed
              Text(
                "   Find out anyone on interent with just a photo",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              SizedBox(height: 20.0),
              Lottie.asset('assets/welcome.json'),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF895EF5),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  'Pick Image',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  await _getFromGallery(); // Replace with your function to pick image

                  // _pageController.nextPage(
                  //   duration: Duration(milliseconds: 500),
                  //   curve: Curves.ease,
                  // );

                  await Future.delayed(Duration(seconds: 7));

                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 120.0), // Adjust this value as needed
              Lottie.asset('assets/processing.json'),
              Text(
                'Searching on the world wide web.....',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF895EF5),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      bottom: 50.0), // Adjust this value as needed
                  child: Center(
                      child: Text(
                    'Results',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF895EF5),
                    ),
                  )),
                ),
                StreamBuilder<int>(
                  stream: Stream.periodic(Duration(seconds: 2), (i) => i + 1)
                      .take(images.length),
                  builder: (context, snapshot) {
                    return Column(
                      children: List.generate(snapshot.data ?? 0, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors
                                  .blue, // Change the border color as you like
                              width: 2, // Change the border width as you like
                            ),
                          ),
                          child: Image.asset(images[index]),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
