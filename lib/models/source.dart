class Source {
  final String? name, id;

  Source({this.name, this.id});

  static Source fromMap(Map data) =>
      Source(name: data['Name'], id: data['Id'].toString());
}
