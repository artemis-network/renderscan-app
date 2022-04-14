import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var data = [
      {"title": "Netflix", "subTitle": "Subscription", "trailing": r"$24"},
      {"title": "Prime", "subTitle": "Subscription", "trailing": r"$20"},
      {"title": "HotStar", "subTitle": "Subscription", "trailing": r"$21"},
      {"title": "Prime", "subTitle": "Subscription", "trailing": r"$21"},
      {"title": "HotStar", "subTitle": "Subscription", "trailing": r"$21"},
      {"title": "Prime", "subTitle": "Subscription", "trailing": r"$21"},
      {"title": "HotStar", "subTitle": "Subscription", "trailing": r"$21"},
      {"title": "Prime", "subTitle": "Subscription", "trailing": r"$21"},
      {"title": "HotStar", "subTitle": "Subscription", "trailing": r"$21"},
      {"title": "Prime", "subTitle": "Subscription", "trailing": r"$21"},
    ];

    _controller.forward();

    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
                child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(color: Colors.white),
                    width: size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Column(children: [
                              Text("Wallet",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text("Active",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left),
                            ]),
                          ]),
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1648737154547-b0dfd281c51e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                          ),
                        ])),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  alignment: Alignment.centerRight,
                ),
              ],
            )),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0, // soften the shadow
                        spreadRadius: -2.0, //extend the shadow
                        offset: Offset(
                          1.0, // Move to right 10  horizontally
                          1.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ]),
                height: size.height * 0.15,
                width: size.width * 0.9,
                child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Balance",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "2400 RENDV",
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Account",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "0xcff8...",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonWidget(
                        icon: Icons.add_outlined,
                        text: "Deposit",
                        callback: () => null),
                    ButtonWidget(
                        icon: Icons.transfer_within_a_station_outlined,
                        text: "Transfer",
                        callback: () => null),
                    ButtonWidget(
                        icon: Icons.send_outlined,
                        text: "Send",
                        callback: () => null),
                    ButtonWidget(
                        icon: Icons.receipt_long_outlined,
                        text: "Recieve",
                        callback: () => null),
                  ]),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Last Transcations",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "View All",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                  ],
                )),
            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) => ListItemWidget(
                      title: data[index]['title'].toString(),
                      subTitle: data[index]['subTitle'].toString(),
                      trailing: data[index]['trailing'].toString())),
            ))
          ],
        ),
      )),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback callback;

  const ButtonWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: null,
          child: Icon(
            icon,
            color: Colors.blue,
          ),
          style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              side: const BorderSide(color: Colors.transparent),
              padding: const EdgeInsets.all(15),
              elevation: 5,
              backgroundColor: Colors.white,
              shadowColor: Colors.grey.withOpacity(0.2)),
        ),
        Text(text, style: GoogleFonts.poppins(fontSize: 12, color: Colors.blue))
      ],
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String trailing;

  const ListItemWidget(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(
          Icons.receipt_outlined,
          color: Colors.blue,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(),
      ),
      subtitle: Text(
        subTitle,
        style: GoogleFonts.poppins(),
      ),
      trailing: Text(
        trailing,
        style: GoogleFonts.poppins(),
      ),
    );
  }
}
