class User {
  String? email,
      country,
      state,
      city,
      token,
      firstName,
      lastName,
      phone,
      address,
      dob,
      sex,
      pix;
  int? id, uid, userType, zipcode, emailVerify;
  List? kycList;
  bool? userDocument, kycStatus;

  User({
    this.email,
    this.country,
    this.state,
    this.city,
    this.id,
    this.uid,
    this.userType,
    this.token,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.zipcode,
    this.dob,
    this.sex,
    this.pix,
    this.emailVerify,
    this.userDocument,
    this.kycList,
    this.kycStatus,
  });

  static User fromMap({
    required Map<String, dynamic> userMap,
    required String token,
    bool? kycStatus,
    List? kycList,
  }) =>
      User(
        email: userMap['email'],
        country: userMap['country'],
        state: userMap['state'],
        city: userMap['city'],
        id: userMap['id'],
        uid: userMap['userId'],
        firstName: userMap['firstName'],
        lastName: userMap['lastName'],
        userType: userMap['userType'],
        token: token,
        kycList: kycList,
        kycStatus: kycStatus,
        phone: userMap['mobile'],
        address: userMap['address'],
        zipcode: userMap['zipcode'],
        dob: userMap['dob'],
        sex: userMap['sex'],
        pix: userMap['pix'],
        emailVerify: userMap['emailVerify'],
        userDocument: userMap['userDocument']?['upload'],
      );
}
