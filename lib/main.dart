

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:flutter/material.dart';


void main()
{
  runApp(Homepage());
}
class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pg1(),
    );
  }
}
class Pg1 extends StatefulWidget {
  const Pg1({Key? key}) : super(key: key);

  @override
  State<Pg1> createState() => _Pg1State();
}

class _Pg1State extends State<Pg1> {
  var urlsent = "https://picsum.photos/250?image=9";


  void onImageSaveButtonPressed(String urlsent) async {
    DateTime selectedDate = DateTime.now();
    print("image saved");
    Uri uri = Uri.parse('${urlsent}');
    var response = await http.get(uri);
    Directory? documentDirectory = await getApplicationDocumentsDirectory();
    var file = File(join(documentDirectory!.path, 'imagetest${selectedDate.month}${selectedDate.year}${selectedDate.day}${selectedDate.minute}${selectedDate.second}${selectedDate.millisecond}.png'));
    print("${file.path}");
    file.writeAsBytesSync(response.bodyBytes);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("image saver"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: CachedNetworkImage(
            imageUrl: urlsent,
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )),
          ElevatedButton(onPressed: () {
            onImageSaveButtonPressed(urlsent);
                     }, child: Icon(Icons.download)),
          Container(
            height: 300,
            width: 300,
            child: Image.file(File("/data/user/0/com.example.demo_123/app_flutter/imagetest.png"))
          )
        ],
      ),
    );
  }
}


