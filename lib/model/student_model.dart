// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// --------------------------------------------------------------------------
// USER RESPONSE AND REQUEST MODEL
class UserResponseModel {
  final String firstname;
  final String lastname;
  final String email;
  final String detail;

  UserResponseModel(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.detail});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      firstname: json["firstname"] != null ? json["firstname"] : "",
      lastname: json["lastname"] != null ? json["lastname"] : "",
      email: json["email"] != null ? json["email"] : "",
      detail: json["detail"] != null ? json["detail"] : "",
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'firstname': firstname.trim(),
      'lastname': lastname.trim(),
      'email': email.trim(),
      'detail': detail.trim(),
    };
    return map;
  }
}

//
class SchoolInformationModel {
  final String classStart ;
  final String aysem ;
  final String userid ;

  SchoolInformationModel(
      {required this.classStart,
        required this.aysem,
        required this.userid,
      });

  factory SchoolInformationModel.fromJson(Map<String, dynamic> json) {
    return SchoolInformationModel(
      classStart: json["classStart"] != null ? json["classStart"] : "",
      aysem: json["aysem"] != null ? json["aysem"] : "",
      userid: json["userid"] != null ? json["userid"] : "",
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'classStart': classStart.trim(),
      'aysem': aysem.trim(),
      'userid': userid.trim(),
    };
    return map;
  }
}

//get AmtDue
class AmountDueResponseModel {
  final String amtDue ;


  AmountDueResponseModel(
      {required this.amtDue,
      });

  factory AmountDueResponseModel.fromJson(Map<String, dynamic> json) {
    return AmountDueResponseModel(
      amtDue: json["amtDue"] != null ? json["amtDue"] : "",
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'amtDue': amtDue.trim(),
    };
    return map;
  }
}
// ---------------------------------------------------------------------------
// SCHEDULE RESPONSE MODEL
class ScheduleResponseModel {
  String classId;
  String classCode;
  String subject;
  String section;
  String schedule;
  String units;

  ScheduleResponseModel({
    required this.classId,
    required this.classCode,
    required this.subject,
    required this.section,
    required this.schedule,
    required this.units,
  });

  factory ScheduleResponseModel.fromJson(Map<String, dynamic> json) {
    return ScheduleResponseModel(
      classId: json['classid'] != null ? json["classid"] : "",
      classCode: json['classCode'] != null ? json["classCode"] : "",
      subject: json['subject'] != null ? json["subject"] : "",
      section: json['section'] != null ? json["section"] : "",
      schedule: json['schedule'] != null ? json["schedule"] : "",
      units: json['units'] != null ? json["units"] : "",
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'classId': classId.trim(),
      'classCode': classCode.trim(),
      'subject': subject.trim(),
      'section': section.trim(),
      'schedule': schedule.trim(),
      'units': units.trim(),
    };
    return map;
  }

}


// ---------------------------------------------------------------------------
// FEES RESPONSE MODEL
class FeesResponseModel {
  String itemName;
  String itemAmount;

  FeesResponseModel({
    required this.itemName,
    required this.itemAmount,
  });

  factory FeesResponseModel.fromJson(Map<String, dynamic> json) {
    return FeesResponseModel(
      itemName: json['itemName'] != null ? json["itemName"] : "",
      itemAmount: json['itemAmount'] != null ? json["itemAmount"].toString() : "",
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'itemName': itemName.trim(),
      'itemAmount': itemAmount.trim(),
    };
    return map;
  }

}

// ---------------------------------------------------------------------------
// STUDENT PERSONAL INFORMATION RESPONSE MODEL
class UserPersonalResponseModel {
  final String detail;
  final String firstname;
  final String lastname;
  final String middlename;
  final String pedigree;
  final String gender;
  final String civilstatus;
  final String citizenship;
  final String email;
  final String mobilephone;

  UserPersonalResponseModel({
    required this.detail,
    required this.firstname,
    required this.lastname,
    required this.middlename,
    required this.pedigree,
    required this.gender,
    required this.civilstatus,
    required this.citizenship,
    required this.email,
    required this.mobilephone,
  });

  factory UserPersonalResponseModel.fromJson(Map<String, dynamic> json) {
    return UserPersonalResponseModel(
      firstname: json['firstname'] != null ? json["firstname"] : "",
      lastname: json['lastname'] != null ? json["lastname"] : "",
      middlename: json['middlename'] != null ? json["middlename"] : "",
      pedigree: json['pedigree'] != null ? json["pedigree"] : "",
      gender: json['gender'] != null ? json["gender"] : "",
      civilstatus: json['civilstatus'] != null ? json["civilstatus"] : "",
      citizenship: json["citizenshipcid"] != null ? json["citizenshipcid"] : "",
      email: json["email"] != null ? json["email"] : "",
      mobilephone: json["mobilephone"] != null ? json["mobilephone"] : "",
      detail: json["detail"] != null ? json["detail"] : "",
    );
  }
}

// ---------------------------------------------------------------------------
// STUDENT SCHOOL INFORMATION RESPONSE MODEL
class UserSchoolResponseModel {
  final String detail;
  final String studId;
  final String studentType;
  final String regCode;
  final String progTitle;
  final String yearLevel;
  final String plmemail;

  UserSchoolResponseModel(
      {required this.detail,
      required this.studId,
      required this.studentType,
      required this.regCode,
      required this.progTitle,
      required this.yearLevel,
      required this.plmemail});

  factory UserSchoolResponseModel.fromJson(Map<String, dynamic> json) {
    return UserSchoolResponseModel(
      studId: json['studentId'] != null ? json["studentId"] : "",
      studentType: json['studentType'] != null ? json["studentType"] : "",
      regCode: json['regCode'] != null ? json["regCode"] : "",
      progTitle: json['progTitle'] != null ? json["progTitle"] : "",
      yearLevel: json['yearLevel'] != null ? json["yearLevel"] : "",
      plmemail: json['plmemail'] != null ? json["plmemail"] : "",
      detail: json["detail"] != null ? json["detail"] : "",
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'studentId': studId.trim(),
      'detail': detail.trim(),
      'studentType': studentType.trim(),
      'yearLevel': yearLevel.trim(),
      'regCode': regCode.trim(),
    };
    return map;
  }

}
