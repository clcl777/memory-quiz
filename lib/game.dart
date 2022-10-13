import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  //const Game({Key? key}) : super(key: key);
  Game(this.dropdownValue);

  String dropdownValue;

  //final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '色文字記憶力ゲーム',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(dropdownValue),
    );
  }
}

class GamePage extends StatefulWidget {
  //const GamePage({Key? key, required this.title}) : super(key: key);
  GamePage(this.dropdownValue);

  //final String title;
  final String dropdownValue;

  @override
  State<GamePage> createState() => _GamePageState(dropdownValue);
}

class _GamePageState extends State<GamePage> {
  //int sleep_time = 1;
  //int num_word = 5;
  //bool flag = false;
  _GamePageState(this.dropdownValue);

  String dropdownValue;
  List<String> word_list = [
    "みかん",
    "いちご",
    "りんご",
    "なし",
    "かき",
    "すいか",
    "メロン",
    "ぶどう",
    "もも",
    "レモン",
    "さくらんぼ",
    "アセロラ",
    "キウイ"
  ];
  List<String> color_list_str = ["オレンジ", "青", "緑", "赤", "黒", "ピンク"];
  List<String> drop_list = [];
  String word = "";
  String result = "　　";
  static Map<int, Color> color = {
    0: Color(0xFFFFa500),
    1: Color(0xFF0000F9),
    2: Color(0xFF228b22),
    3: Color(0xFFFF0000),
    4: Color(0xFF000000),
    5: Color(0xFFFF00FF),
  };
  static List<int> color_list = [
    0xFFFFa500,
    0xFF0000F9,
    0xFF228b22,
    0xFFFF0000,
    0xFF000000,
    0xFFFF00FF
  ];
  MaterialColor primeColor = MaterialColor(color_list[1], color);
  bool isVisible_question = false;
  bool isVisible_word = true;
  bool isVisible_color_item = false;
  bool isVisible_non_color_item = false;
  bool isVisible_next = false;
  var rand_word_list = <int>[];
  var rand_color_list = <int>[];
  String question = "";
  String selected_color = "";
  String dropdownValue_answer = "";
  String dropdownValue_answer2 = "オレンジ";
  int sleep_time = 0;
  int num_word = 0;
  int rand_word = 0;
  int rand_color = 0;
  int rand_question = 0;
  int rand_question2 = 0;
  int rand_rare_question = 0;
  int answer_num = 0;
  String answer_str = "";

  @override
  void initState() {
    //print(dropdownValue);
    _anime(dropdownValue);
    super.initState();
  }

