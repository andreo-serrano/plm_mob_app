import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../model/grades_model.dart';
import '../../model/progressHUD.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';
import '../../widgets/appbar.dart';
import '../../widgets/button.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/src/pdf/color.dart';
import 'package:pdf/src/pdf/page_format.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class Grades extends StatefulWidget {
  @override
  _GradesState createState() {
    return _GradesState();
  }
}

class _GradesState extends State {
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  bool isApiCallProcess = false;
  bool _isVisible = false;

  String? _selectedYear;
  String? _selectedSemester;

  Map<String, List<String>> _yearToTerms = {};
  List<YearTerm> _currentGrade = [];
  List<YearTerm> _gradesFromAPI = [];

  void initState() {
    super.initState();
    fetchGrades();
  }

  void fetchGrades() async {
    _gradesFromAPI = await APIService().getYearTerms();
    // for each years, get the terms
    _gradesFromAPI.forEach((element) {
      if (_yearToTerms.containsKey(element.year)) {
        _yearToTerms[element.year]?.add(element.term);
      } else {
        _yearToTerms[element.year] = [element.term];
      }
    });
    // for each year, add an additional '4' for "All Terms"
    _yearToTerms.forEach((key, value) {
      _yearToTerms[key]?.add('4');
    });
    setState(() {});
  }

  void fetchName() async {

  }

  List<YearTerm> getGradeWithYearTerm(String year, String term) {
    // if term is '4', select all semesters
    if (term == '4') {
      return _gradesFromAPI.where((element) => element.year == year).toList();
    } else {
      return _gradesFromAPI
          .where((element) => element.year == year && element.term == term)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetUp(context),
      inAsyncCall: isApiCallProcess,
    );
  }

  @override
  Widget _uiSetUp(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomSliverAppBar(
        text: 'Grades',
        image: 'assets/images/On1.jpg',
        isCenter: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                  "Select from the choices below the specific academic year and  semester of the  grades you want to view.",
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 20),
              Text("Please select the year and semester"),
              SizedBox(height: 20),
              DropdownButton<String>(
                isExpanded: true,
                hint: Text("Select Academic Year",
                    style: Theme.of(context).textTheme.bodyMedium),
                value: _selectedYear,
                icon: const Icon(Icons.arrow_drop_down_sharp),
                elevation: 16,
                items: _yearToTerms.keys.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _selectedYear = value;
                    _selectedSemester = null;
                    _isVisible = false;
                  });
                },
              ),
              DropdownButton<String>(
                isExpanded: true,
                hint: Text("Select Semester",
                    style: Theme.of(context).textTheme.bodyMedium),
                value: _selectedSemester,
                icon: const Icon(Icons.arrow_drop_down_sharp),
                elevation: 16,
                items: _yearToTerms[_selectedYear]?.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: value == '1'
                        ? Text('First Semester')
                        : value == '2'
                            ? Text('Second Semester')
                            : value == '3'
                                ? Text('Summer')
                                : Text('All Terms'),
                  );
                }).toList(),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _selectedSemester = value;
                    _isVisible = false;
                  });
                },
              ),
              ButtonFill(
                buttonText: 'Submit',
                onPressed: () {
                  if (_selectedYear != null && _selectedSemester != null) {
                    _currentGrade = getGradeWithYearTerm(
                        _selectedYear!, _selectedSemester!);
                    _isVisible = true;
                    setState(() {});
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Please select a year and semester'),
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
              Visibility(
                visible: _isVisible,
                child: Column(
                  children: [
                    YearTermDataTable(yearTerms: _currentGrade),
                    ButtonFill(
                        buttonText: 'Download',
                        onPressed: () {download(_currentGrade, _selectedYear, _selectedSemester);},
                    ),
                  ],
                ),
              ),
              // YearTermDataTable(yearTerms: selectedGrades),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> download(List<YearTerm> grades, String? selectedYear, String? selectedSemester ) async {
    final storage = new FlutterSecureStorage();
    final pdf = pw.Document();
    final fontBold = await rootBundle.load("assets/fonts/Lato-Bold.ttf");
    final ttfBold = pw.Font.ttf(fontBold);
    final studentName = await storage.read(key: 'username');
    final studentNumber = await storage.read(key: 'userid');
    final yearSemester = 'AY ${selectedYear}' + '-${selectedSemester} ';
    List<GradesResponseModel> gradesList = [];
    grades.forEach((e) => (e.grades.forEach((element) {gradesList.add(element);})));

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
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Container(
                          width: 50,
                          height: 50,
                          child: pw.Image(image),
                        ),
                        pw.SizedBox(width: 10.0),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('PAMANTASAN NG LUNGSOD NG MAYNILA',
                                  style: pw.TextStyle(fontSize: 12,
                                      font: ttfBold,
                                      color: yellow)),
                              pw.Text('UNIVERSITY OF THE CITY OF MANILA'),
                            ]
                        ),
                        pw.SizedBox(width: 80.0),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text(
                                  'Logged in as Student No. ${studentNumber}',
                                  style: pw.TextStyle(fontSize: 8)),
                              pw.Text('${formattedDate}',
                                  style: pw.TextStyle(fontSize: 8)),
                            ]
                        )
                      ]
                  ),
                  pw.SizedBox(height: 20.0),
                  pw.Column(
                      children: [
                        pw.Text('STUDENT NO: ${studentNumber}'),
                        pw.Text('NAME: ${studentName}'),
                      ]),
                  pw.SizedBox(width: 40.0),
                  pw.Text('${yearSemester} GRADES', style: pw.TextStyle(
                      fontSize: 24, font: ttfBold, color: red)),
                  pw.SizedBox(height: 20.0),
                  pw.Table.fromTextArray(
                      headerStyle: pw.TextStyle(
                          fontSize: 12, font: ttfBold, color: red),
                      data: <List<dynamic>>[
                        <String>[
                          'SUBJECT',
                          'SUBJECT TITLE',
                          'GRADE',
                          'REMARKS'
                        ],
                        ...gradesList.map((grade) =>[
                              grade.subjectCode,
                              grade.subjectTitle,
                              grade.grades,
                              grade.remarks,
                        ]).toList(),
                      ]
                  )
                ],
              )
            ];
          }
      ),
    );

    final output = (await getExternalStorageDirectory())!.path;
    final file = File("${output}/GRADES.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }

}

class YearTermDataTable extends StatelessWidget {
  final List<YearTerm> yearTerms;

  YearTermDataTable({required this.yearTerms});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      horizontalMargin: 5.0,
      columnSpacing: 10.0,
      columns: [
        DataColumn(label: Text('Subject')),
        DataColumn(label: Text('Subject Title')),
        DataColumn(label: Text('Grade')),
        DataColumn(label: Text('Remarks')),
      ],
      rows: yearTerms.fold<List<DataRow>>(
        [],
        (previousValue, yearTerm) => previousValue
          ..addAll(yearTerm.grades.map((grade) => DataRow(cells: [
                DataCell(Text(grade.subjectCode ?? '')),
                DataCell(Text(grade.subjectTitle ?? '')),
                DataCell(Text(grade.grades ?? '')),
                DataCell(Text(grade.remarks ?? '')),
              ]))),
      ),
    );
  }
}
