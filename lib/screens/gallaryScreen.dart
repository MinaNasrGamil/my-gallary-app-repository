import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygallary_app/providers/gallaryProvider.dart';
import 'package:provider/provider.dart';
//import 'package:image_picker/image_picker.dart';

class GallaryScreen extends StatefulWidget {
  static const routeName = '/gallary-screen';
  const GallaryScreen({super.key});

  @override
  State<GallaryScreen> createState() => _GallaryScreenState();
}

class _GallaryScreenState extends State<GallaryScreen> {
  File? _image;
  final picker = ImagePicker();
  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    try {
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          print('this is imaaage $_image');
          Provider.of<MyImagesProvider>(context, listen: false)
              .addImage(_image!, context);
        });
      } else {
        print('no image added!');
      }
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print('this is imaaage $_image');
        Provider.of<MyImagesProvider>(context, listen: false)
            .addImage(_image!, context);
      });
    } else {
      print('no image added!');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List img = Provider.of<MyImagesProvider>(context).myImages;
    print(img[1]);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/backGround_2.PNG"),
          fit: BoxFit.cover,
        )),
        child: Center(
            child: Container(
          padding: EdgeInsets.only(
            top: screenHeight * 0.0302,
            right: screenWidth * 0.06542,
            left: screenWidth * 0.06542,
          ),
          height: screenHeight,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome \nMina',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: screenHeight * 0.04913 - 13,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.07127,
                    width: screenHeight * 0.07127,
                    child: const Image(
                        image: AssetImage("assets/profileImage.PNG")),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03995,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white, // Text and icon color
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    onPressed: () {
                      // Add the action to be executed when the button is pressed
                    },
                    icon: SizedBox(
                      width: screenWidth * 0.09714,
                      height: screenHeight * 0.03622,
                      child: const Image(
                          image: AssetImage("assets/arrowBack.PNG")),
                    ),
                    label: Text(
                      'log out',
                      style: TextStyle(
                          fontSize: screenHeight * 0.0345 - 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white, // Text and icon color
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              child: AlertDialog(
                                backgroundColor: Colors.white70,
                                content: Container(
                                  width: screenHeight * 0.3812,
                                  height: screenWidth * 0.6308,
                                  padding: EdgeInsets.only(
                                    top: screenHeight * 0.04859,
                                    bottom: screenHeight * 0.04859,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          getImageFromGallery();
                                        },
                                        icon: const Icon(
                                          Icons
                                              .image, // Replace with your desired icon
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          'Gallery',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                screenHeight * 0.03887 - 9,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              239,
                                              216,
                                              249,
                                              100), // Background color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          _takePhoto();
                                        },
                                        icon: const Icon(
                                          Icons
                                              .camera, // Replace with your desired icon
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          'Camira',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                screenHeight * 0.03887 - 9,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              235,
                                              246,
                                              255,
                                              50), // Background color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: SizedBox(
                      width: screenWidth * 0.09714,
                      height: screenHeight * 0.03622,
                      child:
                          const Image(image: AssetImage("assets/upload.PNG")),
                    ),
                    label: Text(
                      'upload',
                      style: TextStyle(
                          fontSize: screenHeight * 0.0345 - 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03671,
              ),
              img.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: screenHeight * .25),
                      child: const Text(
                        'there is\n no images yet!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(
                      height: screenHeight * 0.7440,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 100,
                          childAspectRatio: 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: img.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              height: screenHeight * 0.1177,
                              width: screenHeight * 0.1177,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${img[index]}'), // Replace with your image path
                                  fit: BoxFit
                                      .cover, // Adjust the fit as needed (cover, contain, etc.)
                                ),
                                borderRadius: BorderRadius.circular(
                                    12), // Optional: Add rounded corners
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        )),
      ),
    );
  }
}
