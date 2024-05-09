import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';
import '../../widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

class AlumniScreen extends StatefulWidget {
  @override
  State<AlumniScreen> createState() => _AlumniScreenState();
}

class _AlumniScreenState extends State<AlumniScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 320;
    double screenHeight = MediaQuery.of(context).size.height / 668;
    return Scaffold(
      body: CustomSliverAppBar(
          text: 'Alumni',
          image: 'assets/images/alum.jpg',
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15 * screenHeight),
                Text(
                  'PLM produces a diverse corps of professionals who contribute to the economic efforts of the city -- all the way to the international fronts.'
                      '\n\nIn the school community, the alumni are a major stakeholder -- highlighted by their sense of gratitude to return the favor of transformative education.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 63 * screenHeight),
                Text(
                  'Alumni Registration System (ARS)',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'PLM produces a diverse corps of professionals who contribute to the economic efforts of the city -- all the way to the international fronts.'
                      '\n\nIn the school community, the alumni are a major stakeholder -- highlighted by their sense of gratitude to return the favor of transformative education.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 10 * screenHeight),
                SizedBox(
                  width: 141 * screenWidth,
                  child: ButtonFill(
                    buttonText: "Fill out online ARS",
                    bgColor: Colors.amber,
                    onPressed: () {
                      const url = 'https://web2.plm.edu.ph/ars/';
                      launch(url.toString());
                    },
                  ),
                ),
                SizedBox(height: 20 * screenHeight),
                Text(
                  'Career Placement for Alumni',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'Looking for the right place in the industry? Check out the job calls from our industry partners:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 10 * screenHeight),
                SizedBox(
                  width: 141 * screenWidth,
                  child: ButtonFill(
                    buttonText: "Job Posts",
                    bgColor: Colors.amber,
                    onPressed: () {
                      const url = 'https://plm.edu.ph/careers-alumni';
                      launch(url.toString());
                    },
                  ),
                ),
              ],
            ),
          ),
          isCenter: false,
      ),
    );
  }
}