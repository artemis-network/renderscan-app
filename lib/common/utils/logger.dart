import 'package:logger/logger.dart';

var log = Logger(
  printer: PrettyPrinter(),
);

var logNS = Logger(
  printer: PrettyPrinter(methodCount: 0),
);
