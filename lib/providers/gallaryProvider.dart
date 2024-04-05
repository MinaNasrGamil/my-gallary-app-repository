import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mygallary_app/providers/userProvider.dart';

import 'package:provider/provider.dart';

class MyImagesProvider with ChangeNotifier {
  late String token;
  List _myImages = [];

  List get myImages {
    return [..._myImages];
  }

  Future<void> fetchAndSetImages(BuildContext context, String token) async {
    final url = Uri.parse('https://flutter.prominaagency.com/api/my-gallery');
    print("tooooken = $token");
    final request = http.MultipartRequest('GET', url);
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Custom-Header': 'multipart/form-data',
    });
    final response = await http.Client().send(request);
    if (response.statusCode == 200) {
      // Handle the response (e.g., read the image data)
      final extractedData =
          await response.stream.transform(utf8.decoder).join();
      final jsonMap = json.decode(extractedData);
      List l = jsonMap['data']['images'];
      final List loadedImages = [];
      l.forEach((e) {
        print(e);
        loadedImages.add(e);
      });
      _myImages = loadedImages;
      notifyListeners();
    } else {
      print('Request failed with status code ${response.statusCode}');
    }
    // try {
    //   final response = await http.get(url, headers: {
    //     HttpHeaders.authorizationHeader: 'Bearer $token',
    //   }).then((response) {
    //     print('coooode ${response.statusCode}');
    //   });
    //   print('nody = ${json.decode(response.body)}');
    // final extractedData = json.decode(response.body) as Map<String, dynamic>;
    // print('extractedData = $extractedData');
    // final List<Gallary> loadedImages = [];
    // extractedData.forEach((index, imagData) {
    //   loadedImages.add(Gallary(imagUrl: imagData));
    // });
    // _myImages = loadedImages;
    // notifyListeners();
    // } catch (error) {
    //   Navigator.of(context).pushNamed(GallaryScreen.routeName);
    //   print('error = $error');
    //   throw (error);
    // }
  }

  Future<void> addImage(File image, BuildContext context) async {
    final url = Uri.parse('https://flutter.prominaagency.com/api/upload');
    final request = http.MultipartRequest('POST', url);
    token = Provider.of<UserProvider>(context, listen: false).user.token;
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    });
    final file = await http.MultipartFile.fromPath('img', image.path);
    request.files.add(file);

    final response = await request.send();
    if (response.statusCode == 200) {
      fetchAndSetImages(context, token);
      print("image is uploded");
    } else {
      print('fieald ${response.statusCode}');
    }
    ;
    notifyListeners();
  }
}
