// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:screenshot/screenshot.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share/share.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/model/motivated.dart';
import 'package:path_provider/path_provider.dart';

class MotivatedItem extends StatefulWidget {
  const MotivatedItem({super.key});
  // todo обязательна для отображения элементо
  // MotivatedModel motivatedModel = MotivatedModel(motivatedText: 'Must go on!');
  @override
  State<StatefulWidget> createState() => _MotivationTasksClassState();
}

class _MotivationTasksClassState extends State<MotivatedItem> {
  late String quote, owner, imglink;
  bool working = false;
  final grey = Colors.blueGrey[800];
  late ScreenshotController screenshotController;

  get http => null;

  @override
  void initState() {
    super.initState();
    screenshotController = ScreenshotController();
    quote = "";
    owner = "";
    imglink = "";
    getQuote();
  }

  // get a random Quote from the API
  getQuote() async {
    try {
      setState(() {
        working = true;
        quote = imglink = owner = "";
      });
      var response = await http.post(
          Uri.encodeFull('http://api.forismatic.com/api/1.0/'),
          body: {"method": "getQuote", "format": "json", "lang": "en"});
      setState(() {
        try {
          var res = jsonDecode(response.body);
          owner = res["quoteAuthor"].toString().trim();
          quote = res["quoteText"].replaceAll("â", " ");
          getImg(owner);
        } catch (e) {
          getQuote();
        }
      });
    } catch (e) {
      offline();
    }
  }

  // if it is offline, show a fixed Quote
  offline() {
    setState(() {
      owner = "Janet Fitch";
      quote = "The phoenix must burn to emerge";
      imglink = "";
      working = false;
    });
  }

  copyQuote() {
    // ClipboardManager.copyToClipBoard(quote + "\n- " + owner).then((result) {
    //   Toast.show("Quote Copied", context, duration: Toast.LENGTH_SHORT);
    // });
  }

  // When share button clicked, share a text and screnshot of the quote
  shareQuote() async {
    final directory = (await getApplicationDocumentsDirectory())
        .path; //from path_provide package
    String path =
        '$directory/screenshots${DateTime.now().toIso8601String()}.png';
    screenshotController.capture().then((_) {
      Share.shareFiles([path], text: quote);
    }).catchError((onError) {
      print(onError);
    });
  }

  // get image of the quote author, using Wikipedia Api
  getImg(String name) async {
    var image = await http.get(
        ("https://en.wikipedia.org/w/api.php?action=query&generator=search&gsrlimit=1&prop=pageimages%7Cextracts&pithumbsize=400&gsrsearch=" +
            name +
            "&format=json"));

    setState(() {
      try {
        var res = json.decode(image.body)["query"]["pages"];
        res = res[res.keys.first];
        imglink = res["thumbnail"]["source"];
      } catch (e) {
        imglink = "";
      }
      working = false;
    });
  }

  Widget drawImg() {
    if (imglink.isEmpty) {
      return SizedBox(
          height: 200,
          width: 200,
          child: Image.asset("img/offline.jpg", fit: BoxFit.cover));
    } else {
      return SizedBox(
          height: 200,
          width: 200,
          child: Image.network(imglink, fit: BoxFit.cover));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Отступ между to do item
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        // При нажатии выполняется функция onToDoChanged c аргументом todo
        onTap: () {
          // onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        // leading: Icon(
        //   // Проверяем значение, если isDone == true - значок задачи будет помечен выполненным
        //   todo.isDone
        //       ? Icons.check_box
        //       : Icons.check_box_outline_blank_outlined,
        //   color: tdGreen,
        // ),
        title: Text(
          // Текст будем брать из модели
          quote,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        // Квадрат красного цвета с правого края
        trailing: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              // onDeleteItem("key_${todo.id}");
              getQuote();
            },
          ),
        ),
      ),
    );
  }
}
