class VirtualAccount {
  String? cur,
      accountId,
      walletAddress,
      accountName,
      accountNo,
      bankName,
      swift,
      iban,
      routine,
      created_at;
  int? id, userId, status;

  VirtualAccount({
    this.cur,
    this.accountId,
    this.walletAddress,
    this.accountName,
    this.accountNo,
    this.bankName,
    this.swift,
    this.iban,
    this.routine,
    this.created_at,
    this.status,
    this.id,
    this.userId,
  });

  static VirtualAccount fromMap({required Map<String, dynamic> userData}) {
    return VirtualAccount(
      created_at: userData['created_at'],
      cur: userData['cur'],
      accountId: userData['accountId'],
      accountName: userData['accountName'],
      accountNo: userData['accountNo'],
      walletAddress: userData['walletAddress'],
      bankName: userData['bankName'],
      swift: userData['swift'],
      iban: userData['iban'],
      routine: userData['routine'],
      status: userData['status'],
      id: userData['id'],
      userId: userData['userId'],
    );
  }
}
