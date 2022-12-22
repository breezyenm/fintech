class Statement {
  final String? month;
  // final DateTime? createdAt;
  // final int? id, userId, transType, charges, confirmation, status, externalId;
  // final String? transId,
  //     purpose,
  //     desc,
  //     fromCur,
  //     toCur,
  //     fromAmount,
  //     toAmount,
  //     externalType,
  //     externalName,
  //     rate;

  Statement({
    this.month,
    // this.id,
    // this.userId,
    // this.transId,
    // this.transType,
    // this.purpose,
    // this.desc,
    // this.fromCur,
    // this.toCur,
    // this.fromAmount,
    // this.toAmount,
    // this.charges,
    // this.externalType,
    // this.externalName,
    // this.externalId,
    // this.confirmation,
    // this.status,
    // this.createdAt,
    // this.rate,
  });

  static Statement fromMap(Map data) => Statement(
        month: data['month'],
        // id: data['id'],
        // userId: data['userId'],
        // transId: data['transId'],
        // transType: data['transType'],
        // purpose: data['purpose'],
        // desc: data['desc'],
        // fromCur: data['fromCur'],
        // toCur: data['toCur'],
        // fromAmount: data['fromAmount'],
        // toAmount: data['toAmount'],
        // charges: int.tryParse(data['charges'].toString()) ?? 0,
        // externalType: data['externalType'],
        // externalName: data['externalName'],
        // externalId: data['externalId'],
        // confirmation: data['confirmation'],
        // status: data['status'],
        // rate: data['rate'],
        // createdAt: DateTime.parse(
        //   data['created_at'],
        // ),
      );
}
