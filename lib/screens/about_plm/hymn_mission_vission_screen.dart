import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HymnMissionVisionPage extends StatefulWidget {
  const HymnMissionVisionPage ({Key? key}) : super(key: key);

  @override
  State<HymnMissionVisionPage> createState() => _HymnMissionVisionPageState();
}

class _HymnMissionVisionPageState extends State<HymnMissionVisionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [
          SliverAppBar(
            pinned: true,
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Hymn, Vision & Mission', style: TextStyle(fontSize: 21.0)),
              centerTitle: true,
              background:
              Opacity(
                  opacity:0.3,
                  child: Image.asset('assets/images/plmimage.png',
                    fit: BoxFit.cover,
                  )
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                  children: [
                    Container(
                      //University Hymn
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Text(
                        "University Hymn",
                        style: Theme.of(context).textTheme.titleMedium,)
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Text(
                        "Music helps unite the PLM community. Every Monday and official school activity, students, faculty, and staff alike sing in unison the “Pamantasang Mahal”, PLM’s official hymn. \n\nLyrics: Gatpuno Antonio J. Villegas, Mayor of Manila (1968) Lyrics presented to the Board of Regents in Maharnilad (official name of the famous Manila City Hall).\n\nMusic: Prof. Felipe Padilla de Leon",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      //title of song
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Text(
                        "Pamantasang Mahal",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      //Official hymn of Pamantasan ng Lungsod ng Maynila
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Text(
                        "Official hymn of the Pamantasan ng Lungsod ng Maynila",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      //Song lyrics
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: Text(
                        "Pamantasan, Pamantasang Mahal\n Nagpupugay kami't nag-aalay\n Ng Pag-ibig, taos na paggalang\n Sa patnubay ng aming isipan.\n\n Karunungang tungo'y kaunlaran\nHinuhubog kaming kabataan\nMaging Pilipinong mero'ng dangal\n Puso'y tigib ng kadakilaan.\n\n Pamantasang Lungsod ng Maynila\n Kaming lahat dito'y iyong punla\n Tutuparin pangarap mo't nasa\n Pamantasan kami'y nanunumpa.\n Pamantasan kami'y nanunumpa.\n",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      //Play in youtube
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Text(
                        "Play in YouTube",
                        style: Theme.of(context).textTheme.titleMedium,)
                    ),
                    Container(
                      // width: screenWidth,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: '_jYalyXcKQM', //Add videoID.
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
                    SizedBox(height: 20.0),
                    Container(
                      //Vision & Mission
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Text(
                        "Vision & Mission",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      //Vision and Mission body
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Text(
                        "The Pamantasan ng Lungsod ng Maynila (PLM), created by a National Charter (RA 4196, 1965), was envisioned to be Manila's premiere institution for higher learning. It provides superior standards of instructions, as well as opportunities for outstanding research in technology and other areas for the development of the intellect and to advance human knowledge.\n\nThe Pamantasan ng Lungsod ng Maynila has adopted the policy of preferential option for the poor and therefore has prioritized education for the underprivileged but talented students of Manila. Committed to the highest intellectual and ethical standards, PLM strives to produce competent graduates with integrity who will be responsible citizens who can contribute effectively to local, national and global initiatives for the progressive and sustainable development of humanity.\n\nGuided by the values of academic excellence, integrity and social responsibility, PLM endeavors to be one of the leading universities in the ASEAN.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Container(
                      //Vision
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: Text(
                        "Vision",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      //Vision Body
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Text(
                        "The Pamantasan ng Lungsod ng Maynila shall be the premier people’s university pursuing public interest and national development.",
                        style: Theme.of(context).textTheme.bodyMedium
                      ),
                    ),
                    Container(
                      //Mission
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: Text(
                        "Mission",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      //Mission Body
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Text(
                        "The Pamantasan ng Lungsod ng Maynila shall be the premier people’s university pursuing public interest and national development.",
                        style: Theme.of(context).textTheme.bodyMedium
                      ),
                    ),
                    Container(
                      //Core values
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: Text(
                        "Core Values",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      //Core values Body
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Text(
                        "The Pamantasan ng Lungsod ng Maynila shall be guided by the values of academic excellence, integrity and social responsibility, and by the principles of Karunungan, Kaunlaran and Kadakilaan.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
              ),
            ),
          )
        ]
      ),
    );
  }
}
