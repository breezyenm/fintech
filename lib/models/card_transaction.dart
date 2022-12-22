class CardTransaction {
  final DateTime? createdAt;
  final String? virtualTransId,
      virtualTransRef,
      virtualTransType,
      previousBalance,
      presentBalance,
      transactionSource,
      transactionPurpose,
      virtualCardCur;
  final int? virtualTransStatus;

  CardTransaction({
    this.virtualTransId,
    this.virtualTransRef,
    this.virtualTransType,
    this.previousBalance,
    this.presentBalance,
    this.transactionSource,
    this.transactionPurpose,
    this.virtualTransStatus,
    this.virtualCardCur,
    this.createdAt,
  });

  static CardTransaction fromMap(Map data) => CardTransaction(
      virtualTransId: data['virtualTransId'],
      virtualTransRef: data['virtualTransRef'],
      virtualTransType: data['virtualTransType'],
      previousBalance: data['previousBalance'],
      presentBalance: data['presentBalance'],
      transactionSource: data['transactionSource'],
      transactionPurpose: data['transactionPurpose'],
      virtualTransStatus: data['virtualTransStatus'],
      virtualCardCur: data['virtualCardCur'],
      createdAt: DateTime.parse(
        data['created_at'],
      ));
}
