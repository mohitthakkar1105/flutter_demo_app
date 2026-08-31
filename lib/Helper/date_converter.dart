import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  // -----------------------------
  // 🔧 Internal parsers
  // -----------------------------

  static DateTime? _parseString(String? date) {
    if (date == null || date.isEmpty) return null;

    try {
      return DateTime.parse(date);
    } catch (_) {
      return null;
    }
  }

  static DateTime? _resolve(dynamic date) {
    if (date == null) return null;

    if (date is DateTime) return date;
    if (date is String) return _parseString(date);

    return null;
  }

  // -----------------------------
  // 🎯 Core formatter (universal)
  // -----------------------------

  static String format(
      dynamic date, {
        String pattern = 'dd MMM yyyy',
        String fallback = '--',
        bool toLocal = true,
      }) {
    final parsed = _resolve(date);

    if (parsed == null) return fallback;

    final finalDate = toLocal ? parsed.toLocal() : parsed;

    return DateFormat(pattern).format(finalDate);
  }

  // -----------------------------
  // 🔥 String-based shortcuts (API response use)
  // -----------------------------

  static String ddMMyyyy(String? date) =>
      format(date, pattern: 'dd-MM-yyyy');

  static String ddMMMyyyy(String? date) =>
      format(date, pattern: 'dd MMM yyyy');

  static String yyyyddMM(String? date) =>
      format(date, pattern: 'yyyy-dd-MM');

  static String MMMddyyyy(String? date) =>
      format(date, pattern: 'MMM dd, yyyy');

  static String fullDate(String? date) =>
      format(date, pattern: 'EEEE, dd MMM yyyy');

  static String time12h(String? date) =>
      format(date, pattern: 'hh:mm a');

  static String time24h(String? date) =>
      format(date, pattern: 'HH:mm');

  static String dateTime(String? date) =>
      format(date, pattern: 'dd MMM yyyy, hh:mm a');

  // -----------------------------
  // ⚡ DateTime-based shortcuts (NEW - CLEAN)
  // -----------------------------

  static String ddMMyyyyDT(DateTime? date) =>
      format(date, pattern: 'dd-MM-yyyy');

  static String ddMMMyyyyDT(DateTime? date) =>
      format(date, pattern: 'dd MMM yyyy');

  static String fullDateDT(DateTime? date) =>
      format(date, pattern: 'EEEE, dd MMM yyyy');

  static String time12hDT(DateTime? date) =>
      format(date, pattern: 'hh:mm a');

  static String dateTimeDT(DateTime? date) =>
      format(date, pattern: 'dd MMM yyyy, hh:mm a');
}