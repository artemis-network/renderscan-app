import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/login/login_screen.dart';
import 'package:renderscan/screens/transcations/components/success_screen.dart';
import 'package:renderscan/screens/transcations/models/order.model.dart';
import 'package:renderscan/screens/transcations/transaction_api.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/storage.dart';

enum RUBY_PACK { RUBY_100, RUBY_200, RUBY_300 }

class BuyRubyModal extends StatefulWidget {
  @override
  State<BuyRubyModal> createState() => _BuyRubyModalState();
}

class _BuyRubyModalState extends State<BuyRubyModal> {
  final _razorpay = Razorpay();
  RUBY_PACK ruby_pack_scheme = RUBY_PACK.RUBY_100;
  setRubyPackScheme(RUBY_PACK value) {
    setState(() => ruby_pack_scheme = value);
  }

  getAmount() {
    if (ruby_pack_scheme == RUBY_PACK.RUBY_100) return 90.0;
    if (ruby_pack_scheme == RUBY_PACK.RUBY_200) return 160.0;
    if (ruby_pack_scheme == RUBY_PACK.RUBY_300) return 210.0;
    return 0.0;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    final userId = await Storage().getItem("userId");
    final Order order = new Order(
      userId: userId.toString(),
      orderId: response.orderId.toString(),
      amount: getAmount(),
      paymentId: response.paymentId.toString(),
      signature: response.signature.toString(),
      notes: "",
    );
    final message = await TransactionApi().completeOrder(order);
    print(message);
    Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
      return SuccessScreen();
    })));
  }

  naviagate() {}

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    return Material(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.cancel_outlined,
                  size: 48,
                  color: context.watch<ThemeProvider>().getPriamryFontColor(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  "assets/images/lion.png",
                  height: 160,
                  width: 160,
                )),
            SizedBox(
              height: 30,
            ),
            Text(
              "Pricing Plan",
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  24,
                  FontWeight.bold),
            ),
            Text(
              "Choose a subscription plan to unlock all the functionality of the applications.",
              textAlign: TextAlign.center,
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  16,
                  FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Buy",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      30,
                      FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: context.watch<ThemeProvider>().getFavouriteColor(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "RUBY",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getBackgroundColor(),
                        12,
                        FontWeight.bold),
                  ),
                )
              ],
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RubyRadio(
                    value: RUBY_PACK.RUBY_100,
                    groupValue: ruby_pack_scheme,
                    label: "100R/mo",
                    main: "Unlimited Plan",
                    sub: "100R billed",
                    onChange: (value) => setRubyPackScheme(value),
                  ),
                  RubyRadio(
                    value: RUBY_PACK.RUBY_200,
                    groupValue: ruby_pack_scheme,
                    main: "Yearly Plan",
                    label: "200R/mo",
                    sub: "200R billed",
                    onChange: (value) => setRubyPackScheme(value),
                  ),
                  RubyRadio(
                    value: RUBY_PACK.RUBY_300,
                    main: "Monthly Plan",
                    sub: "",
                    groupValue: ruby_pack_scheme,
                    label: "200R/mo",
                    onChange: (value) => setRubyPackScheme(value),
                  )
                ]),
            SizedBox(
              height: 70,
            ),
            Container(
              width: size.width * 0.8,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color: context
                            .watch<ThemeProvider>()
                            .getPriamryFontColor())
                  ]),
              child: OutlinedButton(
                  onPressed: () async {
                    final bool isUserLoggedIn = await Storage().isLoggedIn();
                    if (isUserLoggedIn) {
                      try {
                        final userId = await Storage().getItem("userId");
                        final Order order = Order(
                            amount: getAmount(),
                            notes: "",
                            orderId: "",
                            paymentId: "",
                            signature: "",
                            userId: userId.toString());
                        final result =
                            await TransactionApi().createOrder(order);
                        var options = {
                          'key': 'rzp_test_VmSch4maQMZS9L',
                          'order_id': result["id"].toString(),
                          'amount': 100 * getAmount(),
                          'name': 'Renderscan',
                          'description': 'Buy Ruby',
                          'prefill': {
                            'contact': '8888888888',
                            'email': 'test@razorpay.com'
                          },
                        };
                        _razorpay.open(options);
                      } catch (e) {}
                    } else
                      Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: LoginScreen(),
                          ctx: context,
                          fullscreenDialog: true,
                          duration: Duration(milliseconds: 300),
                          childCurrent: BuyRubyModal()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue".toUpperCase(),
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            20,
                            FontWeight.bold),
                      ),
                    ],
                  )),
            )
          ],
        ),
        color: context.watch<ThemeProvider>().getBackgroundColor(),
      ),
    );
  }
}

showBuyRubyModal(BuildContext context) {
  return showModalBottomSheet(
      context: context, builder: (context) => BuyRubyModal());
}

class RubyRadio extends StatelessWidget {
  final RUBY_PACK value;
  final RUBY_PACK groupValue;
  final String label;
  final Function onChange;
  final String main;
  final String sub;

  RubyRadio(
      {required this.value,
      required this.main,
      required this.sub,
      required this.groupValue,
      required this.label,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final themeBg = groupValue != value
        ? context.watch<ThemeProvider>().getBackgroundColor()
        : context.watch<ThemeProvider>().getPriamryFontColor();

    final themeFont = groupValue == value
        ? context.watch<ThemeProvider>().getBackgroundColor()
        : context.watch<ThemeProvider>().getPriamryFontColor();

    return GestureDetector(
      onTap: () {
        onChange(value);
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: EdgeInsets.symmetric(vertical: 10),
        duration: Duration(milliseconds: 500),
        width: size.width * 0.8,
        decoration: BoxDecoration(
            color: themeBg,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(blurRadius: 1, color: themeFont)]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    main,
                    style: kPrimartFont(themeFont, 12, FontWeight.bold),
                  ),
                  Text(
                    sub,
                    style: kPrimartFont(themeFont, 10, FontWeight.bold),
                  ),
                ],
              ),
              Text(
                label,
                style: kPrimartFont(themeFont, 16, FontWeight.bold),
              ),
            ]),
      ),
    );
  }
}

class Features extends StatelessWidget {
  final String text;
  final IconData icon;

  Features({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon,
              size: 24,
              color: context.watch<ThemeProvider>().getPriamryFontColor()),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                14,
                FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
