import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../consts.dart';

Widget ProjectsWidget(double height, BuildContext context) {
  var textcolor = Consts.OAC;
  double Width = MediaQuery.of(context).size.width;
  print(Width/10000);

  List<ProjectData> projects = [
    ProjectData(
      title: Strings.VFXfood,
      description: Strings.VFXFoodDescription,
      imageAsset: Strings.VFXfoodAsset,
      link: Strings.VFXFoodPSLink,
    ),
    ProjectData(
      title: Strings.Vanilai,
      description: Strings.VanilaiDescription,
      imageAsset: Strings.VanilaiAsset,
      link: Strings.VanilaiPSLink,
    ),
    ProjectData(
      title: Strings.Ballot,
      description: Strings.BallotDescription,
      imageAsset: Strings.BallotAsset,
      link: Strings.BallotPSLink,
    ),
    // Add more projects as needed
  ];

  return Container(
    color: Consts.accent_color,
    height: height,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              Strings.PROJECTS,
              style: GoogleFonts.getFont(
                Strings.StaatlichesFONT,
                color: Consts.common_color,
              ),
              textScaleFactor: 4,
              maxLines: 2,
              textAlign: TextAlign.left,
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Consts.OAC),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Consts.OAC),
            ),
          ),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: height,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: _calculateViewportFraction(Width),
              ),
              items: projects.map((project) {
                return Builder(
                  builder: (BuildContext context) {
                    return ProjectSlide(
                      title: project.title,
                      description: project.description,
                      imageAsset: project.imageAsset,
                      link: project.link,
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ),
  );
}

double _calculateViewportFraction(double screenWidth) {
  // Define your responsive logic here
  // You can adjust the coefficients (0.001 and -0.2) based on your preference
  double scaleFactor = 0.001 * screenWidth - 0.2;

  // Ensure the viewportFraction is within a reasonable range (e.g., 0.1 to 0.7)
  return scaleFactor.clamp(0.1, 0.7);
}
class ProjectSlide extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;
  final String link;

  ProjectSlide({
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: GoogleFonts.getFont(
              Strings.StaatlichesFONT,
              color: Consts.common_color,
            ),
            textScaleFactor: 2,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 5,
              child: Image.asset(imageAsset),
            ),
            Flexible(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: GoogleFonts.getFont(
                      Strings.OSFONT,
                      color: Consts.OAC,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      onPressed: () => _launchUrl(link),
                      child: Text(
                        Strings.PlayStore,
                        style: TextStyle(color: Consts.OAC),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Consts.common_color),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProjectData {
  final String title;
  final String description;
  final String imageAsset;
  final String link;

  ProjectData({
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.link,
  });
}

void _launchUrl(url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}