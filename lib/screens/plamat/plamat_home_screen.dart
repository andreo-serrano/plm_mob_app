import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'plamat_application_form_screen.dart';
import 'plamat_login_screen.dart';
import 'plamatui.dart';

import '../auth/login_screen.dart';


class PLAMATApp extends StatelessWidget {
  const PLAMATApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLMAT PAGE',
      initialRoute: '/',
      routes: {
        '/': (context) => PLAMATPage(context),
        '/application-form': (context) => const ApplicantForm(),
        '/application-login': (context) => PLAMATLogin(),
      },
    );
  }

  Widget PLAMATPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        titleSpacing: 0,
        leading: Image.asset(
          'assets/PLMLogo.png',
          width: 50,
        ),
        title: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PLAMATLogin()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(210, 180, 17,
                      17), // Set the button background color to red
                ),
                child: const Text(
                  'Applicant Login',
                  style: TextStyle(
                    color: Colors.white, // Set the button text color to white
                  ),
                ),
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Color.fromARGB(210, 180, 17, 17),
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ],
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                'Pamantasan ng Lungsod ng Maynila',
                style: TextStyle(
                  color: Color.fromARGB(255, 236, 183, 23),
                  fontSize: 25,
                ),
              ),
            ),
            buildDrawerItem(
                context,
                'Home',
                    () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PLAMATLogin()))),
            buildDrawerItem(
                context,
                'Application Form',
                    () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ApplicantForm()))),
            buildDrawerItem(
                context,
                'Applicant Login',
                    () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PLAMATLogin()))),
            buildDrawerItem(
                context,
                'Help Desk',
                    () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PLAMATUIPage()))),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16.0),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
            ),
            items: [
              GestureDetector(
                onTap: () {
                  _showImageDialog(context, 'assets/Advisory1.jpg');
                },
                child: Image.asset('assets/Advisory1.jpg'),
              ),
              GestureDetector(
                onTap: () {
                  _showImageDialog(context, 'assets/Advisory2.jpg');
                },
                child: Image.asset('assets/Advisory2.jpg'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Container(
            child: const Text(
              'Important Dates:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: DataTable(
              columnSpacing: 0.0,
              columns: [
                DataColumn(
                  label: Expanded(
                    child: Container(
                      color: const Color.fromARGB(210, 180, 17, 17),
                      padding: const EdgeInsets.all(20.0),
                      child: const Center(
                        child: Text(
                          'Start of Application',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      color: const Color.fromARGB(210, 180, 17, 17),
                      padding: const EdgeInsets.all(20.0),
                      child: const Center(
                        child: Text(
                          'End of Application',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              rows: const [
                DataRow(
                  cells: [
                    DataCell(
                      Center(child: Text('January 21, 2023')),
                    ),
                    DataCell(
                      Center(child: Text('April 30, 2023')),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }

  ListTile buildDrawerItem(
      BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        onTap();
      },
    );
  }
}

void _showImageDialog(BuildContext context, String imagePath) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      child: Image.asset(imagePath),
    ),
  );
}


class Footer extends StatelessWidget {
  const Footer({Key ? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(color: Color.fromARGB(255, 236, 183, 23), // Border color
              width: 2.0,
            ) // Border width
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/PLMLogo.png',
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pamantasan ng Lungsod ng Maynila',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 236, 183, 23),
                    ),
                  ),
                  Text(
                    'University of the City of Manila',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'About Us',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pamantasan ng Lungsod ng Maynila (PLM) is the first and only chartered and autonomous university funded by a city government which is situated inside the historic walled area of Intramuros, Manila, Philippines.',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'For more information, you may contact the Admissions Office',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Email: admission_office@plm.edu.ph',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Contact Numbers:',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Address: Gen. Luna corner Muralla Street, Intramuros Manila, Philippines 1002',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}



