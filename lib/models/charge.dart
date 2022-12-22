class Charge {
  final double? rate;
  final int? charge, addon;
  final String? chargesType, addonType, peer, fee;

  Charge({
    this.rate,
    this.charge,
    this.chargesType,
    this.addon,
    this.addonType,
    this.peer,
    this.fee,
  });

  Charge fromMap(Map data) => Charge(
        rate: double.parse(data['rate'].toString()),
        charge: data['charge'],
        chargesType: data['chargesType'],
        addon: data['addon'],
        addonType: data['addonType'],
        peer: data['peer'],
        fee: data['fee'],
      );
}
