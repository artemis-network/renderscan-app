import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class ValidationContainer extends StatefulWidget {
  final List<String> errors;
  ValidationContainer({Key? key, required this.errors});

  @override
  State<ValidationContainer> createState() => _ValidationContainerState();
}

class _ValidationContainerState extends State<ValidationContainer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: ListView.builder(
          cacheExtent: 9999,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.errors.length,
          itemBuilder: (context, index) => Text(
                widget.errors[index],
                style: kPrimartFont(Colors.redAccent, 12, FontWeight.bold),
              )),
    ));
  }
}
