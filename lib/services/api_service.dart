import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/grades_model.dart';
import '../model/sfemodel/sfe_question_model.dart';
import '../model/student_model.dart';
import '../model/login_model.dart';
import '../model/news_model.dart';
import '../model/request.dart';
import 'dart:developer';

import '../model/sfemodel/eval_list_model.dart';

class APIService {
  String apiUrl = "https://web6.plm.edu.ph/mobileApp2";
  String oldApiUrl = "https://flushed-establishme.000webhostapp.com";
  String sfeApiUrl = "http://192.168.56.1/SFE";

  Future<List<News>> fetchNews() async {
    var url = "${apiUrl}/getNews.php";
    final storage = new FlutterSecureStorage();
    final userId = await storage.read(key: 'userid');
    var body = {'username': userId, 'role': 'student'};
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(body),
    );
    print("DEBUG GENERAL NEWS: ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 403) {
      List<News>? news = [];
      var isSet = 0;
      for (var item in json.decode(response.body)) {
        News currNews = News.fromJson(item);
        if (currNews.enteredOn.isBefore(DateTime.now()) &&
            currNews.validUntil.isAfter(DateTime.now())) {
          news.add(currNews);
          isSet = 1;
        }
      }
      if (isSet == 0) {
        news = null;
      }
      return news!;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<List<StudentNews>> fetchStudentNews() async {
    var url = "${apiUrl}/getNewsInternal.php";
    final storage = new FlutterSecureStorage();
    final userId = await storage.read(key: 'userid');
    var body = {'username': userId, 'role': 'student'};
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(body),
    );
    print("DEBUG INTERNAL NEWS: ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 403) {
      List<StudentNews>? studentNews = [];
      var isSet = 0;
      for (var item in json.decode(response.body)) {
        StudentNews currNews = StudentNews.fromJson(item);
        if (currNews.announceStart.isBefore(DateTime.now()) &&
            currNews.validUntil.isAfter(DateTime.now())) {
          studentNews.add(currNews);
          isSet = 1;
        }
      }
      if (isSet == 0) {
        studentNews = null;
      }
      return studentNews!;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<LoginResponseModel> login(
      LoginRequestModel requestModel, username, password) async {
    final storage = new FlutterSecureStorage();
    var url = "${apiUrl}/login.php";
    var body = {'username': username, 'password': password};
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': "application/json",
          'Accept': "application/json"
        },
        body: json.encode(body),
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200 || response.statusCode == 403) {
      await storage.write(
          key: "access_token",
          value: json.decode(response.body)['access_token']);
      await UserSecureStorage.setUserToken(
          json.decode(response.body)['access_token']);
      await UserSecureStorage.setUserId(username);
      // await UserSecureStorage.setYearLevel(
      //     json.decode(response.body)['yearlevel'].toString());
      // print('DEBUG: userRole: ${json.decode(response.body)['role']}');
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<void> savePE(PEId, username) async {
    final storage = new FlutterSecureStorage();
    var url = "${apiUrl}/savePE.php";
    var body = {'PEId': PEId, 'username': username};
    print('save pe');
    print(PEId);
    print(username);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': "application/json",
          'Accept': "application/json"
        },
        body: json.encode(body),
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200 || response.statusCode == 403) {
      return null;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<UserResponseModel> user() async {
    final storage = new FlutterSecureStorage();
    // final token = await storage.read(key: 'access_token');
    final userId = await storage.read(key: 'userid');
    // final role = await storage.read(key: 'role');
    // print('DEBUG: userRole: $role');
    String url = "${apiUrl}/userPersonal.php";
    var body = {'username': userId, 'role': 'student'};
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(body),
      encoding: Encoding.getByName("utf-8"),
    );
    if (response.statusCode == 200 || response.statusCode == 403) {
      await UserSecureStorage.setFirstName(
          json.decode(response.body)['firstname']);
      await UserSecureStorage.setLastName(
          json.decode(response.body)['lastname']);
      final fullname = json.decode(response.body)['firstname'] +
          ' ' +
          json.decode(response.body)['lastname'];
      await UserSecureStorage.setUserName(fullname);
      return UserResponseModel.fromJson(
        json.decode(response.body.replaceFirst('success', '')),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<SchoolInformationModel> schoolInfo() async {
    final storage = new FlutterSecureStorage();
    String url = "${apiUrl}/schoolInformation.php";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      encoding: Encoding.getByName("utf-8"),
    );
    if (response.statusCode == 200 || response.statusCode == 403) {
      await UserSecureStorage.setClassStart(
          json.decode(response.body)['classStart']);
      await UserSecureStorage.setAysem(
          json.decode(response.body)['aysem']);
      final jsonData = jsonDecode(response.body);
      return SchoolInformationModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<AmountDueResponseModel> AmtDueInfo() async {
    final storage = new FlutterSecureStorage();
    String url = "${apiUrl}/getAmtDue.php";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      encoding: Encoding.getByName("utf-8"),
    );
    if (response.statusCode == 200 || response.statusCode == 403) {
      await UserSecureStorage.setAmtDue(
          json.decode(response.body)['amtDue']);
      final jsonData = jsonDecode(response.body);
      return AmountDueResponseModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<List<YearTerm>> getYearTerms() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    final userId = await storage.read(key: 'userid');
    String url = "${apiUrl}/grades.php";
    var body = {'username': userId, 'role': 'student'};
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
        encoding: Encoding.getByName("utf-8"));
    if (response.statusCode == 200 || response.statusCode == 403) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<YearTerm> yearTerms =
      jsonData.map((yearTerm) => YearTerm.fromJson(yearTerm)).toList();
      return yearTerms;
    } else {
      throw Exception('Failed to load year terms');
    }
  }

  Future<List<PEList>> getPEList() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    final userId = await storage.read(key: 'userid');
    String url = "${apiUrl}/enrollPEList.php";
    var body = {'username': userId, 'role': 'student'};
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
        encoding: Encoding.getByName("utf-8"));
    if (response.statusCode == 200 || response.statusCode == 403) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<PEList> peLists =
      jsonData.map((peList) => PEList.fromJson(peList)).toList();
      return peLists;
    } else {
      throw Exception('Failed to load PE');
    }
  }

