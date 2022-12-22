class VirtualCardCur {
  String? cur,
      amount,
      fee,
      singleLimit,
      monthlyLimit,
      created_at,
      updated_at,
      flag,
      currency,
      country,
      countryCode;
  int? status, id;

  VirtualCardCur({
    this.countryCode,
    this.country,
    this.created_at,
    this.cur,
    this.id,
    this.currency,
    this.updated_at,
    this.singleLimit,
    this.amount,
    this.monthlyLimit,
    this.fee,
    this.flag,
    this.status,
  });

  static VirtualCardCur fromMap({
    required Map<String, dynamic> data,
  }) =>
      VirtualCardCur(
        countryCode: data['countryCode'],
        country: data['country'],
        created_at: data['created_at'],
        cur: data['cur'],
        id: data['id'],
        currency: data['userId'],
        updated_at: data['updated_at'],
        singleLimit: data['singleLimit'],
        status: data['status'],
        amount: data['amount'],
        monthlyLimit: data['monthlyLimit'],
        fee: data['fee'],
        flag: data['flag'],
      );
}
