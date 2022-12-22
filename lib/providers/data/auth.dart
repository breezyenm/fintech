import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/models/document.dart';
import 'package:qwid/models/state.dart';
import 'package:qwid/models/user.dart';

class AuthData extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  set user(User? val) {
    _user = val;
    notifyListeners();
  }

  List<Document> documents = [];

  Map<String, String> accountType = {
    'Personal': '1',
    'Business': '2',
  };

  String? verificationCode;
  String? selectedAccountType;
  String? businessApplicantDocumentType;
  Country? businessApplicantDocumentIssueCountry;
  String? businessApplicantisPep;
  Country? businessRegisteredCountry;
  String? businessCategory;
  String? businessProgram;
  List<Country> businessCountries = [];
  // Country? businessCountry;
  Country? _businessCountry;
  Country? get businessCountry => _businessCountry;
  set businessCountry(Country? val) {
    _businessCountry = val;
    notifyListeners();
  }

  List<States> businessStates = [];
  // States? businessState;
  States? _businessState;
  States? get businessState => _businessState;
  set businessState(States? val) {
    _businessState = val;
    notifyListeners();
  }

  List<String> businessCities = [];
  // String? businessCity;
  String? _businessCity;
  String? get businessCity => _businessCity;
  set businessCity(String? val) {
    _businessCity = val;
    notifyListeners();
  }

  String? _gender;
  String? get gender => _gender;
  set gender(String? val) {
    _gender = val;
    notifyListeners();
  }

  // Country? stakeholder1Nationality;
  Country? _stakeholder1Nationality;
  Country? get stakeholder1Nationality => _stakeholder1Nationality;
  set stakeholder1Nationality(Country? val) {
    _stakeholder1Nationality = val;
    notifyListeners();
  }

  List<String> stakeholderCities = [];
  // String? stakeholder1City;
  String? _stakeholder1City;
  String? get stakeholder1City => _stakeholder1City;
  set stakeholder1City(String? val) {
    _stakeholder1City = val;
    notifyListeners();
  }

  List<States> stakeholderStates = [];
  // States? stakeholder1State;
  States? _stakeholder1State;
  States? get stakeholder1State => _stakeholder1State;
  set stakeholder1State(States? val) {
    _stakeholder1State = val;
    notifyListeners();
  }

  Country? stakeholder1TaxCountry;
  String? stakeholder1IsPep;
  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController resetCode = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController referral = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController tradingName = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController purpose = TextEditingController();

  TextEditingController businessRegistrationNumber = TextEditingController();
  TextEditingController businessRegisteredDate = TextEditingController();
  TextEditingController businessAddress = TextEditingController();
  TextEditingController businessZipcode = TextEditingController();
  TextEditingController businessMobileCode = TextEditingController();
  TextEditingController businessMobile = TextEditingController();
  TextEditingController stakeholder1LastName = TextEditingController();
  TextEditingController stakeholder1FirstName = TextEditingController();
  TextEditingController stakeholder1Email = TextEditingController();
  TextEditingController stakeholder1Designation = TextEditingController();
  TextEditingController stakeholder1ShareVolume = TextEditingController();
  TextEditingController stakeholder1Address = TextEditingController();
  TextEditingController stakeholder1DOB = TextEditingController();
  TextEditingController stakeholder1MobileCode = TextEditingController();
  TextEditingController stakeholder1Zipcode = TextEditingController();
  TextEditingController stakeholder1TaxNumber = TextEditingController();
  TextEditingController stakeholder1PostStartDate = TextEditingController();
  TextEditingController stakeholder1PostEndDate = TextEditingController();
  TextEditingController stakeholder1AddtionalInfo = TextEditingController();
  TextEditingController otherBusinessLicenceNumberPresent =
      TextEditingController();
  TextEditingController otherBusinessLicenceNumber = TextEditingController();
  TextEditingController totalEmployees = TextEditingController();
  TextEditingController businessScale = TextEditingController();
  TextEditingController annualTurnover = TextEditingController();
  TextEditingController industrySector = TextEditingController();
  TextEditingController countryOfOperation = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController paymentFlowDescription = TextEditingController();
  TextEditingController monthlyVolume = TextEditingController();
  TextEditingController additionalInfo = TextEditingController();
  TextEditingController businessActivityDescription = TextEditingController();
  TextEditingController businessApplicantPosition = TextEditingController();
  TextEditingController businessApplicantPositionStartDate =
      TextEditingController();
  TextEditingController businessApplicantPositionEndDate =
      TextEditingController();
  // TextEditingController businessApplicantDocumentExtension =
  //     TextEditingController();
  TextEditingController businessApplicantDocument = TextEditingController();
  TextEditingController businessApplicantDocumentNumber =
      TextEditingController();
  TextEditingController businessApplicantDocumentHolderName =
      TextEditingController();
  TextEditingController businessApplicantDocumentExpiryDate =
      TextEditingController();
  TextEditingController businessApplicantDocumentIssuedDate =
      TextEditingController();
  TextEditingController businessApplicantAdditionalInfo =
      TextEditingController();
  TextEditingController businessApplicantbusinessExtractCoveredStakeholder =
      TextEditingController();
  TextEditingController businessProductDetails = TextEditingController();
  TextEditingController businessProductType = TextEditingController();

  Map<String, File> supportedFiles = {};

  clear() {
    email.clear();
    firstName.clear();
    lastName.clear();
    dob.clear();
    address.clear();
    zipcode.clear();
    phone.clear();
    resetCode.clear();
    newPassword.clear();
    code.clear();
    password.clear();
    referral.clear();
    companyName.clear();
  }
}