  void _anime(dropdownValue) async {
    // 3,2,1
    // int sleep_time;
    // int num_word;
    // int rand_word;
    // int rand_color;
    // int rand_question;
    // int rand_question2;
    // int rand_rare_question;

    if (dropdownValue == "1") {
      sleep_time = 1500;
      num_word = 3;
    } else if (dropdownValue == "2") {
      sleep_time = 1500;
      num_word = 5;
    } else if (dropdownValue == "3") {
      sleep_time = 1000;
      num_word = 7;
    } else if (dropdownValue == "4") {
      sleep_time = 600;
      num_word = 10;
    } else if (dropdownValue == "5") {
      sleep_time = 300;
      num_word = 15;
    } else {
      sleep_time = 1000;
      num_word = 5;
    }
    for (var i = 0; i < 3; i++) {
      setState(() {
        word = (3 - i).toString();
        primeColor = MaterialColor(color_list[4], color);
      });
      await Future.delayed(Duration(milliseconds: 1000));
    }

    for (var i = 0; i < num_word; i++) {
      var rand = new math.Random();
      setState(() {
        rand_word = rand.nextInt(word_list.length);
        rand_color = rand.nextInt(color_list.length);
        if (i>0){
          while(rand_word==rand_word_list[i-1]&&rand_color==rand_color_list[i-1]){
            rand_word = rand.nextInt(word_list.length);
            rand_color = rand.nextInt(color_list.length);
          }
        }
        word = word_list[rand_word];
        primeColor = MaterialColor(color_list[rand_color], color);
        //リスト追加
        rand_word_list.add(rand_word);
        rand_color_list.add(rand_color);
      });
      //sleep(Duration(seconds: 1));
      await Future.delayed(Duration(milliseconds: sleep_time));
    }
    setState(() {
      isVisible_word = false;
      isVisible_question = true;
      //質問作成
      var rand = new math.Random();
      rand_question = rand.nextInt(4);
      rand_rare_question = rand.nextInt(49);
      if (rand_rare_question == 0) {
        question = "ところで、今日は何日？";
      } else {
        // 普通の質問
        if (rand_question == 0) {
          rand_question2 =
              rand_color_list[rand.nextInt(rand_color_list.length)];
          primeColor = MaterialColor(color_list[rand_question2], color);
          if (rand_question2 == 0) {
            selected_color = "オレンジ色";
          } else if (rand_question2 == 1) {
            selected_color = "青色";
          } else if (rand_question2 == 2) {
            selected_color = "緑色";
          } else if (rand_question2 == 3) {
            selected_color = "赤色";
          } else if (rand_question2 == 4) {
            selected_color = "黒色";
          } else if (rand_question2 == 5) {
            selected_color = "ピンク色";
          }
          dropdownValue_answer = "1";
          //dropdownValue_answer = "Hello";
          for (var i = 1; i < rand_color_list.length + 1; i++) {
            drop_list.add(i.toString());
          }
          //drop_list = [for (var i = 1; i <= rand_word_list.length; i++) i];
          question = "の文字が出てきた回数は？";
          isVisible_non_color_item = true;
          for (var k in rand_color_list) {
            if (k == rand_question2) {
              answer_num = answer_num + 1;
            }
          }
          answer_str = answer_num.toString();
        } else if (rand_question == 1) {
          rand_question2 = rand.nextInt(rand_word_list.length);
          dropdownValue_answer = word_list[0];
          //dropdownValue_answer = "Hello";
          isVisible_non_color_item = true;
          question = (rand_question2 + 1).toString() + "番目の言葉は？";
          drop_list = word_list;
          answer_num = rand_word_list[rand_question2];
          answer_str = word_list[answer_num];
        } else if (rand_question == 2) {
          rand_question2 = rand_word_list[rand.nextInt(rand_word_list.length)];
          isVisible_non_color_item = true;
          question = "「" + word_list[rand_question2] + "」" + "がでてきた回数は？";
          dropdownValue_answer = "1";
          //dropdownValue_answer = "Hello";
          for (var i = 1; i < rand_color_list.length + 1; i++) {
            drop_list.add(i.toString());
          }
          for (var k in rand_word_list) {
            if (k == rand_question2) {
              answer_num = answer_num + 1;
            }
          }
          answer_str = answer_num.toString();
        } else if (rand_question == 3) {
          rand_question2 = rand.nextInt(rand_word_list.length);
          dropdownValue_answer = color_list_str[0];
          //dropdownValue_answer = "Hello";
          question = (rand_question2 + 1).toString() + "番目の言葉の色は？";
          isVisible_color_item = true;
          drop_list = color_list_str;
          answer_num = rand_color_list[rand_question2];
          answer_str = color_list_str[answer_num];
        }
      }
    });
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
            Visibility(
              visible: isVisible_word,
              child: Text(
                word,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    //color: Colors.red
                    color: primeColor
                    //color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
            Visibility(
              visible: isVisible_question,
              //maintainSize: true,
              //maintainAnimation: true,
              //maintainState: true,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: selected_color,
                            style: TextStyle(
                              color: primeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          TextSpan(
                            text: question,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isVisible_non_color_item,
                      child: DropdownButton<String>(
                        value: dropdownValue_answer,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue_answer = newValue!;
                            result = "　　";
                            //print(dropdownValue);
                          });
                        },
                        items: drop_list
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                //color: Colors.blue
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Visibility(
                      visible: isVisible_color_item,
                      child: DropdownButton<String>(
                        value: dropdownValue_answer2,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue_answer2 = newValue!;
                            result = "　　";
                            //print(dropdownValue);
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              color_list_str[0],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(color_list[0])),
                            ),
                            value: color_list_str[0],
                          ),
                          DropdownMenuItem(
                            child: Text(
                              color_list_str[1],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(color_list[1])),
                            ),
                            value: color_list_str[1],
                          ),
                          DropdownMenuItem(
                            child: Text(
                              color_list_str[2],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(color_list[2])),
                            ),
                            value: color_list_str[2],
                          ),
                          DropdownMenuItem(
                            child: Text(
                              color_list_str[3],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(color_list[3])),
                            ),
                            value: color_list_str[3],
                          ),
                          DropdownMenuItem(
                            child: Text(
                              color_list_str[4],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(color_list[4])),
                            ),
                            value: color_list_str[4],
                          ),
                          DropdownMenuItem(
                            child: Text(
                              color_list_str[5],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(color_list[5])),
                            ),
                            value: color_list_str[5],
                          )
                        ],
                      ),
                    ),
                    OutlinedButton(
                      child: const Text('決定'),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.green),
                      ),
                      onPressed: () {
                        //決定処理
                        if (rand_question == 3) {
                          if (answer_str == dropdownValue_answer2) {
                            setState(() {
                              result = "正解！";
                            });
                          } else {
                            setState(() {
                              result = "不正解";
                            });
                          }
                        } else {
                          if (answer_str == dropdownValue_answer) {
                            setState(() {
                              result = "正解！";
                            });
                          } else {
                            setState(() {
                              result = "不正解";
                            });
                          }
                        }
                      },
                    ),
                  ]),
            ),
            Text(
              result,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.black),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
