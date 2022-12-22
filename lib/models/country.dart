import 'package:qwid/models/currency.dart';

class Country {
  final String? name, abbr;
  final List<Currency>? currencies;

  Country({this.name, this.abbr, this.currencies});

  Country fromMap(Map data, List<Currency> currencies) => Country(
        name: data['N'],
        abbr: data['I'],
        currencies: currencies,
      );

  // Map<String, dynamic> toMap(Country country) => {
  //       'name': country.name,
  //       'abbr': country.abbr,
  //       'currencies': country.currencies,
  //     };
}
