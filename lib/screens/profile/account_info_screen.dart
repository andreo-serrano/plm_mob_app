import 'package:flutter/material.dart';
import '../../model/request.dart';
import '../../model/student_model.dart';
import '../../services/api_service.dart';

class AccountInformation extends StatefulWidget {
  @override
  _AccountInformationState createState() => _AccountInformationState();
}

class _AccountInformationState extends State {
  final columns = [' ', ' '];
  final label1 = [
    'First Name',
    'Last Name',
    'Middle Name',
    'Pedigree',
    'Gender',
    'Civil Status',
    'Email',
    "Mobile Phone"
  ];

  final label2 = [
    'Student Id',
    'Student Type',
    'Registration Code',
    'Program Title',
    'Year Level',
    'PLM Email'
  ];

  String _userName = '';
  String _userId = '';
  String _plmEmail = '';

  List<dynamic> _postPersonal = [];
  List<dynamic> _postSchool = [];

  List<DataColumn> getColumns(List<String> column) => column
      .map((String column) => DataColumn(
    label: Text(column),
  )).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((data) => DataCell(Container(
    width: MediaQuery.of(context).size.width * 0.4,
    child: Text(
      '$data',
      style: TextStyle(fontSize: 12.0),
    ),
  ))).toList();

  List<DataRow> getRows(List gradesModel, label) =>
      gradesModel.map((student) {
        var index = gradesModel.indexOf(student);
        final cells = [label[index], student[label[index]]];
        return DataRow(cells: getCells(cells));
  }).toList();

  @override
  void initState() {
    super.initState();
    fetchInformation();
  }

  void fetchInformation() async {
    APIService apiService = new APIService();
    apiService.user().then((value) async =>
    {
      await UserSecureStorage.setFirstName(value.firstname),
      await UserSecureStorage.setLastName(value.lastname),
      await UserSecureStorage.setUserEmail(value.email),
    });

    final firstname = await UserSecureStorage.getFirstName() ?? '';
    final lastname = await UserSecureStorage.getLastName() ?? '';
    final id = await UserSecureStorage.getUserId() ?? '';
    final email = await UserSecureStorage.getUserEmail() ?? '';
    final infoP = await apiService.personal();
    final infoS = await apiService.school();

    _postPersonal = [
      {'First Name': infoP.firstname},
      {'Last Name': infoP.lastname},
      {'Middle Name': infoP.middlename},
      {'Pedigree': infoP.pedigree},
      {'Gender': infoP.gender},
      {'Civil Status': infoP.civilstatus},
      {'Email': infoP.email},
      {'Mobile Phone': infoP.mobilephone},
    ];

    _postSchool = [
      {'Student Id': infoS.studId},
      {'Student Type': infoS.studentType},
      {'Registration Code': infoS.regCode},
      {'Program Title': infoS.progTitle},
      {'Year Level': infoS.yearLevel},
      {'PLM Email': infoS.plmemail}
    ];

    _userName = firstname + " " + lastname;
    _userId = id;
    _plmEmail = email;

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.35,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
          backgroundColor: Color(0xFFEAB700),
          elevation: 5,
          flexibleSpace: Container(
            padding: EdgeInsets.all(0.0),
            height: screenHeight * 0.35 + 30,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/On2.jpg"),
                opacity: 0.1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile-default.jpg"),
                    radius: 60,
                  ),
                ),
                Text(
                  "${_userName}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${_userId}",
                    style: TextStyle(
                      color: Colors.white,
                    )),
                Text("${_plmEmail}",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelColor: Colors.black,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            unselectedLabelColor: Color(0xFFE9E9E9),
            tabs: [
              Tab(text: 'Personal'),
              Tab(text: 'School'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                DataTable(
                  dividerThickness: 0.0,
                  headingRowHeight: 0.0,
                  dataRowHeight: 35.0,
                  columnSpacing: 30.0,
                  columns: getColumns(columns),
                  rows: getRows(_postPersonal, label1),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth * 0.05, 0.0, screenWidth * 0.05, 20.0),
                      child: Text(
                          "Your college shall be determined from the degree program indicated here. If the degree program is erroneous, please contact your respective college's OCS.",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                DataTable(
                  dividerThickness: 0.0,
                  headingRowHeight: 0.0,
                  dataRowHeight: 45.0,
                  columnSpacing: 30.0,
                  columns: getColumns(columns),
                  rows: getRows(_postSchool, label2),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth * 0.05, 0.0, screenWidth * 0.05, 20.0),
                      child: Text(
                          "Your college shall be determined from the degree program indicated here. If the degree program is erroneous, please contact your respective college's OCS.",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
