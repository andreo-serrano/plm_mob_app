import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../mcat/mcat_screen.dart';
import '../../widgets/button.dart';

import '../../widgets/appbar.dart';

class MedTestPage extends StatefulWidget {
  const MedTestPage({super.key});

  @override
  State<MedTestPage> createState() => _MedTestPageState();
}

class _MedTestPageState extends State<MedTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomSliverAppBar(
      text: 'College of Medicine Admission Test',
      image: 'assets/images/med.jpg',
      isCenter: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                          text:
                          'The Pamantasan ng Lungsod ng Maynila (PLM) College of Medicine is a professional school committed to excellence in community-oriented medical education, training, research, and service. It has consistently achieved a passing rate of 95 to 100% on the Physician Licensure Exam in recent years. In 2022, the Professional Regulation Commission named the PLM College of Medicine as the second-best performing institution in the licensure examination for that year.'),
                      TextSpan(
                          text:
                          '\n\nThe PLM College of Medicine accepts applicants for its degree program in Doctor of Medicine on an annual basis. For AY 2024-2025, the application and submissions of requirements is on '),
                      TextSpan(
                          text: 'November 13, 2023 - February 29, 2024.',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: ' The College Committee on Admissions will select the highest-ranking applicants based on the admissions criteria.'),
                    ])),
            SizedBox(height: 10),
            Text(
              'Enrollment Instructions',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Color.fromARGB(255, 0, 102, 153),
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 30),
            Text(
              'Tuition-Free Education',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Color.fromARGB(255, 0, 102, 153),
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 10),
            ButtonFill(buttonText: 'Apply',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MCATApp()));
                }),
          ],
        ),
      ),
    ));
  }
}
