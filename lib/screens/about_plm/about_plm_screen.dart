import 'package:flutter/material.dart';
// import 'package:maps_launcher/maps_launcher.dart';
import 'college_contact_info_screen.dart';
import 'hymn_mission_vission_screen.dart';
import '../academic_calendar/academic_calendar_screen.dart';
import '../alumni/alumni_screen.dart';
import '../home/home_screen.dart';
import '../map/map_screen.dart';
import '../../widgets/button.dart';
import '../../widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPLM extends StatefulWidget {
  @override
  State<AboutPLM> createState() => _AboutPLMState();
}

class _AboutPLMState extends State<AboutPLM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomSliverAppBar(
          text: 'About PLM',
          image: 'assets/images/On1.jpg',
          isCenter: false,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                SizedBox(height: 15),
                Text(
                  'Pamantasan ng Lungsod ng Maynila (PLM) is the first and only chartered and autonomous university funded by a city government. It was created by the Congress of the Philippines by virtue of Republic Act No. 4196 or “An Act Authorizing the City of Manila to Establish and Operate the University of City of Manila” on June 19, 1965.'
                      '\n\nThe university first opened its gates on July 17, 1967 to 556 first-year students at its campus in the historic Intramuros district, which served as the seat of power during the Spanish occupation. Currently, about 10,000 graduate and post-graduate students grace its halls to receive PLM’s quality education.'
                      '\n\nPLM is the first local government-funded tertiary institution that offered tuition-free education. PLM also carries the distinction of being the first tertiary institution to have a Filipino official name, which is why people use “Pamantasan” to refer to PLM. The word pamantasan was derived from the Filipino term “pantas” or wise person.'
                      '\n\nThe university stands on historic grounds. On its site once stood the Universidad de San Ignacio (1590-1798), Universidad Maximo de San Ignacio, Colegio de San Jose, and Ateneo de Municipal de Manila (1865-1901).'
                      '\n\nPLM is a premiere university that has consistently garnered a 100% passing rate in licensure exams. Since 1967, it has produced competent and socially responsible graduates who have contributed to nation-building.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 20),
                Text(
                  'More Information',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ButtonText(
                  text: Text('PLM Contact Information'),
                  icon: Icons.arrow_forward_ios,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                ),
                ButtonText(
                    text: Text(
                        'Colleges & Administratives\nContact Information'),
                    icon: Icons.arrow_forward_ios,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactInformation()));
                    }),
                ButtonText(
                    text: Text('Hymn, Vision & Mission'),
                    icon: Icons.arrow_forward_ios,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HymnMissionVisionPage()));
                    }),
                ButtonText(
                    text: Text('Alumni'),
                    icon: Icons.arrow_forward_ios,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlumniScreen()));
                    }),
                ButtonText(
                    text: Text('Academic Calendar'),
                    icon: Icons.arrow_forward_ios,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AcademicCalendar()));
                    }),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ButtonText(
                          text: Text('Map'),
                          icon: Icons.arrow_forward_ios,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Maps()));
                          }),
                    ),
                    Expanded(
                      flex: 3,
                      child: ButtonText(
                          text: Text('View In Google\nMaps'),
                          icon: Icons.arrow_forward_ios,
                          onPressed: () {
                            const url = 'https://goo.gl/maps/7MWbvRKXEVkZBYih8';
                            launch(url.toString());
                          }
                        // MapsLauncher.launchQuery('General Luna, corner Muralla St, Intramuros, Manila, 1002 Metro Manila')},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.4,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://plm.edu.ph/images/banners/inner-page-banner_aboutplm.jpg'),
                      ),
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(1.0),
                          ],
                          stops: [
                            0.0,
                            1.0
                          ]),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: Center(
                    child: TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Visit PLM Website',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                  ]),
                            ],
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    title: Center(
        child: const Text(
          'PLM Contact Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Text(
              "Address: General Luna corner Muralla Streets, Intramuros, Manila, Philippines 1002"
                  "\n\nTrunkline: (+63 2) 8 643 2500\n\nEmail for online payments: payonline@plm.edu.ph"),
        ),
      ],
    ),
    actions: <Widget>[
      Center(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: new ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200.0, 50.0), backgroundColor: Color(0xFFE9E9E9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            )),
      ),
    ],
  );
}