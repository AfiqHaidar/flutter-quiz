import 'package:flutter/material.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/questions_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.answer, this.retry, {super.key});

  final List<String> answer;
  final void Function() retry;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < answer.length; i++) {
      summary.add({
        'index': i,
        'question': questions[i].text,
        'q_answer': questions[i].answers[0],
        'user_answer': answer[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final sumData = getSummaryData();
    final numQuestion = answer.length;
    final numCor = sumData.where((data) {
      return data['user_answer'] == data['q_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Corrent $numCor out of $numQuestion'),
          SizedBox(
            height: 30,
          ),
          QuestionSummary(sumData),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: retry,
            child: Text('retry'),
          )
        ],
      ),
    );
  }
}
