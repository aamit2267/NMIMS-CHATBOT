// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gccp_project/HomePage/HomePage.dart';

class Ask extends StatefulWidget {
  const Ask({super.key});

  @override
  State<Ask> createState() => _AskState();
}

class _AskState extends State<Ask> {
  final textcontroller = TextEditingController();
  bool isFull = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage(
                    "./assets/images/image-removebg-preview (1).png"),
              ),
              Text(
                "SAP ID",
                style: TextStyle(
                  color: Color.fromARGB(255, 131, 124, 255),
                  fontSize: 25,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your SAP ID',
                ),
                controller: textcontroller,
                onChanged: (index) => {
                  setState(() {
                    isFull = index.length == 11;
                  }),
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                keyboardType: TextInputType.number,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: SizedBox(
                    height: 50,
                    // 50% of the screen-width
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        isFull
                            ? Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              )
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Wrong SAP ID'),
                                    content: const Text(
                                        'Please check if you have entered a correct SAP ID.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                      },
                      child: Text('Start Chat'),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
