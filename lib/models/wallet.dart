class Wallet {
  String? currency, cur, country, countryCode, flag;
  int? id;
  double? balance;

  Wallet({
    required this.cur,
    required this.country,
    required this.countryCode,
    required this.flag,
    required this.currency,
    required this.id,
    required this.balance,
  });

  static Wallet fromMap({
    required Map<String, dynamic> userMap,
  }) =>
      Wallet(
        countryCode: userMap['countryCode'],
        country: userMap['country'],
        cur: userMap['cur'],
        currency: userMap['currency'],
        flag: userMap['flag'],
        id: userMap['id'],
        balance: userMap['balance'].toDouble(),
      );
}
