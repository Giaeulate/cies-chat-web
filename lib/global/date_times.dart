import 'package:intl/intl.dart';

String convertDate(DateTime date) => DateFormat("dd/MM/yyyy").format(date);

String formatDate(DateTime? datetime) {
  if (datetime != null) {
    return convertDate(datetime);
  }
  return "";
}

String birthdateToAge(DateTime? date) {
  if (date != null) {
    final actualDate = DateTime.now();
    int months = actualDate.month - date.month > 0 ? 0 : 1;
    return "${actualDate.year - date.year - months}";
  }
  return "";
}

String convertToString(dynamic val) {
  if (val != null && val.toString() != 'null') {
    return val.toString();
  }
  return "";
}
