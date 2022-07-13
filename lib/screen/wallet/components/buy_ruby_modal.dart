import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/wallet/models/order.model.dart';
import 'package:renderscan/screen/wallet/wallet_api.dart';

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
    final String userId = "62ceac54ee2a42334ab6dc29";
    final Order order = new Order(
      userId: userId,
      orderId: response.orderId.toString(),
      amount: getAmount(),
      paymentId: response.paymentId.toString(),
      signature: response.signature.toString(),
      description: "",
      notes: "",
      currency: "INR",
    );
    final message = await WalletApi().completeOrder(order);
    log.i(message);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    log.i(response.code.toString());
    log.i(response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log.i(response.walletName.toString());
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
                    final String userId = "62ceac54ee2a42334ab6dc29";
                    log.i(">> userId:" + userId);
                    final Order order = Order(
                        amount: getAmount(),
                        currency: "INR",
                        description: "",
                        notes: "",
                        orderId: "",
                        paymentId: "",
                        signature: "",
                        userId: userId);
                    final result = await WalletApi().createOrder(order);
                    log.i(">> result:" + result.toString());
                    var options = {
                      'key': 'rzp_test_VmSch4maQMZS9L',
                      'order_id': result["id"],
                      'amount': 100 * getAmount(),
                      'name': 'Artemis Network',
                      'description': 'Fine T-Shirt',
                      'prefill': {
                        'contact': '8888888888',
                        'email': 'test@razorpay.com'
                      },
                    };
                    _razorpay.open(options);
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
      context: context,
      builder: (context) {
        return BuyRubyModal();
      });
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

    final themeBg = groupValue == value
        ? context.watch<ThemeProvider>().getBackgroundColor()
        : context.watch<ThemeProvider>().getPriamryFontColor();

    final themeFont = groupValue != value
        ? context.watch<ThemeProvider>().getBackgroundColor()
        : context.watch<ThemeProvider>().getPriamryFontColor();

    return AnimatedContainer(
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
    );
  }
}
