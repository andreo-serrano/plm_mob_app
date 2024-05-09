

class SFEChoiceModel {
  int choiceId;
  String choiceCode;
  String choiceDesc;
  int choiceNum;
  double choicePosVal;
  double? choiceNegVal;

  SFEChoiceModel(
      {
      required this.choiceId,
      required this.choiceCode,
      required this.choiceDesc,
      required this.choiceNum,
      required this.choicePosVal,
      required this.choiceNegVal});


  factory SFEChoiceModel.fromJson(Map<String, dynamic> json) {
    return SFEChoiceModel(
      choiceId: int.parse(json['choiceid'] ?? '0'), // Provide a default value (0 in this case) if 'choiceid' is null
      choiceCode: json['choicecode'] ?? '',
      choiceDesc: json['choicedesc'] ?? '',
      choiceNum: int.parse(json['choicenum'] ?? '0'), // Provide a default value (0 in this case) if 'choicenum' is null
      choicePosVal: double.parse(json['posvalue'] ?? '0.0'), // Provide a default value (0.0 in this case) if 'posvalue' is null
      choiceNegVal: double.tryParse(json['negvalue'].toString() ?? '0.0'), // Provide a default value (0.0 in this case) if 'negvalue' is null
    );
  }
}