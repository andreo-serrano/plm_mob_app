import 'sfe_choice_mode.dart';

class SFEQuestionModel {
  int questionId;
  String questionCode;
  String questionDesc;
  int questionAssesType;
  int questionChoiceType;
  int questionNegative;
  int questionNum;
  int questionInstructions;
  List<SFEChoiceModel> choiceList;

  SFEQuestionModel({
      required this.questionId,
      required this.questionCode,
      required this.questionDesc,
      required this.questionAssesType,
      required this.questionChoiceType,
      required this.questionNegative,
      required this.questionNum,
      required this.questionInstructions,
      required this.choiceList,
    });



  factory SFEQuestionModel.fromJson(Map<String, dynamic> json) {
    return SFEQuestionModel(
      questionId: int.parse(json['id'] ?? '0'), // Provide a default value (0 in this case) if 'id' is null
      questionCode: json['code'] ?? '',
      questionDesc: json['desc'] ?? '',
      questionAssesType: int.parse(json['assesstype'] ?? '0'), // Provide a default value (0 in this case) if 'assesstype' is null
      questionChoiceType: int.parse(json['choicetype'] ?? '0'), // Provide a default value (0 in this case) if 'choicetype' is null
      questionNegative: int.parse(json['negative'] ?? '0'), // Provide a default value (0 in this case) if 'negative' is null
      questionNum: int.parse(json['questionno'] ?? '0'), // Provide a default value (0 in this case) if 'questionno' is null
      questionInstructions: int.parse(json['instructions'] ?? '0'), // Provide a default value (0 in this case) if 'instructions' is null
      choiceList: List<SFEChoiceModel>.from(json['choices'].map((choice) => SFEChoiceModel.fromJson(choice))).toList(),
    );
  }
}
