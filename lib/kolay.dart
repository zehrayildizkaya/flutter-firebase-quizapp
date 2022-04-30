import 'dart:async';

import 'package:zehra/gradient_box.dart';
import 'package:zehra/question.dart';
import 'package:zehra/sonuc_screen.dart';
import 'package:flutter/material.dart';

class Kolay extends StatefulWidget {
  const Kolay(
      {Key? key,
      required this.totalTime,
      required this.questions,
      required this.katsayi})
      : super(key: key);

  final int totalTime;
  final List<Question> questions;
  final int katsayi;

  @override
  _KolayState createState() => _KolayState();
}

class _KolayState extends State<Kolay> {
  late int _currentTime;
  late Timer _timer;
  int _currentIndex = 0;
  String _selectedAnswer = "";
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _currentTime = widget.totalTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print(_currentTime);
      setState(() {
        _currentTime -= 1;
      });

      if (_currentTime == 0) {
        _timer.cancel();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SonucScreen(
                  questions: widget.questions,
                  score: _score,
                )));
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentIndex];
    return Scaffold(
        body: GradientBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 40),
          SizedBox(
              height: 40,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      LinearProgressIndicator(
                          value: _currentTime / widget.totalTime),
                      Center(
                        child: Text(_currentTime.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      )
                    ],
                  ))),
          const SizedBox(height: 40),
          const Text("Question",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(height: 20),
          Text(currentQuestion.question,
              style: const TextStyle(color: Colors.white, fontSize: 20)),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final answer = currentQuestion.answers[index];
                return AnswerTile(
                  isSelected: answer == _selectedAnswer,
                  answer: answer,
                  correctAnswer: currentQuestion.correctAnswer,
                  onTap: () {
                    setState(() {
                      _selectedAnswer = answer;
                    });

                    if (answer == currentQuestion.correctAnswer) {
                      if (widget.katsayi == 1) {
                        _score++;
                      }
                      if (widget.katsayi == 2) {
                        _score += 2;
                      }
                      if (widget.katsayi == 3) {
                        _score += 3;
                      }
                    }

                    Future.delayed(const Duration(milliseconds: 300), () {
                      _score = _score;
                      if (_currentIndex == widget.questions.length - 1) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => SonucScreen(
                                  questions: widget.questions,
                                  score: _score,
                                )));
                        return;
                      }
                      setState(() {
                        _currentIndex++;
                        _selectedAnswer = '';
                      });
                    });
                  },
                );
              },
              itemCount: currentQuestion.answers.length,
            ),
          )
        ]),
      ),
    ));
  }
}

class AnswerTile extends StatelessWidget {
  const AnswerTile(
      {Key? key,
      required this.isSelected,
      required this.answer,
      required this.correctAnswer,
      required this.onTap})
      : super(key: key);

  final bool isSelected;
  final String answer;
  final String correctAnswer;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: cardColor,
        child: ListTile(
            onTap: () => onTap(),
            title: Text(answer,
                style: const TextStyle(fontSize: 20, color: Colors.black))));
  }

  Color get cardColor {
    if (!isSelected) return Colors.white;
    if (answer == correctAnswer) {
      return Colors.green;
    }
    return Colors.red;
  }
}
