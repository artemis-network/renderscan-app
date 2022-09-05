import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/config/web3.services.dart';
import 'package:renderscan/constants.dart';

class Web3Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Note> notes = context.watch<Web3Servives>().notes;

    return Scaffold(
      body: Column(children: [
        ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: notes.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      notes[index].title,
                      style: kPrimartFont(Colors.amber, 24, FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      notes[index].descrpition,
                      style: kPrimartFont(Colors.amber, 18, FontWeight.bold),
                    ),
                  )
                ],
              );
            }),
        GestureDetector(
          onTap: () {
            context.read<Web3Servives>().createNote("test", "cool");
          },
          child: Text("Add note"),
        )
      ]),
    );
  }
}
