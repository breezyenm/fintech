class City {
  final String? name, id;

  City({
    this.name,
    this.id,
  });

  static City fromMap(Map data) => City(
        name: data['Name'],
        id: data['Id'].toString(),
      );
}
