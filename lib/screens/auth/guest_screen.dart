import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'login_screen.dart';
import '../home/home_guest.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../widgets/button.dart';

class AfterWelcomeGuest extends StatefulWidget {
  @override
  _AfterWelcomeGuestState createState() => _AfterWelcomeGuestState();
}

final carousel = [
  'https://plm.edu.ph/images/news/press-releases/Pamantasa--ng-Lungsod-ng-Maynila-facade.jpg',
  'https://www.cnn.ph/.imaging/mte/demo-cnn-new/750x450/dam/cnn/2020/4/22/PLM-Facade_CNNPH.jpg/jcr:content/PLM-Facade_CNNPH.jpg',
  'https://upload.wikimedia.org/wikipedia/en/thumb/6/6e/Ph-mm-manila-intramuros-pamantasan_ng_lungsod_ng_maynila_%28plm%29_%282014%29.JPG/2560px-Ph-mm-manila-intramuros-pamantasan_ng_lungsod_ng_maynila_%28plm%29_%282014%29.JPG',
];

class _AfterWelcomeGuestState extends State<AfterWelcomeGuest> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/plmseal.png"),
              ),
              Text(
                'Pamantasan ng Lungsod ng Maynila',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006699),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Container(
                        // width: screenWidth,
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        child: YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: 'k_7moyrOJgU', //Add videoID.
                            flags: YoutubePlayerFlags(
                              hideControls: false,
                              controlsVisibleAtStart: true,
                              autoPlay: false,
                              mute: false,
                            ),
                          ),
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.red,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Container(
                        child: Text("Pamantasan ng Lungsod ng Maynila",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFFFFC909),
                                fontFamily: "Lato",
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 45),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: Text(
                          'Pamantasan ng Lungsod ng Maynila (PLM) is the first and only chartered and autonomous university funded by a city government. '
                              'It was created by the Congress of the Philippines by virtue of Republic Act No. 4196 or An Act Authorizing the City of Manila to '
                              'Establish and Operate the University of City of Manila on June 19, 1965.',
                          style: TextStyle(fontFamily: "Lato", fontSize: 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 45),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: Text(
                          'The university first opened its gates on July 17, 1967 to 556 first-year students at '
                              'its campus in the historic Intramuros district, which served as the seat of power '
                              'during the Spanish occupation. '
                              '\nCurrently, about 10,000 graduate and post-graduate '
                              'students grace its halls to receive PLM’s quality education. PLM is the first local '
                              'government-funded tertiary institution that offered tuition-free education.'
                          ,
                          style: TextStyle(fontFamily: "Lato", fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ButtonOutline(
                buttonText: "PLM Website",
                onPressed: () {
                  launch('https://plm.edu.ph/');
                },
              ),
              ButtonFill(
                buttonText: "Home",
                bgColor: Colors.amber,
                onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => HomeGuestPage())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
