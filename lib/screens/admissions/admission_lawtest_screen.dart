import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../widgets/appbar.dart';
import '../../widgets/button.dart';

class LawTestPage extends StatefulWidget {
  const LawTestPage({super.key});

  @override
  State<LawTestPage> createState() => _LawTestPageState();
}

class _LawTestPageState extends State<LawTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomSliverAppBar(
      text: 'College of Law Admission Test',
      image: 'assets/images/law.jpg',
      isCenter: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            ButtonFill(buttonText: 'Apply', onPressed: () {}),
          ],
        ),
      ),
    ));
  }
}
