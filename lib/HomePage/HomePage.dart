// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gccp_project/Ask/Ask.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> messageList = <Widget>[];
  final TextEditingController _textController = TextEditingController();
  bool isClassroomLabs = false;

  Widget _queryInputWidget(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(40, 10, 40, 40),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: (String text) {
                  _textController.clear();
                  setState(() {
                    messageList.insert(0, _userMessage(text));
                  });
                },
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                decoration:
                    const InputDecoration.collapsed(hintText: "Send a message"),
                onEditingComplete: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.green[400],
                ),
                onPressed: () {
                  setState(() {
                    messageList.insert(0, _userMessage(_textController.text));
                  });
                  _locator(_textController.text);
                  _textController.clear();
                },
                splashColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userMessage(String message) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 40, left: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: Card(
              color: Colors.green[400],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _botMessage(String message) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://st4.depositphotos.com/4202565/30232/v/1600/depositphotos_302325204-stock-illustration-robot-icon-chat-robot-icon.jpg"),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Card(
              color: Colors.grey[200],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _startUp() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://st4.depositphotos.com/4202565/30232/v/1600/depositphotos_302325204-stock-illustration-robot-icon-chat-robot-icon.jpg"),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Card(
              color: Colors.grey[200],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "How can i help you with?",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[400],
                        minimumSize: Size(double.infinity, 30),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          messageList.insert(0, _askmesscanteen());
                        });
                      },
                      child: Text(
                        'Mess/Canteen',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[400],
                        // take full width
                        minimumSize: Size(double.infinity, 30),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          messageList.insert(0, _askclassroomlabs());
                        });
                        isClassroomLabs = true;
                      },
                      child: Text(
                        'Classroom/Labs',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _endChatButton() {
    return Container(
      margin: const EdgeInsets.only(top: 2, bottom: 10, left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () {
                setState(() {
                  messageList.clear();
                });
                isClassroomLabs = false;
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Ask(),
                  ),
                );
              },
              child: const Text(
                "End Chat",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mainmenu() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 2, left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () {
                setState(() {
                  messageList.clear();
                });
                isClassroomLabs = false;
              },
              child: const Text(
                "Go Back To Main Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _askmesscanteen() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://st4.depositphotos.com/4202565/30232/v/1600/depositphotos_302325204-stock-illustration-robot-icon-chat-robot-icon.jpg"),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Card(
              color: Colors.grey[200],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "Are you feeling hungry?",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[400],
                        minimumSize: Size(double.infinity, 30),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _mess();
                        });
                      },
                      child: Text(
                        'Mess',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[400],
                        minimumSize: Size(double.infinity, 30),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          messageList.insert(0,
                              _botMessage("You can ask me about the weather"));
                        });
                      },
                      child: Text(
                        'Canteen',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _askclassroomlabs() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://st4.depositphotos.com/4202565/30232/v/1600/depositphotos_302325204-stock-illustration-robot-icon-chat-robot-icon.jpg"),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Card(
              color: Colors.grey[200],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Need help with location? Just type the name of your classroom or lab to find the location",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget messagecount() {
    return Container(
      child: Center(child: Text("Messages:" + messageList.length.toString())),
    );
  }

  _mess() async {
    var url = 'https://us-central1-nmims-chatbot.cloudfunctions.net/mess-menu';
    var httpClient = new HttpClient();
    String result;
    try {
      var request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode({
        "text": "mess",
      })));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        result = await response.transform(utf8.decoder).join();
      } else {
        result =
            'Error getting a response:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed invoking the function. Exception: $exception';
    }
    setState(() {
      messageList.insert(0, _botMessage(result));
    });
  }

  _locator(message) async {
    var url = "https://us-central1-nmims-chatbot.cloudfunctions.net/location";
    var httpClient = new HttpClient();
    String result;
    try {
      var request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode({
        "text": "location",
        "message": message,
      })));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var par = await response.transform(utf8.decoder).join();

        var pa = json.decode(par);
        result = "Name: " +
            pa[0]['name'] +
            "\nWing: " +
            pa[0]['wing'] +
            "\nFloor: " +
            pa[0]['floor'];
      } else {
        result =
            'Error getting a response:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed invoking the function. Exception: $exception';
    }
    setState(() {
      messageList.insert(0, _botMessage(result));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('NMIMS ChatBot'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              messageList.clear();
            });
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Ask(),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => messageList[index],
            itemCount: messageList.length,
          )),
          if (messageList.isEmpty) _botMessage("Welcome to NMIMS Chatbot."),
          if (messageList.isEmpty) _startUp(),
          messagecount(),
          if (messageList.isNotEmpty) _mainmenu(),
          _endChatButton(),
          if (isClassroomLabs) _queryInputWidget(context),
        ],
      ),
    );
  }
}
