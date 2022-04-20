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
                        title,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'By $photographer',
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        price,
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
                        details,
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

List<ImageDetails> _images = [
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Martin Andres',
    title: 'New Year',
    details:
        'This image was taken during a party in New York on new years eve. Quite a colorful shot.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$10.00',
    photographer: 'Abraham Costa',
    title: 'Spring',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$30.00',
    photographer: 'Jamie Bryan',
    title: 'Casual Look',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  const ImageDetails(
    imagePath: 'assets/images/1.jpg',
    price: '\$20.00',
    photographer: 'Matthew',
    title: 'Cone Ice Cream',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
];

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KprimaryBackGroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Text(
              'Gallery',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: kPrimaryLightColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: KprimaryBackGroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              imagePath: _images[index].imagePath,
                              title: _images[index].title,
                              photographer: _images[index].photographer,
                              price: _images[index].price,
                              details: _images[index].details,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'logo$index',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(_images[index].imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _images.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageDetails {
  final String imagePath;
  final String price;
  final String photographer;
  final String title;
  final String details;
  const ImageDetails({
    Key? key,
    required this.imagePath,
    required this.price,
    required this.photographer,
    required this.title,
    required this.details,
  });
}
