import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quiz Button',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _res = "";
  int count = 0;
  final station_list = [
    "会津若松駅",
    "一中前",
    "蚕養神社前",
    "会津短大南口",
    "飯盛山下",
    "飯盛山団地",
    "和田",
    "慶山",
    "石山",
    "奴郎ヶ前",
    "会津武家屋敷前",
    "院内",
    "東山温泉入口",
    "東山温泉駅",
    "東山温泉入口［瀧の湯前］",
    "院内",
    "会津武家屋敷前",
    "奴郎ヶ前",
    "慶山入口",
    "会津若松商工会議所前",
    "徒の町",
    "小田垣",
    "会津風雅堂前",
    "文化センター前",
    "鶴ヶ城三の丸口",
    "鶴ヶ城北口",
    "鶴ヶ城入口",
    "北出丸大通り",
    "会津若松市役所前",
    "栄町中三丁目",
    "老町",
    "阿弥陀寺東",
    "七日町駅前",
    "七日町中央",
    "七日町白木屋前",
    "郵便局前",
    "大町一丁目",
    "大町中央公園",
    "大町二丁目"
  ];

  void _getRandomQuiz(String station) async {
    var url = p.join('https://helloworld-go-x3y7mthabq-an.a.run.app/quiz', station);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['totalItems'];
      print("Number of books about http: $itemCount.");
      setState(() {
        _res = jsonResponse['title'].toString();
      });
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

  void trigger() {
    String station;
    if (count >= station_list.length) {
      setState(() {
          count = 0;
      });
    }

    setState((){
      station = station_list[count];
    });

    _getRandomQuiz(station);

    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_res',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
            child: FloatingActionButton(
          onPressed: trigger,
          child: Icon(Icons.all_inclusive),
        )), // This trailing comma makes auto-formatting nicer for build methods.
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
