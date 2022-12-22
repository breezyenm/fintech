class VirtualAccounts {
  String? cur, currency, country;

  VirtualAccounts({
    this.cur,
    this.currency,
    this.country,
  });

  static VirtualAccounts fromMap({required Map<String, dynamic> userData}) {
    return VirtualAccounts(
      cur: userData['cur'],
      currency: userData['currency'],
      country: userData['country'],
    );
  }
}
