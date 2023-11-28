import 'package:animated_background/animated_background.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:mailto/mailto.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../commons/consts.dart';
import '../../commons/constants.dart';
import '../../commons/widgets/change_color.dart';
import '../../commons/widgets/projects.dart';
import '../../provider/change_color_provider.dart';

// class MyDesktopBody extends StatelessWidget {
//   const MyDesktopBody({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple[200],
//       appBar: AppBar(
//         title: Text('D E S K T O P'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             // First column
//             Expanded(
//               child: Column(
//                 children: [
//                   // youtube video
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: AspectRatio(
//                       aspectRatio: 16 / 9,
//                       child: Container(
//                         color: Colors.deepPurple[400],
//                       ),
//                     ),
//                   ),
//
//                   // comment section & recommended videos
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: 8,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             color: Colors.deepPurple[300],
//                             height: 120,
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//             // second column
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: 200,
//                 color: Colors.deepPurple[300],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class MyMobileBody extends StatefulWidget {
  @override
  State<MyMobileBody> createState() => _MyMobileBodyState();
}

class _MyMobileBodyState extends State<MyMobileBody>
    with TickerProviderStateMixin {
  final ScrollController _controller = ScrollController();

  final about = GlobalKey();

  final skills = GlobalKey();

  final projects = GlobalKey();

  final worksamples = GlobalKey();

  final contact = GlobalKey();

  late Image image1;

  @override
  void initState() {
    super.initState();
    image1 = Image.asset(Strings.cartoonPNG);
  }

  void didChangeDependencies() {
    precacheImage(image1.image, context);
    super.didChangeDependencies();
  }

  void _animateToIndex(int index, double height) {
    _controller.animateTo(
      height,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future ScrolltoItam(index) async {
    final context = index.currentContext!;
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Consumer<ColorChangeNotifier>(
        builder: (context, colorChangeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: colorChangeNotifier.commonColor,
            title: Text(
              Strings.ARUN,
              style: GoogleFonts.getFont(Strings.MMDFONT, color: Consts.OAC),
              textScaleFactor: 3,
            ),
          ),
          endDrawer: Drawer(
            backgroundColor: colorChangeNotifier.commonColor,
            child: Column(
              // Important: Remove any padding from the ListView.

              children: <Widget>[
                Expanded(child: image1),
                Center(
                    child: Text(
                  Strings.ARUN,
                  style: GoogleFonts.getFont(
                    Strings.MMDFONT,
                    color: Consts.OAC,
                  ),
                  textScaleFactor: 3,
                )),
                AppBarTitles(Strings.ABOUT, about, 0, context),
                AppBarTitles(Strings.SKILLS, skills, 800, context),
                AppBarTitles(Strings.PROJECTS, projects, 800 + 500, context),
                AppBarTitles(
                    Strings.WORKSAMPLES, worksamples, 800 + 500 + 800, context),
                AppBarTitles(Strings.CONTACT, contact, 800, context),
                ChangeColor(height: height),

              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: AnimatedBackground(
              behaviour: RandomParticleBehaviour(
                options: ParticleOptions(
                  baseColor: colorChangeNotifier.commonColor ?? const Color(0xffff6780),
                  spawnOpacity: 0.0,
                  opacityChangeRate: 0.25,
                  minOpacity: 0.1,
                  maxOpacity: 0.4,
                  spawnMinSpeed: 30.0,
                  spawnMaxSpeed: 70.0,
                  spawnMinRadius: 7.0,
                  spawnMaxRadius: 15.0,
                  particleCount: 40,
                ),
              ),
              vsync: this,
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                                key: about, child: EachPages(0, 800.0, context)),
                            Container(
                                key: skills, child: EachPages(1, 500.0, context)),
                            Container(
                                key: projects,
                                child: EachPages(2, 2100.0, context)),
                            Container(
                                key: worksamples,
                                child: EachPages(3, 800, context)),
                            Container(
                                key: contact, child: EachPages(4, 800, context)),
                            Container(
                                color: Colors.black,
                                child: Center(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: Strings.DevelopedInLoveWith,
                                            style: TextStyle(color: Colors.white)),
                                        TextSpan(
                                          text: Strings.Flutter,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  )
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   controller: _controller,
                  //   itemCount: 7,
                  //   itemBuilder: (_, i) {
                  //     return Flexible(
                  //       child: AspectRatio(
                  //         aspectRatio: 16/9,
                  //         child:EachPages(i,height*0.7)
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget EachPages(index, height, context) {
    switch (index) {
      case 0:
        return About(height, context);
        break;
      case 1:
        return Skills(height, context);
        break;
      case 2:
        return Projects(height, context);
        break;
      case 3:
        return WorkSamples(height, context);
        break;
      case 4:
        return Contact(height, context);
        break;
    }
    return Container(
      color: Consts.OAC,
      child: Text(""),
    );
  }

  Widget About(height, context) {
    var textcolor = Consts.OAC;
    return Consumer<ColorChangeNotifier>(
        builder: (context, colorChangeNotifier, child) {
        return Container(
          color: colorChangeNotifier.commonColor?.withOpacity(0.5),
          // height: MediaQuery.of(context).size.height*0.8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                    child: FittedBox(
                        child: Text(
                  Strings.ARUN,
                  textScaleFactor: 20,
                  style: GoogleFonts.getFont(Strings.FSFONT, color: textcolor),
                ))),
                Center(
                    child: FittedBox(
                        child: Text(
                  Strings.AspiringDeveloper,
                  textScaleFactor: 6,
                  style: GoogleFonts.getFont(Strings.WSFONT, color: textcolor),
                ))),
                Center(
                  child: SizedBox(
                    child: Text(
                      Strings.Description,
                      overflow: TextOverflow.clip,
                      maxLines: 10,
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(Strings.BSTFONT, color: textcolor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Center(
                      child: Icon(
                    Icons.arrow_downward_outlined,
                    color: Consts.OAC,
                  )),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget Skills(height, context) {
    var ih = height / 6;
    if (MediaQuery.of(context).size.width < 350) {
      ih = height / 15;
      print(height);
    } else if (MediaQuery.of(context).size.width < 375) {
      ih = height / 11;
    } else if (MediaQuery.of(context).size.width < 420) {
      ih = height / 10;
    } else if (MediaQuery.of(context).size.width < 612) {
      ih = height / 9;
    } else {
      ih = height / 9;
    }
    var textcolor = Consts.OAC;
    return Consumer<ColorChangeNotifier>(
        builder: (context, colorChangeNotifier, child) {
        return Container(
            color: Consts.OAC,
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            Strings.SKILLS,
                            style: GoogleFonts.getFont(Strings.StaatlichesFONT,
                                color: Consts.OAC),
                            textScaleFactor: 4,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty
                                .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: colorChangeNotifier.commonColor!))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                colorChangeNotifier.commonColor!),
                          )),
                      Expanded(
                        child: Center(
                            child: Text(Strings.Programminglanguages,
                                style: GoogleFonts.getFont(Strings.StaatlichesFONT,
                                    color: colorChangeNotifier.commonColor),
                                textScaleFactor: 2)),
                      ),
                      Expanded(
                          child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          hoverCrossFadeWidget(ih, Strings.DartAsset, Strings.Dart),
                          hoverCrossFadeWidget(
                              ih, Strings.PythonAsset, Strings.Python),
                          hoverCrossFadeWidget(ih, Strings.JavaAsset, Strings.Java),
                          hoverCrossFadeWidget(ih, Strings.CAsset, Strings.C),
                          hoverCrossFadeWidget(ih, Strings.CppAsset, Strings.Cpp),
                          hoverCrossFadeWidget(ih, Strings.JSAsset, Strings.JS),
                          hoverCrossFadeWidget(ih, Strings.PerlAsset, Strings.Perl),
                        ],
                        spacing: 4,
                        runSpacing: 4,
                      )),
                      Expanded(
                        child: Center(
                            child: Text(Strings.Frameworks,
                                style: GoogleFonts.getFont(Strings.StaatlichesFONT,
                                    color: colorChangeNotifier.commonColor),
                                textScaleFactor: 2)),
                      ),
                      Expanded(
                          child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          hoverCrossFadeWidget(
                              ih, Strings.FlutterAsset, Strings.Flutter),
                          hoverCrossFadeWidget(
                              ih, Strings.ReactAsset, Strings.React),
                          hoverCrossFadeWidget(
                              ih, Strings.NodeJSAsset, Strings.NodeJS),
                          hoverCrossFadeWidget(
                              ih, Strings.ExpressJSAsset, Strings.ExpressJS),
                        ],
                        spacing: 2,
                        runSpacing: 2,
                      )),
                      Expanded(
                        child: Center(
                            child: Text(Strings.Databases,
                                style: GoogleFonts.getFont(Strings.StaatlichesFONT,
                                    color: colorChangeNotifier.commonColor),
                                textScaleFactor: 2)),
                      ),
                      Expanded(
                          child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          hoverCrossFadeWidget(
                              ih, Strings.FirebaseAsset, Strings.Firebase),
                          hoverCrossFadeWidget(ih, Strings.SQLAsset, Strings.SQL),
                          hoverCrossFadeWidget(
                              ih, Strings.MongoDBAsset, Strings.MongoDB),
                        ],
                        spacing: 2,
                        runSpacing: 2,
                      )),
                    ],
                  ),
                ),
              ],
            ));
      }
    );
  }

  Widget Projects(height, context) {
    return ProjectsWidget(height, context);
  }

  Widget WorkSamples(height, context) {
    return Consumer<ColorChangeNotifier>(
        builder: (context, colorChangeNotifier, child) {
        return Container(
          color: colorChangeNotifier.commonColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      Strings.WORKSAMPLES,
                      style: GoogleFonts.getFont(Strings.StaatlichesFONT,
                          color: colorChangeNotifier.commonColor),
                      textScaleFactor: 4,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Consts.OAC))),
                      backgroundColor: MaterialStateProperty.all<Color>(Consts.OAC),
                    )),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          Strings.GithubProfile,
                          style: GoogleFonts.getFont(Strings.StaatlichesFONT,
                              color: Consts.OAC),
                          textScaleFactor: 2,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ElevatedButton(
                              onPressed: () {
                                _launchUrl(Strings.GithubProfileLine);
                              },
                              child: Text(
                                Strings.Github,
                                style: TextStyle(color: colorChangeNotifier.commonColor),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Consts.OAC),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          Strings.GoogleDevleoperAccount,
                          style: GoogleFonts.getFont(Strings.StaatlichesFONT,
                              color: Consts.OAC),
                          textScaleFactor: 2,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ElevatedButton(
                              onPressed: () {
                                _launchUrl(Strings.GoogleDevleoperAccoutLink);
                              },
                              child: Text(
                                Strings.DeveloperAccount,
                                style: TextStyle(color: colorChangeNotifier.commonColor),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Consts.OAC),
                              )),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget Contact(height, context) {
    return Consumer<ColorChangeNotifier>(
        builder: (context, colorChangeNotifier, child) {
        return Container(
            color: Consts.OAC,

            //height: height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        Strings.Getintouch,
                        style: GoogleFonts.getFont(Strings.StaatlichesFONT,
                            color: Consts.OAC),
                        textScaleFactor: 4,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: colorChangeNotifier.commonColor!))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(colorChangeNotifier.commonColor!),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: colorChangeNotifier.commonColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.house,
                                    size: 50,
                                    color: Consts.OAC,
                                  ),
                                  Text(
                                    Strings.Location,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Consts.OAC),
                                    textScaleFactor: 2,
                                  ),
                                  Text(
                                    Strings.LocationName,
                                    style: TextStyle(color: Consts.OAC),
                                    textScaleFactor: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: colorChangeNotifier.commonColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 50,
                                    color: Consts.OAC,
                                  ),
                                  Text(
                                    Strings.Phone,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Consts.OAC),
                                    textScaleFactor: 2,
                                  ),
                                  Text(
                                    Strings.PhoneName,
                                    style: TextStyle(color: Consts.OAC),
                                    textScaleFactor: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              launchMailto();
                            },
                            child: Card(
                              color: colorChangeNotifier.commonColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.email,
                                        size: 50,
                                        color: Consts.OAC,
                                      ),
                                      Text(
                                        Strings.Email,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Consts.OAC),
                                        textScaleFactor: 2,
                                      ),
                                      Text(
                                        Strings.EmailName,
                                        style: TextStyle(color: Consts.OAC),
                                        textScaleFactor: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ));
      }
    );
  }

  HoverCrossFadeWidget hoverCrossFadeWidget(ih, location, title) {
    return HoverCrossFadeWidget(
      duration: Duration(milliseconds: 300),
      firstChild: Image.asset(
        location,
        fit: BoxFit.contain,
        height: ih,
        width: ih,
      ),
      secondChild: Consumer<ColorChangeNotifier>(
          builder: (context, colorChangeNotifier, child) {
          return Container(
            width: ih,
            height: ih,
            child: Center(
                child: Text(
              title,
              style: GoogleFonts.getFont(Strings.WSFONT,
                  color: colorChangeNotifier.commonColor, fontSize: 10),
            )),
          );
        }
      ),
    );
  }

  Padding AppBarTitles(title, index, height, context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        child: Text(
          title,
          style: GoogleFonts.getFont(Strings.WSFONT),
        ),
        style: OutlinedButton.styleFrom(
          primary: Consts.OAC,
          side: BorderSide(color: Consts.OAC, width: 2),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: () {
          ScrolltoItam(index);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

void _launchUrl(url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}

launchMailto() async {
  final mailtoLink = Mailto(
    to: [Strings.EmailName],
  );
  // Convert the Mailto instance into a string.
  // Use either Dart's string interpolation
  // or the toString() method.
  await launch('$mailtoLink');
}
