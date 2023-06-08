import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class ExchangeRate {
  final String apiUrl = 'https://api.exchangerate-api.com/v4/latest/USD';

  Future<double> getExchangeRate() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['rates']['COP'];
      } else {
        throw Exception('Failed to fetch exchange rate');
      }
    } catch (e) {
      print('Error: $e');
      return 4500; // TRM asumida si falla la conexión
    }
  }

  String formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00', 'es_CO');
    return formatter.format(amount);
  }

  Future<String> convertCOPtoUSD(double amount) async {
    final rate = await getExchangeRate();
    final convertedAmount = amount / rate;
    return formatAmount(convertedAmount);
  }

  Future<String> convertUSDtoCOP(double amount) async {
    final rate = await getExchangeRate();
    final convertedAmount = amount * rate;
    return formatAmount(convertedAmount);
  }
}