  Future<List<ScheduleResponseModel>> fetchClasses() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    final userId = await storage.read(key: 'userid');
    String url = '${apiUrl}/enrollStep1Test.php';
    var body = {'username': userId, 'role': 'student'};
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(body),
      encoding: Encoding.getByName("utf-8"),
    );

    List<ScheduleResponseModel>? schedule = [];
    if (response.statusCode == 200 || response.statusCode == 403) {
      for (var item in json.decode(response.body)) {
        ScheduleResponseModel sched = ScheduleResponseModel.fromJson(item);
        schedule.add(sched);
      }
      return schedule;
    } else {
      return schedule;
    }
  }

  Future<List<FeesResponseModel>> fetchFees() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    final userId = await storage.read(key: 'userid');
    String url = '${apiUrl}/enrollStep2.php';
    var body = {'username': userId, 'role': 'student'};
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(body),
      encoding: Encoding.getByName("utf-8"),
    );

    List<FeesResponseModel>? fees = [];
    if (response.statusCode == 200 || response.statusCode == 403) {
      for (var item in json.decode(response.body)) {
        await UserSecureStorage.setItem(
            json.decode(response.body)[0]['itemName']);
        FeesResponseModel fee = FeesResponseModel.fromJson(item);
        fees.add(fee);
      }
      return fees;
    } else {
      return fees;
    }
  }

  Future<UserPersonalResponseModel> personal() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    final userId = await storage.read(key: 'userid');
    String url = "${apiUrl}/userPersonal.php";
    var body = {'username': userId, 'role': 'student'};
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(body),
      encoding: Encoding.getByName("utf-8"),
    );
    if (response.statusCode == 200 || response.statusCode == 403) {
      final jsonData = jsonDecode(response.body);
      return UserPersonalResponseModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<UserSchoolResponseModel> school() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    final userId = await storage.read(key: 'userid');
    String url = "${apiUrl}/userSchool.php";
    var body = {'username': userId, 'role': 'student'};
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(body),
      encoding: Encoding.getByName("utf-8"),
    );

    if (response.statusCode == 200 || response.statusCode == 403) {
      final jsonData = jsonDecode(response.body);
      return UserSchoolResponseModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data!');
    }
  }
  Future<List<SFEQuestionModel>> fetchSFEQuestion() async{
    var url = "${sfeApiUrl}";
    print("DEBUG SFE NEWS: ${url}");
    final response = await http.get(Uri.parse(url));
    List<SFEQuestionModel> questionlist = [];
    // log("SFE RESPONSE BODY ${json.decode(response.body)}");
    // print("SFE RESPONSE BODY ${json.decode(response.body)}");


    for (var item in json.decode(response.body)) {
      SFEQuestionModel currQuestion = SFEQuestionModel.fromJson(item);
      questionlist.add(currQuestion);
    }
    return questionlist;
  }

  Future<EvaluationListModel> submitEval(EvaluationListModel evaluationListModel) async {
    var url = Uri.parse("${sfeApiUrl}/postdata.php");

    var data = {
      "studentid": evaluationListModel.studentId.toString(),
      "classid": evaluationListModel.classId.toString(),
      "facultyid": evaluationListModel.facultyId.toString(),
      "updatedon": evaluationListModel.updatedOn.toString(),
      "fromdb": evaluationListModel.fromDb,
      "I-1": evaluationListModel.i1.toString(),
      "I-2": evaluationListModel.i2.toString(),
      "I-3": evaluationListModel.i3.toString(),
      "I-4": evaluationListModel.i4.toString(),
      "I-5": evaluationListModel.i5.toString(),
      "I-6": evaluationListModel.i6.toString(),
      "I-7": evaluationListModel.i7.toString(),
      "I-8": evaluationListModel.i8.toString(),
      "I-9": evaluationListModel.i9.toString(),
      "I-10": evaluationListModel.i10.toString(),
      "I-11": evaluationListModel.i11.toString(),
      "I-12": evaluationListModel.i12.toString(),
      "I-13": evaluationListModel.i13.toString(),
      "I-14": evaluationListModel.i14.toString(),
      "I-15": evaluationListModel.i15.toString(),
      "I-16": evaluationListModel.i16.toString(),
      "I-17": evaluationListModel.i17.toString(),
      "I-18": evaluationListModel.i18.toString(),
      "I-19": evaluationListModel.i19.toString(),
      "I-20": evaluationListModel.i20.toString(),
      "I-21": evaluationListModel.i21.toString(),
      "I-22": evaluationListModel.i22.toString(),
      "I-23": evaluationListModel.i23.toString(),
      "I-24": evaluationListModel.i24.toString(),
      "I-25": evaluationListModel.i25.toString(),
      "I-26": evaluationListModel.i26.toString(),
      "I-27": evaluationListModel.i27.toString(),
      "I-28": evaluationListModel.i28.toString(),
      "I-29": evaluationListModel.i29.toString(),
      "I-30": evaluationListModel.i30.toString(),
      "I-31": evaluationListModel.i31.toString(),
      "I-32": evaluationListModel.i32.toString(),
      "I-33": evaluationListModel.i33.toString(),
      "I-34": evaluationListModel.i34.toString(),
      "I-35": evaluationListModel.i35.toString(),
      "I-36": evaluationListModel.i36.toString(),
      "I-37": evaluationListModel.i37.toString(),
      "I-38": evaluationListModel.i38.toString(),
      "I-39": evaluationListModel.i39.toString(),
      "I-40": evaluationListModel.i40.toString(),
      "I-41_1": evaluationListModel.i411.toString(),
      "I-41_2": evaluationListModel.i412.toString(),
      "I-41_3": evaluationListModel.i413.toString(),
      "I-41_4": evaluationListModel.i414.toString(),
      "I-41_5": evaluationListModel.i415.toString(),
      "I-41_6": evaluationListModel.i416.toString(),
      "I-41_7": evaluationListModel.i417.toString(),
      "I-41_8": evaluationListModel.i418.toString(),
      "I-42": evaluationListModel.i42.toString(),
      "I-43": evaluationListModel.i43.toString(),
      "I-44": evaluationListModel.i44.toString(),
      "I-45": evaluationListModel.i45.toString(),
      "I-46": evaluationListModel.i46.toString(),
      "I-47": evaluationListModel.i47.toString(),
      "I-48": evaluationListModel.i48.toString(),
      "I-49": evaluationListModel.i49.toString(),
      "II-1": evaluationListModel.ii1.toString(),
      "II-2": evaluationListModel.ii2.toString(),
      "II-3": evaluationListModel.ii3.toString(),
      "II-4": evaluationListModel.ii4.toString(),
      "II-5": evaluationListModel.ii5.toString(),
      "II-6": evaluationListModel.ii6.toString(),
      "II-7": evaluationListModel.ii7.toString(),
      "II-8": evaluationListModel.ii8.toString(),
      "II-9": evaluationListModel.ii9.toString(),
      "II-10": evaluationListModel.ii10.toString(),
      "II-11": evaluationListModel.ii11.toString(),
      "II-12": evaluationListModel.ii12.toString(),
      "II-13": evaluationListModel.ii13.toString(),
      "II-14": evaluationListModel.ii14.toString(),
      "II-15": evaluationListModel.ii15.toString(),
      "II-16": evaluationListModel.ii16.toString(),
      "III-1": evaluationListModel.iii1.toString(),
      "III-2": evaluationListModel.iii2.toString(),
      "III-3": evaluationListModel.iii3.toString(),
      "III-4": evaluationListModel.iii4.toString(),
      "III-5": evaluationListModel.iii5.toString(),
      "III-6": evaluationListModel.iii6.toString(),
      "III-7": evaluationListModel.iii7.toString(),
      "III-8": evaluationListModel.iii8.toString(),
      "III-9": evaluationListModel.iii9.toString(),
      "III-10": evaluationListModel.iii10.toString(),
    };

    // Send the POST request
    final response = await http.post(
      url,
      body: json.encode(data),
    );
    var jsonResponse = jsonDecode(json.encode(data));
    var evaluationList = EvaluationListModel.fromJson(jsonResponse);
    print("SFE SUBMIT URL ${url}");
    print("SFE DATA${data}");
    print("SFE JSON ENCODE${json.encode(response.body)}");
    print("SFE JSON DECODE${jsonResponse}");
    // print("SFE JSON RESPONSE${evaluationList}");
    return evaluationList;

    //
    // return evaluationListModel;

  }




}