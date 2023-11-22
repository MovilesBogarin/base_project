import 'package:intl/intl.dart';

extension Formater on DateTime {
  String fullDate() {
    return DateFormat.MMMMd('en_US').format(
        DateTime.fromMicrosecondsSinceEpoch((this).microsecondsSinceEpoch));
  }
}
