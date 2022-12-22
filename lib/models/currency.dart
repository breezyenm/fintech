class Currency {
  String? name, cur;

  Currency({this.name, this.cur});

  Currency fromMap(Map data) => Currency(
        name: data['N'],
        cur: data['I'],
      );

  // Map<String, String> toMap(Currency country) => {
  //       'name': country.name,
  //       'cur': country.cur,
  //     };
}
