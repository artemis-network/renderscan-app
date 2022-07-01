import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:renderscan/screen/generate/generate_api.dart';

class GenerateScreen extends StatefulWidget {
  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  String search = "";
  String? img;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("GENERATE_PAGE"),
              Container(
                color: Colors.blue,
                child: img != null
                    ? Image.network(
                        img!,
                        height: 300,
                        width: 300,
                      )
                    : Text(""),
              ),
              TextField(
                onChanged: ((value) => setState(() {
                      search = value;
                    })),
              ),
              InkWell(
                  onTap: () async {
                    var image = await GenerateApi().generate(search, "akash");
                    setState(() {
                      img = image;
                    });
                  },
                  child: Text(
                    "GENERATE",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          )),
    ));
  }
}
