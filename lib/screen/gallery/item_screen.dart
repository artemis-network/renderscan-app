import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class DetailsPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String photographer;
  final String price;
  final String details;
  final int index;

  DetailsPage(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.photographer,
      required this.price,
      required this.details,
      required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: 'logo$index',
              child: Container(
                decoration: BoxDecoration(
                  color: kprimaryBackGroundColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "#2001 C",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'By Renderverse',
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '10000 REND',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '#3001 NFT',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        color: kPrimaryColor,
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: kPrimaryLightColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {},
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        color: kPrimaryColor,
                        child: Text(
                          'Buy',
                          style: TextStyle(
                            color: kPrimaryLightColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
