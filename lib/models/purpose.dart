class Purpose {
  final String? name, id;

  Purpose({this.name, this.id});

  static Purpose fromMap(Map data) =>
      Purpose(name: data['Name'], id: data['Id'].toString());
}
