class Bank {
  final int? id;
  final String? cur,
      bankName,
      accountName,
      accountNo,
      sortingCode,
      routingNo,
      country,
      address;

  Bank({
    this.id,
    this.cur,
    this.bankName,
    this.accountName,
    this.accountNo,
    this.sortingCode,
    this.routingNo,
    this.country,
    this.address,
  });

  Bank fromMap(Map data) => Bank(
        id: data['id'],
        cur: data['cur'],
        bankName: data['bankName'],
        accountName: data['accountName'],
        accountNo: data['accountNo'],
        sortingCode: data['sortingCode'],
        routingNo: data['routingNo'],
        country: data['country'],
        address: data['address'],
      );
}
