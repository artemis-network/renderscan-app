import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/login/login_screen.dart';
import 'package:renderscan/screens/transcations/components/failure_screen.dart';
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
    final String amt = getAmount().toStringAsFixed(0);
    Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => SuccessScreen(amount: amt))));
  }

  naviagate() {}

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails

    Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
      return FailureScreen();
    })));
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            child: Image.asset(
              "assets/icons/cancel.png",
              height: 24,
              width: 24,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
        title: Text(
          "Pricing Plan",
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              24,
              FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        height: size.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  "assets/icons/wallet.png",
                  height: 180,
                  width: 180,
                )),
            Container(
              child: Text(
                "Choose the amount of ruby, unlock premium features.",
                textAlign: TextAlign.center,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.normal),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RubyRadio(
                    value: RUBY_PACK.RUBY_100,
                    groupValue: ruby_pack_scheme,
                    label: "90",
                    main: "100 Ruby",
                    onChange: (value) => setRubyPackScheme(value),
                  ),
                  RubyRadio(
                    value: RUBY_PACK.RUBY_200,
                    groupValue: ruby_pack_scheme,
                    main: "250 Ruby",
                    label: "180",
                    onChange: (value) => setRubyPackScheme(value),
                  ),
                  RubyRadio(
                    value: RUBY_PACK.RUBY_300,
                    main: "500 Ruby",
                    groupValue: ruby_pack_scheme,
                    label: "270",
                    onChange: (value) => setRubyPackScheme(value),
                  )
                ]),
            Container(
              child: GestureDetector(
                  onTap: () async {
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
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 0,
                            blurRadius: 2,
                            color: context
                                .watch<ThemeProvider>()
                                .getHighLightColor(),
                            offset: Offset(0, 0)),
                      ],
                      color: context.watch<ThemeProvider>().getHighLightColor(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "buy ".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          20,
                          FontWeight.bold),
                    ),
                  )),
            ),
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

  RubyRadio(
      {required this.value,
      required this.main,
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 10),
        duration: Duration(milliseconds: 250),
        width: size.width * 0.75,
        decoration: BoxDecoration(
            color: themeBg,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(blurRadius: 1, color: themeFont)]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/pruby.png",
                height: 36,
                width: 36,
              ),
              Text(
                main,
                style: kPrimartFont(themeFont, 20, FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    label,
                    style: kPrimartFont(themeFont, 18, FontWeight.bold),
                  ),
                  Text(
                    "₹",
                    style: GoogleFonts.openSans(
                        color: themeFont,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
