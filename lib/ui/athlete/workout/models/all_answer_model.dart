class AllAnswerModel {
  String? questionId;
  String? answer;

  AllAnswerModel({this.questionId, this.answer});

  AllAnswerModel.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['answer'] = answer;
    return data;
  }
}
