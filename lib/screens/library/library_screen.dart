import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> imgList = [
  // Insert img links here
  'assets/images/lib2.jpg',
  'assets/images/med2.jpg',
  'assets/images/law1.jpg',
];

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Row(
            children: [
              Column(
                children: [
                  Image.asset('assets/images/plmseal.png',
                      width: 40, height: 40),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PAMANTASAN NG LUNGSOD NG MAYNILA',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 10,
                          color: Color(0xffd5a103),
                          fontFamily: 'Merriweather'),
                    ),
                    Text(
                      'ONLINE LIBRARY (ONLINE PUBLIC ACCESS CATALOG)',
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Montserrat',
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          addAutomaticKeepAlives: false,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  color: Color(0xffd5a103),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      child: CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                            // enlargeCenterPage: true,
                            //aspectRatio: 2.0,
                            viewportFraction: 1,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                setState(() {
                                  _current = index;
                                });
                              });
                            }),
                        items: imgList
                            .map((item) => Container(
                                  child: Center(
                                    child: Image.asset(
                                      item,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Align(
                      heightFactor: 2,
                      child: ElevatedButton(
                        child: Text(
                            'WELCOME TO CELSO AL CARUNUNGAN MEMORIAL LIBRARY (CACML)',
                            style: TextStyle(
                                fontFamily: 'Montserrat', fontSize: 8),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          print('welcome button pressed!');
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                Container(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
                    child: Text(
                      'Explore our unit libraries and section:',
                      style: TextStyle(
                          fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: Text('COLLEGE OF LAW\nLIBRARY',
                            style: TextStyle(
                                fontFamily: 'Montserrat', fontSize: 10),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          launchUrl(Uri.parse('http://plmcollegeoflaw.com/'));
                          print('pressed!');
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: Text('COLLEGE OF MEDICINE\nLIBRARY',
                            style: TextStyle(
                                fontFamily: 'Montserrat', fontSize: 10),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          launchUrl(Uri.parse('http://plmcollegeoflaw.com/'));
                          print('medicine button pressed!');
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text('LILIOSA HILAO\nGENDER AND DEVELOPMENT CORNER',
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 10),
                        textAlign: TextAlign.center),
                    onPressed: () {
                      launchUrl(Uri.parse('http://plmcollegeoflaw.com/'));
                      print('corner button pressed!');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      'Library Tutorials',
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),

                Container(
                  child: Image.asset('assets/images/reading.jpg',
                      width: 300, height: 300, fit: BoxFit.fitHeight),
                ),

                // Insert Image HERE
                Container(
                  padding: EdgeInsets.fromLTRB(60, 20, 60, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Need help on how to use our facilities and browse materials? Watch our step-by-step guide and learn how to use the library like a pro.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontFamily: 'Open Sans', fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 48),
                  child: GradientButton(
                    // width: double.infinity,
                    onPressed: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Text('EXPLORE',
                        style: TextStyle(fontFamily: 'Montserrat'),
                        textAlign: TextAlign.center),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //       ),
                //     ),
                //     child: Text(
                //       'EXPLORE',
                //       textAlign: TextAlign.center,
                //       style: TextStyle(fontFamily: 'Montserrat'),
                //     ),
                //     onPressed: () {
                //       print('corner button pressed!');
                //     },
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Book an appointment',
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Container(
                  child: Image.asset('assets/images/appointment.jpg',
                      width: 300, height: 300, fit: BoxFit.fitHeight),
                ),
                // Insert Image HERE
                Container(
                  padding: EdgeInsets.fromLTRB(60, 20, 60, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Students, faculty, and personnel are welcome to use our facilities on a per-schedule basis. Users can book an appointment at least one weel prior to their visit.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontFamily: 'Open Sans', fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 48),
                  child: GradientButton(
                    // width: double.infinity,
                    onPressed: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Text('SCHEDULE NOW',
                        style: TextStyle(fontFamily: 'Montserrat'),
                        textAlign: TextAlign.center),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                //   child: Container(
                //     child: ElevatedButton(
                //       style: ButtonStyle(
                //         shape:
                //             MaterialStateProperty.all<RoundedRectangleBorder>(
                //           RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //         ),
                //       ),
                //       child: Text(
                //         'SCHEDULE NOW',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(fontFamily: 'Montserrat'),
                //       ),
                //       onPressed: () {
                //         print('corner button pressed!');
                //       },
                //     ),
                //   ),
                // ),
                Text(
                  'Book request form',
                  style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Container(
                  child: Image.asset('assets/images/bookRequest.jpg',
                      width: 300, height: 300, fit: BoxFit.fitHeight),
                ),
                // Insert Image HERE
                Container(
                  padding: EdgeInsets.fromLTRB(60, 20, 60, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Need a book or reference material? Users can request what they need and our librarians will make them available for them.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontFamily: 'Open Sans', fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 48),
                  child: GradientButton(
                    // width: double.infinity,
                    onPressed: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Text('REQUEST NOW',
                        style: TextStyle(fontFamily: 'Montserrat'),
                        textAlign: TextAlign.center),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //       ),
                //     ),
                //     child: Text(
                //       'REQUEST NOW',
                //       textAlign: TextAlign.center,
                //       style: TextStyle(fontFamily: 'Montserrat'),
                //     ),
                //     onPressed: () {
                //       print('corner button pressed!');
                //     },
                //   ),
                // ),
                Container(
                  child: Image.asset('assets/images/onlineLibrary.jpg',
                      width: 300, height: 300, fit: BoxFit.fitHeight),
                ),
                // Insert IMG HERE
                Text(
                  'Online Library Subscriptions and Resources',
                  style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(60, 20, 60, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Browse online academic journals and other periodic subscriptions for data sources from experts and up-to-date reference for your research.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontFamily: 'Open Sans', fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 100),
                  child: GradientButton(
                    // width: double.infinity,
                    onPressed: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Text('BROWSE',
                        style: TextStyle(fontFamily: 'Montserrat'),
                        textAlign: TextAlign.center),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //       ),
                //     ),
                //     child: Text(
                //       'BROWSE',
                //       textAlign: TextAlign.center,
                //       style: TextStyle(fontFamily: 'Montserrat'),
                //     ),
                //     onPressed: () {
                //       print('corner button pressed!');
                //     },
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      // Column 1
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Online Subscriptions',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          child: Text(
                            'AccessEngineering',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () =>
                              launchUrl(Uri.parse('https://www.youtube.com/')),
                        ),
                        InkWell(
                          child: Text(
                            'AccessPhysiotherapy',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () =>
                              launchUrl(Uri.parse('https://www.youtube.com/')),
                        ),
                        Text(
                          'Emerald Insight',
                          style: TextStyle(color: Colors.blue, fontSize: 10),
                        ),
                        Text(
                          'MyLegalWhiz',
                          style: TextStyle(color: Colors.blue, fontSize: 10),
                        ),
                        Text(
                          'Ovid Clinical Edge',
                          style: TextStyle(color: Colors.blue, fontSize: 10),
                        ),
                        Text(
                          'Philippine ejournals',
                          style: TextStyle(color: Colors.blue, fontSize: 10),
                        ),
                        Text(
                          'Wiley Architectural Graphic',
                          style: TextStyle(color: Colors.blue, fontSize: 10),
                        ),
                        Text(
                          'Standards Reference',
                          style: TextStyle(color: Colors.blue, fontSize: 10),
                        ),
                        Text(
                          'Wiley Online Library',
                          style: TextStyle(color: Colors.blue, fontSize: 10),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,

                      //Column 2
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Free/Open access',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          child: Text(
                            'ASEAN Digital Library',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(
                              Uri.parse('https://www.aseanlibrary.org/')),
                        ),
                        InkWell(
                          child: Text(
                            'Bangko Sentral ng Pilipinas (KRN Update\nNewsletters)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(Uri.parse(
                              'https://plmedu-my.sharepoint.com/:b:/g/personal/gmmauricio_plm_edu_ph/EakipolmfupLoKV4QxfC7g0Bkd_MIDCqCom2qRIJa6idfw?e=7Ctuo8')),
                        ),
                        InkWell(
                          child: Text(
                            'Bangko Sentral ng Pilipinas (Media and\nReseach)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(Uri.parse(
                              'https://www.bsp.gov.ph/SitePages/MediaAndResearch/MediaList.aspx?TabId=1')),
                        ),
                        InkWell(
                          child: Text(
                            'Chan Robles Virtual Law Library',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(
                              Uri.parse('https://lawlibrary.chanrobles.com/')),
                        ),
                        InkWell(
                          child: Text(
                            'De Gruyter',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(
                              Uri.parse('https://www.degruyter.com/')),
                        ),
                        InkWell(
                          child: Text(
                            'Directory of Open Access Books (DOAB)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () =>
                              launchUrl(Uri.parse('https://www.doabooks.org/')),
                        ),
                        InkWell(
                          child: Text(
                            'Directory of Open Access Journals (DOAJ)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () =>
                              launchUrl(Uri.parse('https://doaj.org/')),
                        ),
                        InkWell(
                          child: Text(
                            'EBSCO Free Databases',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(Uri.parse(
                              'https://www.ebsco.com/products/research-databases/free-databases')),
                        ),
                        InkWell(
                          child: Text(
                            'KWF Diksiyonaryo ng Wikang Filipino',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(
                              Uri.parse('https://kwfdiksiyonaryo.ph/')),
                        ),
                        InkWell(
                          child: Text(
                            'LawPhil Project',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () =>
                              launchUrl(Uri.parse('https://www.lawphil.net/')),
                        ),
                        InkWell(
                          child: Text(
                            'OER Commons',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(
                              Uri.parse('https://www.oercommons.org/')),
                        ),
                        InkWell(
                          child: Text(
                            'Open Access Theses and Dissertations\n(OATD)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () =>
                              launchUrl(Uri.parse('https://oatd.org/')),
                        ),
                        InkWell(
                          child: Text(
                            'Open Textbook Library',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(
                              Uri.parse('https://open.umn.edu/opentextbooks')),
                        ),
                        InkWell(
                          child: Text(
                            'Openstax',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () =>
                              launchUrl(Uri.parse('https://openstax.org/')),
                        ),
                        InkWell(
                          child: Text(
                            'Oxford Academic (ejournal)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(Uri.parse(
                              'https://academic.oup.com/journals/pages/open_access?login=false')),
                        ),
                        InkWell(
                          child: Text(
                            'PHL CHED Connect',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(
                              Uri.parse('https://phlconnect.ched.gov.ph/')),
                        ),
                        InkWell(
                          child: Text(
                            'Project Gluttenberg',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(
                              Uri.parse('https://www.gutenberg.org/')),
                        ),
                        InkWell(
                          child: Text(
                            'STARBOOKS Online',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () =>
                              launchUrl(Uri.parse('https://www.starbooks.ph/')),
                        ),
                        InkWell(
                          child: Text(
                            'Supreme Court E-Library',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(
                              Uri.parse('https://elibrary.judiciary.gov.ph/')),
                        ),
                        InkWell(
                          child: Text(
                            'Tekno-Aklatan',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(Uri.parse(
                              'http://nlpdl.nlp.gov.ph/TechnoAklatan')),
                        ),
                        InkWell(
                          child: Text(
                            'Wiley (Journal)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          onTap: () => launchUrl(Uri.parse(
                              'https://authorservices.wiley.com/open-research/open-access/index.html')),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Container(
                padding: EdgeInsets.all(3),
                color: Color(0xffd5a103),
              ),
            ),
            // Footer
            Container(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              color: Color(0xfff2f2f2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column 1
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'University Library',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                      Text('Gusaling Katipunan',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xff4d4d4d), fontSize: 10)),
                      Text('Pamantasan ng Lungsod ng Maynila',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xff4d4d4d), fontSize: 10)),
                      Text('Intramuros, Manila, Philippines',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xff4d4d4d), fontSize: 10)),
                    ],
                  ),
                  // Column 2
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('About the library',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xff0771bc), fontSize: 10)),
                      Text('Contact us',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xff0771bc), fontSize: 10)),
                      Row(
                        children: [
                          Icon(Icons.mail, size: 10, color: Colors.blue),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text('library@plm.edu.ph',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff4d4d4d), fontSize: 10)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 10, color: Colors.blue),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text('plm.edu.ph',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff4d4d4d), fontSize: 10)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.facebook, size: 10, color: Colors.blue),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: InkWell(
                              child: Text('PLM_Haribon',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d), fontSize: 10)),
                              onTap: () => launchUrl(Uri.parse(
                                  'https://www.facebook.com/PLM.Haribon?locale=tl_PH')),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.message, size: 10, color: Colors.blue),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text('PLM_Manila',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff4d4d4d), fontSize: 10)),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient = const LinearGradient(
        colors: [Color.fromARGB(255, 0, 194, 113), Colors.blue]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
