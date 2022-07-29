import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/transistion_screen/login/login_screen.dart';
import 'package:renderscan/transistion_screen/transcations/models/order.model.dart';
import 'package:renderscan/transistion_screen/transcations/transaction_api.dart';

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
    log.i(message);
  }

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
              height: 70,
            ),
            Container(
              child: Column(children: [
                Text(
                  "Buy Ruby",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getSecondaryFontColor(),
                      48,
                      FontWeight.bold),
                ),
                Text(
                  "to mint NFTs!",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getSecondaryFontColor(),
                      32,
                      FontWeight.bold),
                ),
              ]),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RubyRadio(
                    value: RUBY_PACK.RUBY_100,
                    groupValue: ruby_pack_scheme,
                    label: "100 RUBY",
                    discountLabel: "10% off only for 90₹",
                    onChange: (value) => setRubyPackScheme(value),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RubyRadio(
                    value: RUBY_PACK.RUBY_200,
                    groupValue: ruby_pack_scheme,
                    label: "200 RUBY",
                    discountLabel: "20% off only for 160₹",
                    onChange: (value) => setRubyPackScheme(value),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RubyRadio(
                    value: RUBY_PACK.RUBY_300,
                    groupValue: ruby_pack_scheme,
                    label: "300 RUBY",
                    discountLabel: "30% off only for 210₹",
                    onChange: (value) => setRubyPackScheme(value),
                  )
                ]),
            SizedBox(
              height: 70,
            ),
            Container(
              width: size.width * 0.6,
              decoration: BoxDecoration(
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  borderRadius: BorderRadius.circular(10),
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
                        log.i(order.toString());
                        final result =
                            await TransactionApi().createOrder(order);
                        log.i(result);
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
                      } catch (e) {
                        log.e(e);
                      }
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
                        "Get Ruby",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            32,
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
  final String discountLabel;
  final Function onChange;

  RubyRadio(
      {required this.value,
      required this.groupValue,
      required this.label,
      required this.discountLabel,
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
        duration: Duration(milliseconds: 500),
        width: size.width * 0.7,
        decoration: BoxDecoration(
            color: themeBg,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(blurRadius: 1, color: themeFont)]),
        child: ListTile(
            title: Column(children: [
              Text(
                label,
                style: kPrimartFont(themeFont, 22, FontWeight.bold),
              ),
              Text(
                discountLabel,
                style: kPrimartFont(themeFont, 16, FontWeight.normal),
              )
            ]),
            leading: Radio<RUBY_PACK>(
              activeColor: themeFont,
              value: value,
              groupValue: groupValue,
              onChanged: (RUBY_PACK? value) => onChange(value),
            )),
      ),
    );
  }
}
