import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../widgets/appbar.dart';
import '../../widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

class AcademicCalendar extends StatefulWidget {
  @override
  State<AcademicCalendar> createState() => _AcademicCalendarState();
}
List<String> imagePaths = [
  'assets/images/univCal1.jpg',
  'assets/images/univCal2.jpg',
];


class _AcademicCalendarState extends State<AcademicCalendar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 320;
    double screenHeight = MediaQuery.of(context).size.height / 668;

    return Scaffold(
      body: CustomSliverAppBar(
        text: 'Academic Calendar',
        image: 'assets/images/calendar.jpg',
        isCenter: false,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(height: 55 * screenHeight),
            Text(
              'Download Academic\nCalendar PDF',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5 * screenHeight),
            Text(
              'View or download our Academic Calendar for AY 2020 to 2021. ',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 11 * screenHeight),
            SizedBox(
              width: 115 * screenWidth,
              child: ButtonFill(
                buttonText: "Download",
                bgColor: Colors.amber,
                color: Colors.white,
                onPressed: () {
                  const url = 'https://plm.edu.ph/images/downloads/University_Calendar_SY_2022-2023_page-0001.pdf';
                  launch(url.toString());
                },
              ),
            ),
              SizedBox(height: 11 * screenHeight),
              Text(
              'AcademicCalendar\n2020-2021.pdf',
              style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 54 * screenHeight),
              Text(
                'To Zoom In, click the magnifying glass icon',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 11 * screenHeight), // Add a SizedBox for spacing
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      imagePaths[currentPageIndex],
                      width: 277 * screenWidth, // Adjust the width as needed
                      height: 172 * screenHeight, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageViewer()));
                    },
                    child: Container(
                      width: 277 * screenWidth,
                      height: 172 * screenHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent, // Adjust the opacity value as desired
                            Colors.black.withOpacity(0.6), // Adjust the opacity value as desired
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF787878)),
                    onPressed: () {
                      setState(() {
                        if (currentPageIndex > 0) {
                          currentPageIndex--;
                        }
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  Row(
                    children: List.generate(imagePaths.length, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == currentPageIndex ? Color(0xFF787878) : Color(0xFFE9E9E9),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF787878)),
                    onPressed: () {
                      setState(() {
                        if (currentPageIndex < imagePaths.length - 1) {
                          currentPageIndex++;
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  static const yellow = Color(0xFFFFC909);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Stack(
        children: <Widget>[
          PhotoViewGallery.builder(
            itemCount: imagePaths.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(imagePaths[index]),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
          ),
          Positioned(
              top: 30,
              left: 30,
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                constraints: BoxConstraints.tight(Size(50, 50)),
                fillColor: Colors.white,
                shape: CircleBorder(),
                child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      size: 20.0,
                    )),
              )),
        ],
      ));
}