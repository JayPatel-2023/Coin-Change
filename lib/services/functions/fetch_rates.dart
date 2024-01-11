import 'package:http/http.dart' as http;

import '../config/api_key.dart';
import '../models/allCurrencies.dart';
import '../models/ratesmodel.dart';

Future<RatesModel> fetchRates() async {
  final response = await http.get(Uri.parse(uri));
  print(response.body);
  final result = ratesModelFromJson(response.body);
  return result;
}

Future<Map> fetchcurrencies() async {
  final response = await http.get(Uri.parse(uriForCurrency));

  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}

String convertusd(Map exchangeRates, String usd, String currency) {
  String output =
      ((exchangeRates[currency] * double.parse(usd)).toStringAsFixed(2))
          .toString();
  return output;
}

String convertany(Map exchangeRates, String amount, String currencybase,
    String currencytarget) {
  //double base = double.parse(currencybase);
  //double target = double.parse(currencytarget);
  String output = ((double.parse(amount) * exchangeRates[currencytarget]) /
          exchangeRates[currencybase])
      .toStringAsFixed(2)
      .toString();
  return output;
}
