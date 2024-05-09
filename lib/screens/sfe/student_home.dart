import 'package:flutter/material.dart';
import 'package:plmmobileapp_v2/screens/sfe/student_faculty_evalutation.dart';
import 'package:plmmobileapp_v2/screens/sfe/student_summary_answer_screen.dart';
import 'package:plmmobileapp_v2/utils/sfe/sfefacultydata.dart';


import '../../model/sfemodel/sfe_question_model.dart';
import '../../services/api_service.dart';

class SFEHomePage extends StatefulWidget {
  final userId;

  SFEHomePage({Key? key, this.userId}) : super(key: key);

  @override
  State<SFEHomePage> createState() => _SFEHomePageState();
}
class _SFEHomePageState extends State<SFEHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffab0000),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Student Faculty Evaluation'),
        actions: [],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 14,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedIconTheme: IconThemeData(color:  Color(0xFFDAA300), size: 26),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedItemColor:  Color(0xFFDAA300),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        currentIndex: currentPageIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.summarize_outlined),
            activeIcon: Icon(Icons.summarize_rounded),
            label: 'Summary of Answers',
          ),
        ],
      ),
      body: <Widget>[

        SFEContent(),
        SFESummaryPage(),
      ][currentPageIndex],
    );
  }
}



class SFEContent extends StatefulWidget {
  @override
  State<SFEContent> createState() => _SFEContentState();
}

class _SFEContentState extends State<SFEContent> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1.2),
              3: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Center(
                        child: Text(
                          'FACULTY NAME',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Center(
                        child: Text(
                          'SUBJECT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Center(
                        child: Text(
                          'STATUS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              for (var faculty in facultyData)
                TableRow(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey[100]!,
                        width: 1.0,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey[100]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 16, 10, 12),
                        child: Center(
                          child: Text(faculty.facultyName ?? ''),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 16, 10, 12),
                        child: Center(
                          child: Text(faculty.subject ?? ''),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 16, 10, 12),
                        child: Center(
                          child: Text(faculty.status ?? ''),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SFEEvaluationPage(facultyName: faculty.facultyName, facultySubject: faculty.subject)));
                            },
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Color(0xFFDAA300)),
                              minimumSize: MaterialStateProperty.all(Size(100, 40)),
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            child: Text(
                              'Evaluate',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}






