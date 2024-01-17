class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question(this.questionText, this.options, this.correctAnswerIndex);


  // toMap
  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }

  // fromMap
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
       map['questionText'] ?? '',
      (map['options'] as List<dynamic>?)?.cast<String>() ?? [],
       map['correctAnswerIndex'] ?? 0,
    );
  }

}
