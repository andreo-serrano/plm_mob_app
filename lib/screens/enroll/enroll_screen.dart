import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../main.dart';
import '../../model/grades_model.dart';
import '../../model/login_model.dart';
import '../../model/progressHUD.dart';
import '../../model/request.dart';
import '../../model/student_model.dart';
import '../home/home_screen.dart';
import '../schedule/schedule_screen.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';
import '../../widgets/button.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/src/pdf/color.dart';
import 'package:pdf/src/pdf/page_format.dart';
import 'dart:io';

class EnrollPage extends StatefulWidget {
  const EnrollPage({Key? key}) : super(key: key);
  @override
  State<EnrollPage> createState() => _EnrollPageState();
}

class _EnrollPageState extends State<EnrollPage> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  List<ScheduleResponseModel> listClasses = [];
  List<FeesResponseModel> listFees = [];
  List<UserSchoolResponseModel> listInfo = [];
  String classStart1 = '';
  String aysem1 = '';
  String info1 ='';
  String userId1 ='';
  String amtDue1 = '';
  bool isApiCallProcess = false;
  bool exit = false;
  String data1 = '';
  String? _selectedPE;
  bool _isVisible = false;
  List<PEList> listPE = [];
  Map<String, List<String>> _PESched = {};

  void initState()  {
    super.initState();
    fetchPE();
    fetchSchedule();
    fetchFees();
    fetchSchoolInformation();
  }

  void fetchPE() async {
    APIService apiService = new APIService();
    listPE = await apiService.getPEList();
    listPE.forEach((element) {
      _PESched[element.classId] = [element.classCode];
    });
    setState(() {});
  }

  void fetchSchoolInformation() async {
    APIService apiService = new APIService();
    apiService.schoolInfo().then((value) async => {
      await UserSecureStorage.setClassStart(value.classStart),
      await UserSecureStorage.setAysem(value.aysem),
      await UserSecureStorage.setUserId(value.userid),
    });
    String classStart = await UserSecureStorage.getClassStart() ?? '';
    String aysem = await UserSecureStorage.getAysem() ?? '';
    String userid = await UserSecureStorage.getUserId() ?? '';

    setState(() {
      classStart1 = classStart;
      aysem1 = aysem;
      userId1 = userid;
    });
  }

  void fetchAmtInfo() async {
    APIService apiService = new APIService();
    apiService.AmtDueInfo().then((value) async => {
      await UserSecureStorage.setAmtDue(value.amtDue),

    });
    String amtDue = await UserSecureStorage.getAmtDue() ?? '';

    setState(() {
      amtDue1 = amtDue;
    });
  }

  void fetchSchedule() async {
    APIService apiService = new APIService();
    List<ScheduleResponseModel> classes = await apiService.fetchClasses();
    setState(() {
      listClasses = classes;
    });
  }

  void fetchFees() async {
    APIService apiService = new APIService();
    List<FeesResponseModel> fees = await apiService.fetchFees();

    String data = await UserSecureStorage.getItem() ?? '';

    setState(() {
      listFees = fees;
      data1 =  data;
    });
  }
  void school() async {
    APIService apiService = new APIService();
    List<UserSchoolResponseModel> info = (await apiService.school()) as List<UserSchoolResponseModel>;
    setState(() {
      listInfo = info;
    });
  }
  tapped(int step){
    setState(
            () => _currentStep = step);
  }
  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1) : null;

    _currentStep == 2 ?
    Navigator.of(context).pop(true) : null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

  Future<bool> exitConfirm() async  {
    return await showDialog(
      barrierDismissible : exit,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text('Exit Enrollment'),
          content: Text('Are you sure you want to exit? '),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: ButtonFill(
                      buttonText: 'No',
                      onPressed: () => Navigator.pop(context),
                      bgColor: Colors.grey.shade200,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ButtonFill(
                    buttonText: 'Yes',
                    onPressed: () { Navigator.of(context).pop(true); },
                    bgColor: error,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (data1 != '' &&  _selectedPE == '') {
      return ProgressHUD(
        child: _uiSetUp2(context),
        inAsyncCall: isApiCallProcess,
      );
    } else {
      return ProgressHUD(
        child: _uiSetUp(context),
        inAsyncCall: isApiCallProcess,
      );
    }
  }

  @override
  Widget _uiSetUp(BuildContext context) {
    return WillPopScope(
      onWillPop: exitConfirm,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Enrollment'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                    controlsBuilder: (context, controller) {
                      return const SizedBox.shrink();
                    },
                    type: StepperType.horizontal,
                    // type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        title: new Text(''),
                        label: Text('Schedule & Assessment', style: TextStyle(fontSize: 10)),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Step 1: Schedule', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: error )),
                            SizedBox(height: 20.0),
                            (_PESched.isNotEmpty) ? (Text("Please select a PE class")) : Text(''),
                            SizedBox(height: 10),
                            ((_PESched.isNotEmpty) ? (DropdownButton<String>(
                              isExpanded: true,
                              hint: Text("Select PE",
                                  style: Theme.of(context).textTheme.bodyMedium),
                              value: _selectedPE,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              items: _PESched.keys.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  _selectedPE = value;
                                  isApiCallProcess = true;
                                  _isVisible = false;
                                });
                                APIService apiService = new APIService();
                                apiService.savePE(_selectedPE, userId1)
                                    .then((value) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                });
                              },
                            )): Text('')),
                            SizedBox(height: 20.0),
                            Text('This is your schedule for the ${aysem1.toString()} .The following schedule was provided by your department.'),
                            SizedBox(height: 20),
                            ScheduleTable(classes: listClasses),
                            SizedBox(height: 20.0),
                            Text('Step 2: Assessment', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: error )),
                            SizedBox(height: 20.0),
                            Text('The following expenses below was covered by the Universal Access to Quality Tertiary Education Act or CHED Unifast (RA 10931).'),
                            SizedBox(height: 20.0),
                            (!(data1 != '' && ((_PESched.isNotEmpty && _selectedPE != '') || (_PESched.isEmpty && _selectedPE == ''))) ? (SimpleDialog(
                              backgroundColor: Colors.white,
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                                        child: CircularProgressIndicator(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text('This process will take a while. Please wait for the data to be loaded.', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: error )),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )): Text('')),
                            // LoadingIndicatorDialog().show(context),
                            // if (data1 != '' && ((_PESched.isNotEmpty && _selectedPE != '') || (_PESched.isEmpty && _selectedPE == ''))) { LoadingIndicatorDialog().dismiss()},
                            SizedBox(height: 20.0),
                            ScheduleFeeTable(fees: listFees),
                            ButtonFill(buttonText: 'Confirm Enrollment',
                              onPressed: (data1 != '' && ((_PESched.isNotEmpty && _selectedPE != '') || (_PESched.isEmpty && _selectedPE == ''))) ? continued : null,
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0 ?
                        StepState.complete : StepState.disabled,
                      ),
                      Step(
                        title: new Text(''),
                        label: Text('SER', style: TextStyle(fontSize: 10)),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Step 2: Download SER', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: error )),

                            Text('You are officially Enrolled!', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: error )),
                            SizedBox(height: 20.0),
                            Text('Welcome PLMAyer!',style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.0),
                            Text('Please save a copy or print your Student Enrollment Record (SER) to be officially registered or enrolled, and be added to your subjects MS Teams.'
                            '\n\n Classes start on ${classStart1.toString()}',style: TextStyle(fontSize: 19.0) ),
                            ButtonFill(buttonText: 'Download',
                                onPressed: () {download(info: listInfo, classes: listClasses, fees: listFees);}
                            ),
                            ButtonFill(buttonText: 'Done',
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                }),
                          ],
                        ),
                        isActive:_currentStep >= 0,
                        state: _currentStep >= 1 ?
                        StepState.complete : StepState.disabled,
                      ),
                    ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget _uiSetUp2(BuildContext context) {
    return WillPopScope(
      onWillPop: exitConfirm,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Enrollment'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  controlsBuilder: (context, controller) {
                    return const SizedBox.shrink();
                  },
                  type: StepperType.horizontal,
                  // type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: new Text(''),
                      label: Text('Schedule & Assessment', style: TextStyle(fontSize: 10)),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Step 1: Schedule', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: error )),
                          SizedBox(height: 20.0),
                          Text('This is your schedule for the ${aysem1.toString()} .The following schedule was provided by your department.'),
                          SizedBox(height: 20.0),
                          ScheduleTable(classes: listClasses),
                          SizedBox(height: 20.0),
                          Text('Step 2: Assessment', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: error )),
                          SizedBox(height: 20.0),
                          Text('The following expenses below was covered by the Universal Access to Quality Tertiary Education Act or CHED Unifast (RA 10931).'),
                          SizedBox(height: 20.0),
                          ScheduleFeeTable(fees: listFees),
                          ButtonFill(buttonText: 'Confirm Enrollment',
                            onPressed: data1 != '' ? continued : null,
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0 ?
                      StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: new Text(''),
                      label: Text('SER', style: TextStyle(fontSize: 10)),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Step 2: Download SER', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: error )),

                          Text('You are officially Enrolled!', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: error )),
                          SizedBox(height: 20.0),
                          Text('Welcome PLMAyer!',style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10.0),
                          Text('Please save a copy or print your Student Enrollment Record (SER) to be officially registered or enrolled, and be added to your subjects MS Teams.'
                              '\n\n Classes start on ${classStart1.toString()}',style: TextStyle(fontSize: 19.0) ),
                          ButtonFill(buttonText: 'Download',
                              onPressed: () {download(info: listInfo, classes: listClasses, fees: listFees);}
                          ),
                          ButtonFill(buttonText: 'Done',
                              onPressed: () {const HomePage();}
                          ),
                        ],
                      ),
                      isActive:_currentStep >= 0,
                      state: _currentStep >= 1 ?
                      StepState.complete : StepState.disabled,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> download({required List<UserSchoolResponseModel> info, required List<ScheduleResponseModel> classes, required List<FeesResponseModel> fees} ) async {
    final storage = new FlutterSecureStorage();
    final pdf = pw.Document();
    final fontBold = await rootBundle.load("assets/fonts/Lato-Bold.ttf");
    final ttfBold = pw.Font.ttf(fontBold);
    final studentName = await storage.read(key: 'username');
    final studentNumber = await storage.read(key: 'userid');
    // final yearSemester = 'AY ${selectedYear}' + '-${selectedSemester} ';
    List<ScheduleResponseModel> classesList = [];
    List<UserSchoolResponseModel> infoList = [];
    List<FeesResponseModel> feesList = [];
    classes.forEach((e) => {classesList.add(e)});
    fees.forEach((e) => {feesList.add(e)});
    info.forEach((e) => {infoList.add(e)});

    var now = new DateTime.now();
    var formatter = new DateFormat.yMMMMd('en_US');
    String formattedDate = formatter.format(now);

    final yellow = PdfColor.fromHex('EAB700');
    final red = PdfColor.fromHex('A31920');

    final image = pw.MemoryImage(
        (await rootBundle.load('assets/images/plmseal.png')).buffer
            .asUint8List());
    pdf.addPage(
      pw.MultiPage(
          margin: pw.EdgeInsets.all(50),
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return <pw.Widget>[
              pw.Column(
                children: [
                  pw.Container(
                    width: 30,
                    height: 30,
                    child: pw.Image(image),
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.SizedBox(width:10.0),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('PAMANTASAN NG LUNGSOD NG MAYNILA',
                                  style: pw.TextStyle(fontSize: 8,font: ttfBold)),
                              pw.Text('University of the City of Manila', style: pw.TextStyle(fontSize: 6)),
                              pw.Text('Intramuros, Manila', style: pw.TextStyle(fontSize: 6)),
                            ]
                        ),
                        pw.SizedBox(width: 30.0),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('STUDENT ENROLLMENT RECORD', style: pw.TextStyle(fontSize:10,font: ttfBold )),
                              pw.Text('${aysem1.toString()}', style: pw.TextStyle(fontSize:8,font: ttfBold )),
                            ]
                        ),
                        pw.SizedBox(width: 10.0),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('STUDENTS COPY', style: pw.TextStyle(fontSize:10,font: ttfBold )),
                              pw.Text('Mobile App', style: pw.TextStyle(fontSize:8,font: ttfBold )),
                            ]
                        )
                      ]
                  ),
                  // Student Information
                  pw.SizedBox(height: 8.0),
                  pw.Table.fromTextArray(
                      headerStyle: pw.TextStyle(
                          fontSize: 8, font: ttfBold),
                      data: <List<dynamic>>[
                        <String>[
                          'Student No.\n ${userId1.toString()}',
                          'Student Name \n ${studentName}',
                          'Student Type',
                          'Year level:',
                          'Control No.: ',
                        ],
                        ...infoList.map((info) =>[
                          info.studId,
                          info.detail,
                          info.studentType,
                          info.yearLevel,
                          info.regCode,
                        ]).toList(),

                        <String>[
                          'College ',
                          'Course',
                          'Type',
                          'Registration Status',
                        ],
                        ...infoList.map((info) =>[
                          info.unit,
                          info.progTitle,
                          info.studentType,
                          info.regCode,
                        ]).toList(),
                      ]
                  ),
                  //Student Schedule
                  pw.SizedBox(height: 8.0),
                  pw.Table.fromTextArray(
                      headerStyle: pw.TextStyle(
                          fontSize: 8, font: ttfBold, color: red),
                      data: <List<dynamic>>[
                        <String>[
                          'SUBJECT CODE',
                          'UNITS',
                          'SCHEDULE'
                        ],
                        ...classesList.map((classes) =>[
                          classes.classCode,
                          classes.units,
                          classes.schedule,
                        ]).toList(),
                      ]
                  ),

                  //Student Assessment
                  pw.SizedBox(height: 15.0),
                  pw.Table.fromTextArray(
                      headerStyle: pw.TextStyle(
                          fontSize: 8, font: ttfBold, color: red),
                      data: <List<dynamic>>[
                        <String>[
                          'Fee Code',
                          'Amount'
                        ],
                        ...feesList.map((fees) =>[
                          fees.itemName,
                          fees.itemAmount
                        ]).toList(),
                      ]

                  ),
                  pw.Text('Remarks:This enrollment becomes official until all requirements are complied with.', style: pw.TextStyle(fontSize: 8)),
                  pw.SizedBox(height: 15.0),
                  pw.Table.fromTextArray(
                      headerStyle: pw.TextStyle(
                          fontSize: 8),
                      data: <List<dynamic>>[
                        <String>[
                          'Encoder: \n ${userId1.toString()}  ',
                          'Date:\n ${formattedDate.toString()}',
                          'Reference: \nRA 10931',
                          'Date and Signature:\n\n',
                          'Amount Due:\n\n${amtDue1.toString()}',
                        ],
                      ]
                  ),
                ],
              )
            ];
          }
      ),
    );

    final output = (await getExternalStorageDirectory())!.path;
    final file = File("${output}/SER.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }
}

