import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDateFromTimeStamp({Timestamp timestamp}) {
  if (!(timestamp is Timestamp)) {
    return 'it is not timestamp.';
  }
  final date = timestamp.toDate();
  return formatDateFromDateTime(datetime: date);
}

String formatDateFromDateTime({DateTime datetime}) {
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  return dateFormat.format(datetime);
}
