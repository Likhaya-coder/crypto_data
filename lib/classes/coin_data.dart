import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const List<String> cryptoImages = [
  'images/bitcoin.png',
  'images/ethereum.png',
  'images/light_coin.png',
];

class CoinData {
  late String apiKey = '597C17E1-B812-45BA-BA91-25F7D7FCF09E';

  Future getData(currency) async {
    http.Response response = await http.get((Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apikey=$apiKey')));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      double coinRate = data['rate'];
      return coinRate;
    } else {
      print(response.statusCode);
      throw('We could not get the data');
    }
  }
}