class ScheduleFeeTable extends StatelessWidget {
  const ScheduleFeeTable({
    super.key,
    required this.fees,
  });

  final List<FeesResponseModel> fees;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      horizontalMargin: 5.0,
      dataRowMaxHeight: 60.0,
      columnSpacing: 20.0,
      columns: const <DataColumn>[
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
      ],
      rows: fees.map((e) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text(e.itemName)),
            DataCell(Text(e.itemAmount)),
          ],
        );
      }).toList(),
    );
  }
}

class InfoTable extends StatelessWidget {
  const InfoTable({
    super.key,
    required this.info,
  });

  final List<UserSchoolResponseModel> info;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      horizontalMargin: 5.0,
      dataRowMaxHeight: 60.0,
      columnSpacing: 20.0,
      columns: const <DataColumn>[
        DataColumn(label: Text('Student No.')),
        DataColumn(label: Text('Student Name')),
        DataColumn(label: Text('Student Type')),
        DataColumn(label: Text('Year Level')),
        DataColumn(label: Text('Control No.')),
      ],
      rows: info.map((e) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text(e.studId)),
            DataCell(Text(e.detail)),
            DataCell(Text(e.studentType)),
            DataCell(Text(e.yearLevel)),
            DataCell(Text(e.yearLevel)),
          ],
        );
      }).toList(),
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
  final String unit;


  UserSchoolResponseModel(
      {required this.detail,
        required this.studId,
        required this.studentType,
        required this.regCode,
        required this.progTitle,
        required this.yearLevel,
        required this.plmemail,
        required this.unit,
      });

  factory UserSchoolResponseModel.fromJson(Map<String, dynamic> json) {
    return UserSchoolResponseModel(
      studId: json['studentId'] != null ? json["studentId"] : "",
      studentType: json['studentType'] != null ? json["studentType"] : "",
      regCode: json['regCode'] != null ? json["regCode"] : "",
      progTitle: json['progTitle'] != null ? json["progTitle"] : "",
      yearLevel: json['yearLevel'] != null ? json["yearLevel"] : "",
      plmemail: json['plmemail'] != null ? json["plmemail"] : "",
      detail: json["detail"] != null ? json["detail"] : "",
      unit: json["unit"] != null ? json["unit"] : "",
    );
  }
}
