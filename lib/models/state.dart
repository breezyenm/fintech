class States {
  final String? name, id;

  States({
    this.name,
    this.id,
  });

  static States fromMap(Map data) => States(
        name: data['name'],
        id: data['Id'],
      );
}
