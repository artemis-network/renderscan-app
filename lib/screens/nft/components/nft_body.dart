import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/nfts_collection/nfts_collection_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTBody extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String lastPrice;
  final String owner;
  final String profile_img_url;
  final String collectionName;
  final String collectionImageUrl;
  final String collectionSlug;
  final String description;

  NFTBody(
      {required this.imageUrl,
      required this.name,
      required this.lastPrice,
      required this.owner,
      required this.profile_img_url,
      required this.description,
      required this.collectionName,
      required this.collectionSlug,
      required this.collectionImageUrl});

  @override
  State<NFTBody> createState() => _NFTBodyState();
}

class _NFTBodyState extends State<NFTBody> {
  bool showDesctiption = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          clipBehavior: Clip.antiAlias,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          elevation: 300,
          shadowColor: Color.fromARGB(255, 41, 121, 255),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Image.network(
            widget.imageUrl,
            height: 340,
            fit: BoxFit.fill,
            errorBuilder: (context, stacktrace, obj) {
              return SvgPicture.asset(
                "assets/images/default_img.svg",
                fit: BoxFit.fill,
              );
            },
          )),
      Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return NFTCollectionScreen(slug: widget.collectionSlug);
                  }));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(widget.collectionImageUrl),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      widget.collectionName.length > 14
                          ? widget.collectionName.substring(0, 14)
                          : widget.collectionName,
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          18,
                          FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.name,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    22,
                    FontWeight.normal),
              ),
              Row(
                children: [
                  Icon(
                    CryptoFontIcons.ETH,
                    size: 18,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.lastPrice.toString(),
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        18,
                        FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(widget.profile_img_url),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    widget.owner.length > 18
                        ? widget.owner.substring(0, 18) + "..."
                        : widget.owner,
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getSecondaryFontColor(),
                        14,
                        FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              showDesctiption
                  ? Text(
                      widget.description,
                      style: kPrimartFont(
                          context
                              .watch<ThemeProvider>()
                              .getSecondaryFontColor(),
                          12,
                          FontWeight.w400),
                    )
                  : Text(
                      widget.description.substring(0, 100) + "...",
                      style: kPrimartFont(
                          context
                              .watch<ThemeProvider>()
                              .getSecondaryFontColor(),
                          12,
                          FontWeight.w400),
                    ),
              GestureDetector(
                  child: Text(
                    showDesctiption ? "Hide" : "View More",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getSecondaryFontColor(),
                        14,
                        FontWeight.bold),
                  ),
                  onTap: () {
                    setState(() {
                      showDesctiption = !showDesctiption;
                    });
                  })
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          alignment: Alignment.centerLeft),
    ]);
  }
}
