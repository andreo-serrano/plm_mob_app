import 'package:flutter/material.dart';
import 'student_home.dart';

import '../../model/sfemodel/eval_list_model.dart';
import '../../model/sfemodel/sfe_choice_mode.dart';
import '../../model/sfemodel/sfe_question_model.dart';
import '../../services/api_service.dart';
import '../../utils/sfe/sfeechoicedata.dart';
import '../../utils/sfe/sfequestiondata.dart';


class SFEEvaluationPage extends StatefulWidget {
  final String? facultyName;
  final String? facultySubject;

  SFEEvaluationPage({required this.facultyName, required this.facultySubject});

  @override
  State<SFEEvaluationPage> createState() => _SFEEvaluationPage();
}

class _SFEEvaluationPage extends State<SFEEvaluationPage> {
  int currentQuestionIndex = 0;
  final int questionsPerPage = 10;
  Map<int, dynamic> selectedChoices = {
  }; // Track selected choices for each question
  ScrollController _scrollController = ScrollController();
  Map<int, TextEditingController> textControllers = {};

  List<SFEQuestionModel> listQuestion = [];

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    loadNews();
  }

  void loadNews() async {
    APIService apiService = new APIService();
    List<SFEQuestionModel> data = await apiService.fetchSFEQuestion();
    setState(() {
      listQuestion = data;
    });
    print("LIST QUESTION ${listQuestion}");
  }


  List<SFEQuestionModel> get filteredQuestionsList {
    // Filter questions based on questionCode starting with "I", "II", and "III"
    return listQuestion
        .where((question) =>
    question.questionCode.startsWith("I") ||
        question.questionCode.startsWith("II") ||
        question.questionCode.startsWith("III"))
        .toList();
  }

  int get currentPageIndex {
    return currentQuestionIndex ~/ questionsPerPage;
  }

  List<SFEQuestionModel> get currentPageQuestions {
    int startIndex = currentPageIndex * questionsPerPage;
    int endIndex = startIndex + questionsPerPage;
    endIndex = endIndex > filteredQuestionsList.length
        ? filteredQuestionsList.length
        : endIndex;
    return filteredQuestionsList.sublist(startIndex, endIndex);
  }

  bool get isLastQuestion {
    int lastPageIndex = (filteredQuestionsList.length - 1) ~/ questionsPerPage;
    int currentPage = currentQuestionIndex ~/ questionsPerPage;
    return currentPage == lastPageIndex;
  }


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
        title: Text("${widget.facultyName}  ${widget.facultySubject}" ?? ''),
        actions: [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: currentPageQuestions.length,
                itemBuilder: (context, index) {
                  SFEQuestionModel question = currentPageQuestions[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          '${question.questionCode} ${question.questionDesc}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      if (question.questionChoiceType == 11)
                        SingleChildScrollView(
                          child: Form(
                            child: Column(
                              children: question.choiceList.map((choice) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        // Update the selectedChoices map with the user's input
                                        selectedChoices[question.questionId] = value;
                                      });
                                    },
                                    // validator: (value) {
                                    //   // Add validation logic here if required
                                    //   if (value.isEmpty) {
                                    //     return 'Please enter a value';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      else
                        if (question.questionChoiceType == 10)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Row(
                                children: question.choiceList.map((choice) {
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Text(choice.choiceDesc,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 10,),
                                          Container(
                                            child: Row(
                                              children: [
                                                Radio<int>(
                                                  activeColor: Color(
                                                      0xFFDAA300),
                                                  value: choice.choiceId,
                                                  groupValue: selectedChoices[question
                                                      .questionId],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedChoices[question
                                                          .questionId] = value!;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        else
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: question.choiceList.map((choice) {
                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(choice.choiceDesc, style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10,),
                                      Container(
                                        color: Colors.grey[100],
                                        child: Row(
                                          children: [
                                            Radio<int>(
                                              activeColor: Color(0xFFDAA300),
                                              value: choice.choiceId,
                                              groupValue: selectedChoices[question
                                                  .questionId],
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedChoices[question
                                                      .questionId] = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      SizedBox(height: 10,),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: previousPage,
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
                    SizedBox(width: 8.0),
                    Text(
                        "Previous Page", style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              Spacer(),
              TextButton(
                child: Row(
                  children: [
                    SizedBox(width: 8.0),
                    Text(isLastQuestion ? "Submit" : "Next Page",
                      style: TextStyle(color: Colors.black),),
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,),
                  ],
                ),
                onPressed: () {
                  if (isLastQuestion) {
                    submitEvaluation();
                  } else {
                    nextPage();
                  }
                  print(isLastQuestion);
                },
              ),
            ],
          ),
        ],
      ),

    );
  }


  void previousPage() {
    if (currentQuestionIndex >= questionsPerPage) {
      setState(() {
        scrollToTop();
        currentQuestionIndex -= questionsPerPage;
      });
    }
  }

  void nextPage() {
    if (currentQuestionIndex <
        filteredQuestionsList.length - questionsPerPage) {
      setState(() {
        scrollToTop();
        currentQuestionIndex += questionsPerPage;
      });
    }
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void submitEvaluation() async {

    APIService apiService = new APIService();
    // Create an instance of the EvaluationListModel with selected choices
    EvaluationListModel evaluationModel = EvaluationListModel(
      studentId: 6, // Replace with the actual student ID
      classId: 8, // Replace with the actual class ID
      facultyId: 2, // Replace with the actual faculty ID
      updatedOn: "",
      fromDb: 2,
      i1: selectedChoices[1] ?? 0, // Replace 1 with the actual question ID for I-1
      i2: selectedChoices[2] ?? 0, // Replace 2 with the actual question ID for I-2
      i3: selectedChoices[3] ?? 0, // Replace 3 with the actual question ID for I-3
      i4: selectedChoices[4] ?? 0, // Replace 4 with the actual question ID for I-4
      i5: selectedChoices[5] ?? 0, // Replace 5 with the actual question ID for I-5
      i6: selectedChoices[6] ?? 0,
      i7: selectedChoices[7] ?? 0,
      i8: selectedChoices[8] ?? 0,
      i9: selectedChoices[9] ?? 0,
      i10: selectedChoices[10] ?? 0,
      i11: selectedChoices[11] ?? 0,
      i12: selectedChoices[12] ?? 0,
      i13: selectedChoices[13] ?? 0,
      i14: selectedChoices[14] ?? 0,
      i15: selectedChoices[15] ?? 0,
      i16: selectedChoices[16] ?? 0,
      i17: selectedChoices[17] ?? 0,
      i18: selectedChoices[18] ?? 0,
      i19: selectedChoices[19] ?? 0,
      i20: selectedChoices[20] ?? 0,
      i21: selectedChoices[21] ?? 0,
      i22: selectedChoices[22] ?? 0,
      i23: selectedChoices[23] ?? 0,
      i24: selectedChoices[24] ?? 0,
      i25: selectedChoices[25] ?? 0,
      i26: selectedChoices[26] ?? 0,
      i27: selectedChoices[27] ?? 0,
      i28: selectedChoices[28] ?? 0,
      i29: selectedChoices[29] ?? 0,
      i30: selectedChoices[30] ?? 0,
      i31: selectedChoices[31] ?? 0,
      i32: selectedChoices[32] ?? 0,
      i33: selectedChoices[33] ?? 0,
      i34: selectedChoices[34] ?? 0,
      i35: selectedChoices[35] ?? 0,
      i36: selectedChoices[36] ?? 0,
      i37: selectedChoices[37] ?? 0,
      i38: selectedChoices[38] ?? 0,
      i39: selectedChoices[39] ?? 0,
      i40: selectedChoices[40] ?? 0,
      i411: selectedChoices[41] ?? 0,
      i412: selectedChoices[42] ?? 0,
      i413: selectedChoices[43] ?? 0,
      i414: selectedChoices[44] ?? 0,
      i415: selectedChoices[45] ?? 0,
      i416: selectedChoices[46] ?? 0,
      i417: selectedChoices[47] ?? 0,
      i418: selectedChoices[48]?.toString() ?? '',
      i42: selectedChoices[49] ?? 0,
      i43: selectedChoices[50] ?? 0,
      i44: selectedChoices[51].toString() ?? '',
      i45: selectedChoices[52] ?? 0,
      i46: selectedChoices[53].toString() ?? '',
      i47: selectedChoices[54].toString() ?? '',
      i48: selectedChoices[55].toString() ?? '',
      i49: selectedChoices[56].toString() ?? '',
      ii1: selectedChoices[57] ?? 0,
      ii2: selectedChoices[58] ?? 0,
      ii3: selectedChoices[59] ?? 0,
      ii4: selectedChoices[60] ?? 0,
      ii5: selectedChoices[61] ?? 0,
      ii6: selectedChoices[62] ?? 0,
      ii7: selectedChoices[63] ?? 0,
      ii8: selectedChoices[64] ?? 0,
      ii9: selectedChoices[65] ?? 0,
      ii10: selectedChoices[66].toString() ?? '',
      ii11: selectedChoices[67].toString() ?? '',
      ii12: selectedChoices[68] ?? 0,
      ii13: selectedChoices[69] ?? 0,
      ii14: selectedChoices[70] ?? 0,
      ii15: selectedChoices[71].toString() ?? '',
      ii16: selectedChoices[72].toString() ?? '',
      iii1: selectedChoices[73] ?? 0,
      iii2: selectedChoices[74] ?? 0,
      iii3: selectedChoices[75] ?? 0,
      iii4: selectedChoices[76] ?? 0,
      iii5: selectedChoices[77] ?? 0,
      iii6: selectedChoices[78] ?? 0,
      iii7: selectedChoices[79] ?? 0,
      iii8: selectedChoices[80] ?? 0,
      iii9: selectedChoices[81] ?? 0,
      iii10: selectedChoices[82].toString() ?? ''
      // ...
    );

    // Call the submitEval function to post the data
    final response = await apiService.submitEval(evaluationModel);

    if (response != null) {
      // Successfully submitted the evaluation, handle the response here
      // For example, you can navigate to a success page or show a success message.
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SFEHomePage()));
    } else {
      // Handle the case when there is an error in submission
      // For example, you can show an error message to the user.
      // You may also want to handle the error in the `submitEval` function itself and return an error response.
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Error'),
              content: Text('Failed to submit evaluation.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }
}