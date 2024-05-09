// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../widgets/appbar.dart';
import '../../widgets/bulletList.dart';
import '../../widgets/button.dart';

import 'admission_plmatresult_screen.dart';

class PLMATPage extends StatefulWidget {
  const PLMATPage({super.key});

  @override
  State<PLMATPage> createState() => _PLMATPageState();
}

class _PLMATPageState extends State<PLMATPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSliverAppBar(
        text: 'PLM Admission Test',
        image: 'assets/images/On1.jpg',
        isCenter: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PLMAT: First Step to studying at PLM',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Color.fromARGB(255, 0, 102, 153),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 30),
              Text(
                'Who Can take the PLMAT?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Color.fromARGB(255, 0, 102, 153),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 10),
              BulletList([
                'Dictum ut tincidunt quam quis eros turpis',
                'Eu volutpat tincidunt sed sapien ipsum',
                'Commodo nullam amet, vivamus.',
              ]),
              SizedBox(height: 30),
              Text(
                'How much is the PLMAT?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Color.fromARGB(255, 0, 102, 153),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 30),
              ButtonOutline(
                  buttonText: 'PLMAT Results',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ResultPage()));
                  }),
              ButtonFill(buttonText: 'Apply', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
