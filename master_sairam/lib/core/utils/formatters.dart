import 'package:intl/intl.dart';

class Formatters {
  static String formatPrice(double price) => NumberFormat.currency(
        locale: 'ru_RU',
        symbol: '₸',
      ).format(price);

  static String formatDate(DateTime date) => DateFormat('d MMMM, HH:mm').format(date);
}
