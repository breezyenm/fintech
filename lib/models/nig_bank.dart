class NigBank {
  final String? bankName, bankCode;

  NigBank({
    this.bankName,
    this.bankCode,
  });

  static NigBank fromMap(Map data) => NigBank(
        bankName: data['bankName'],
        bankCode: data['bankCode'],
      );
}
