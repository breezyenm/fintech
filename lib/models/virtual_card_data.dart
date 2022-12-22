class VirtualCardData {
  String? nameOnCard,
      cardNumber,
      cvv,
      expiryMonth,
      expiryYear,
      address,
      country,
      city,
      state,
      zipcode;

  VirtualCardData({
    this.city,
    this.state,
    this.zipcode,
    this.expiryYear,
    this.country,
    this.expiryMonth,
    this.address,
    this.nameOnCard,
    this.cvv,
    this.cardNumber,
  });

  static VirtualCardData? fromMap({
    Map<String, dynamic>? data,
  }) =>
      data == null
          ? null
          : VirtualCardData(
              city: data['city'],
              state: data['state'],
              zipcode: data['zipcode'],
              expiryYear: data['expiryYear'],
              country: data['country'],
              expiryMonth: data['expiryMonth'],
              address: data['address'],
              nameOnCard: data['nameOnCard'],
              cvv: data['cvv'],
              cardNumber: data['cardNumber'],
            );
}
