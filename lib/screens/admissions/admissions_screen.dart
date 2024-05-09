import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:plmmobileapp_v2/screens/admissions/admission_lawtest_screen.dart';
import 'package:plmmobileapp_v2/screens/admissions/admission_medtest_screen.dart';
import 'package:plmmobileapp_v2/screens/admissions/admission_scholarship_screen.dart';
import 'package:plmmobileapp_v2/screens/admissions/admission_undergrad_screen.dart';
import 'package:plmmobileapp_v2/widgets/button.dart';

import 'admission_test_screen.dart';

class AdmissionsPage extends StatefulWidget {
  const AdmissionsPage({super.key});

  @override
  State<AdmissionsPage> createState() => _AdmissionsPageState();
}

class _AdmissionsPageState extends State<AdmissionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admissions'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admissions',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Color.fromARGB(248, 234, 183, 0),
                ),
              ),
              SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text:
                            'Study at PLM and be among the few who are privileged to study at the historic intramuros district of Manila.\n\nDid you know? In 2018, only '),
                        TextSpan(
                            text: '9%',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' of the '),
                        TextSpan(
                            text: '39,385',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                            ' applicants enrolled at PLM. As of August 2019, '),
                        TextSpan(
                            text: '6,636',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' undergraduate students are enrolled at PLM.')
                      ])),
              SizedBox(height: 10),
              ButtonText(
                text: Text('PLM Admission'),
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PLMATPage()));
                },
              ),
              ButtonText(
                text: Text('Medical College Admission Test'),
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MedTestPage()));
                },
              ),
              ButtonText(
                text: Text('College Law Admission Test'),
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LawTestPage()));
                },
              ),
              ButtonText(
                text: Text('Scholarships and Financial Aid'),
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScholarshipPage()));
                },
              ),
              ButtonText(
                text: Text('Undergraduate Programs'),
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UndergradPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}