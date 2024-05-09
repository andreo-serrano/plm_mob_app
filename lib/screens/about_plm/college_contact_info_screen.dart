import 'package:flutter/material.dart';
import '../../utils/contactdata.dart';

class ContactInformation extends StatefulWidget {
  @override
  _ContactInformationState createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  late List<Data> adminContacts, collegesContacts;
  final columns = ['Office', 'Phone', 'Email'];

  List<DataColumn> getColumns(List<String> column) => column
      .map((String column) => DataColumn(
    label: Text(column),
  ))
      .toList();

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((data) => DataCell(Container(
    width: MediaQuery.of(context).size.width / 3 - 20.0,
    child: Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Text(
        '$data',
        style: TextStyle(fontSize: 12.0),
      ),
    ),
  )))
      .toList();

  List<DataRow> getRows(List<Data> contacts) => contacts.map((Data contact) {
    final cells = [contact.office, contact.phone, contact.email];
    return DataRow(cells: getCells(cells));
  }).toList();

  @override
  void initState() {
    super.initState();
    this.adminContacts = List.of(allAdminContacts);
    this.collegesContacts =List.of(allCollegeContacts);
  }

  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 200.0,
          centerTitle: true,
          title: Container(
            height: 150,
            child: Text('Contact Information',
                style: TextStyle(fontSize: 21)),
          ),
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 80.0),
            child: Container(
              height: 158,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/plmimage.png"))),
            ),
          ),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BackButton(
                  color: Colors.white,
                  onPressed: () {Navigator.pop(context);}),
            ],
          ),
          backgroundColor: Color(0xFF006699),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Administratives',),
              Tab(text: 'Colleges'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  DataTable(
                    headingRowHeight: 40.0,
                    headingRowColor: MaterialStateProperty.all<Color>(Color(0xFFE9E9E9)),
                    dataRowHeight: 60.0,
                    columnSpacing: 10.0,
                    columns: getColumns(columns),
                    rows: getRows(adminContacts),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  DataTable(
                    headingRowHeight: 40.0,
                    headingRowColor: MaterialStateProperty.all<Color>(Color(0xFFE9E9E9)),
                    dataRowHeight: 60.0,
                    columnSpacing: 10.0,
                    columns: getColumns(columns),
                    rows: getRows(collegesContacts),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


