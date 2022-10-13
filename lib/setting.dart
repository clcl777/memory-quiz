import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_memory_quiz/game.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '色文字記憶力ゲーム',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SettingPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String dropdownValue = '1';
  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
        centerTitle: true,
        title: Text('色文字記憶力ゲーム'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('難易度:　'),
          DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              //print(dropdownValue);
            });
          },
          items: <String>['1', '2', '3', '4','5']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
          ],
        ),
            //ボタン
            OutlinedButton(
              child: const Text('開始'),
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                shape: const StadiumBorder(),
                side: const BorderSide(color: Colors.green),
              ),
              onPressed: () {
                //画面遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Game(dropdownValue)),
                );
              },
            ),
        ]
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
