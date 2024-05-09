import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../widgets/bulletList.dart';

import '../../widgets/button.dart';

class ScholarshipPage extends StatefulWidget {
  const ScholarshipPage({super.key});

  @override
  State<ScholarshipPage> createState() => _ScholarshipPageState();
}

class _ScholarshipPageState extends State<ScholarshipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scholarships'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scholarships and Financial Aid',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Color.fromARGB(255, 163, 25, 32),
                    ),
              ),
              SizedBox(height: 30),
              Text(
                'PLM partners with foundations and generous individuals to provide poor but deserving students the fighting chance that they deserve. Depending on the partners, scholars receive monthly stipends, book allowance, and even a year-end bonus.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 30),
              Text(
                'AY 2020-2021 Scholarship Partners',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10),
              Text(
                'For the Academic Year 2019-2020, 26 scholarship partners provide PLM students with not only financial assistance but also trainings and opportunities for exposure. Out of the 26, 17 are group sponsors and nine are individual providers.',
              ),
              SizedBox(height: 30),
              Text('The following are the group scholarship providers:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
              SizedBox(height: 20),
              BulletList([
                'AMY Foundation',
                'Alfonso Yuchengco Foundation (new partner)',
                'Andres Tamayo Foundation',
                'Buddhist Tzu Chi Foundation',
                'Cebuana Lhuillier Foundation (new partner)',
                'Charity First Foundation',
                'Chinese Filipino Business Club',
                'Gokongwei Brothers Foundation, Inc. (new partner)',
                'International Container Terminal Services, Inc.',
                'JAPRL Foundation',
                'Lingap Adhikain Foundation',
                'Luis Co Chi Kiat Foundation',
                'Manila Mt. Lebanon',
                'Master Rui Miao Foundation',
                'MegaWide Foundation',
                'Megaworld Foundation',
                'PLM-Scholarship Foundation, Inc.',
                'Rotary Club of Manila',
                'Security Bank Foundation',
                'Simplicio Gamboa, Sr. Foundation',
                'SM Foundation'
              ]),
              SizedBox(height: 30),
              ButtonFill(buttonText: 'Apply', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
