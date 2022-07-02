import 'package:animated_background/animated_background.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glass/glass.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';


class MyDesktopBody extends StatefulWidget {
  @override
  State<MyDesktopBody> createState() => _MyDesktopBodyState();
}

class _MyDesktopBodyState extends State<MyDesktopBody>  with TickerProviderStateMixin {
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
    image1 = Image.asset("assets/images/cartoon.png");


  }

  void didChangeDependencies() {
    precacheImage(image1.image, context);
    super.didChangeDependencies();
  }

  void _animateToIndex(int index,double height) {
    _controller.animateTo(
      height,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future ScrolltoItam(index) async{
    final context=index.currentContext!;
    await Scrollable.ensureVisible(context,duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,);

  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(

      body: Column(
        children: [
          AppBar(
            title: Text("Arun",style: GoogleFonts.getFont('Major Mono Display',color: other_accent_color),textScaleFactor:2 ),

            backgroundColor: common_color,

            actions: [
              AppBarTitles("ABOUT",about,0,),
              AppBarTitles("SKILLS",skills,800,),
              AppBarTitles("PROJECTS",projects,800+500,),
              AppBarTitles("WORK SAMPLES",worksamples,800+500+800,),
              AppBarTitles("CONTACT",contact,800+500+800,),
            ],

          ),
          Expanded(
            child: SizedBox(
              height: height,
              child: SingleChildScrollView(
                child: Column(

                  children: [
                    Container(key:about,child: EachPages(0, 800,context)),
                    Container(key:skills,child: EachPages(1, 500,context)),
                    Container(key:projects,child: EachPages(2, 800,context)),
                    Container(key:worksamples,child: EachPages(3, 800,context)),
                    Container(key:contact,child: EachPages(4, 800,context)),
                    Container(
                        color:Colors.black,
                        child:Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Developed in 💙 with ',style: TextStyle(color: Colors.white)),
                                TextSpan(
                                  text: 'Flutter',
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                    )

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
    );
  }

  Widget EachPages(index,height,context) {
    switch(index)
        {
      case 0: return About(height);
             break;
      case 1: return Skills(height,context);
      break;
      case 2: return Projects(height,context);
      break;
      case 3: return WorkSamples(height, context);
      break;
      case 4: return Contact(height, context);
      break;


    }
    return Container(color: other_accent_color,
    child: Text(""),);

  }

  Widget About(height) {
    var textcolor=other_accent_color;
      return Container(
        height: height,
        child: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: const  ParticleOptions(

              baseColor:  Color(0xffff6780),
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
          child: Container(
            color: common_color?.withOpacity(0.5),

            height: height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MediaQuery.of(context).size.width<=1500?Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [

                  Center(child: FittedBox(child: Text("Arun",textScaleFactor: 20, style: GoogleFonts.getFont('Francois One',color: textcolor),))),
                  Center(child: FittedBox(child: Text("Aspiring Developer",textScaleFactor: 7  ,style: GoogleFonts.getFont('Work Sans',color: textcolor),))),
                  Center(child:SizedBox(
                    width: 1000,
                    child: Text(
                      'Looking forward to earning the position of Software Engineer at a leading organization to showcase my skills in programming to generate high-end solutions to general software issues along with drawing better user experience.',
                      overflow: TextOverflow.clip,
                      maxLines: 7,
                      textScaleFactor: 2,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont('Big Shoulders Text',color: textcolor),  ),
                  ),),

                  Center(child: Icon(Icons.arrow_downward_outlined,color: other_accent_color,))
                ],
              ):
              Stack(

                fit: StackFit.expand,
                children: [
                  Positioned(

                    bottom:MediaQuery.of(context).size.height*0.1,
                    right: MediaQuery.of(context).size.width*0.1,
                    child: image1,
                  ),
                  Positioned(
                    bottom:MediaQuery.of(context).size.height*0.1,
                    left: MediaQuery.of(context).size.width*0.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [

                        FittedBox(child: Text("Arun",textScaleFactor: 20, style: GoogleFonts.getFont('Francois One',color: textcolor),)),
                        FittedBox(child: Text("Aspiring Developer",textScaleFactor: 7  ,style: GoogleFonts.getFont('Work Sans',color: textcolor),)),
                        SizedBox(
                          width: 1000,
                          child: Text(
                            'Looking forward to earning the position of Software Engineer at a leading organization to showcase my skills in programming to generate high-end solutions to general software issues along with drawing better user experience.',
                            overflow: TextOverflow.clip,
                            maxLines: 7,
                            textScaleFactor: 2,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.getFont('Big Shoulders Text',color: textcolor),  ),
                        ),

                        Center(child: Icon(Icons.arrow_downward_outlined,color: other_accent_color,))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );


  }

  Widget Skills(height,context) {
    var ih=height/4;
    if(MediaQuery.of(context).size.width<1525)
      {
        ih=height/5;
        print(height);
      }
    else{
      ih=height/4;
    }
    var textcolor=other_accent_color;
    return Container(
        color: other_accent_color,
      //height: height,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(onPressed: (){}, child: Text("Skills",style: GoogleFonts.getFont('Staatliches',color: other_accent_color),textScaleFactor:5 ,maxLines: 2,textAlign: TextAlign.left,),style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: common_color!)
                  )
              ),
              backgroundColor: MaterialStateProperty.all<Color>(common_color!),
            )
            ),
            Row(
              children: [
                Expanded(child:  Center(child: Text("Programming languages",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),),
                Expanded(child:  Center(child: Text("Frameworks",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:2 )),),
                Expanded(child:  Center(child: Text("Databases",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:2 )),)
              ],
            ),
            Row(
              children: [
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(

                    alignment: WrapAlignment.center,
                    children: [
                      hoverCrossFadeWidget(ih,"assets/logos/dart.png","Dart"),
                      hoverCrossFadeWidget(ih,"assets/logos/python.png","Python"),
                      hoverCrossFadeWidget(ih,"assets/logos/java.png","Java"),
                      hoverCrossFadeWidget(ih,"assets/logos/c.png","C"),
                      hoverCrossFadeWidget(ih,"assets/logos/c++.png","C++"),
                      hoverCrossFadeWidget(ih,"assets/logos/js.png","JavaScript"),
                      hoverCrossFadeWidget(ih,"assets/logos/perl.png","Perl"),

                    ],
                    spacing: 4,runSpacing: 4,
                  ),
                )),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      hoverCrossFadeWidget(ih,"assets/logos/flutter.png","Flutter"),
                      hoverCrossFadeWidget(ih,"assets/logos/react.png","React"),
                      hoverCrossFadeWidget(ih,"assets/logos/node.png","NodeJS"),
                      hoverCrossFadeWidget(ih,"assets/logos/ejs.png","ExpressJS"),


                    ],
                    spacing: 2,runSpacing: 2,
                  ),
                )),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      hoverCrossFadeWidget(ih,"assets/logos/firebase.png","Firebase"),
                      hoverCrossFadeWidget(ih,"assets/logos/sql.png","SQL"),
                      hoverCrossFadeWidget(ih,"assets/logos/mongoDB.png","MongoDB"),

                    ],
                    spacing: 2,runSpacing: 2,
                  ),
                )),
              ],
            ),
          ],
        ),
      )
    );


  }

  Widget Projects(height,context) {
    var textcolor=other_accent_color;
    if(MediaQuery.of(context).size.width>950){
      return  Container(
          color: accent_color,
          //height: height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){}, child: Text("Projects",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:5 ,maxLines: 2,textAlign: TextAlign.left,),style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: other_accent_color)
                        )
                    ),
                  backgroundColor: MaterialStateProperty.all<Color>(accent_color),
                )
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Center(child: Text("VFXfood",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child: Image.asset("assets/projects/2.png")),
                              Flexible(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("This was my internship project with Mist VFX company. VFX FOOD is an online VFX & Animation reporter. Which provides industries latest & trusted information of news, updates, articles, interviews, and jobs all over the world.",style: GoogleFonts.getFont('Open Sans',color: textcolor),  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: ElevatedButton(onPressed: (){_launchUrl("https://bit.ly/3sniezC");},child: Text("PlayStore",style: TextStyle(color:textcolor),),style: ButtonStyle(    backgroundColor: MaterialStateProperty.all(common_color),)),
                                  ),
                                ],
                              ),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Center(child: Text("Vanilai",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child: Image.asset("assets/projects/1.png")),
                              Flexible(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Vanilai is a simple weather app built with a open API providing necessary weather updates of users current location",style: GoogleFonts.getFont('Open Sans',color: textcolor),  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: ElevatedButton(onPressed: (){_launchUrl("https://bit.ly/3xNRytQ");},child: Text("PlayStore",style: TextStyle(color:textcolor),),style: ButtonStyle(    backgroundColor: MaterialStateProperty.all(common_color),)),
                                  ),
                                ],
                              ),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Center(child: Text("Ballot",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child: Image.asset("assets/projects/3.png")),
                              Flexible(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ballot is a election application created for conducting student council election.This was my final year college project",style: GoogleFonts.getFont('Open Sans',color: textcolor),  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: ElevatedButton(onPressed: (){_launchUrl("https://github.com/arun7dev/final_year_project.git");},child: Text("Github",style: TextStyle(color:textcolor),),style: ButtonStyle(    backgroundColor: MaterialStateProperty.all(common_color),)),
                                  ),
                                ],
                              ),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      );
    }

    else{

      return   Container(
          color: accent_color,
          //height: height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){}, child: Text("Projects",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:5 ,maxLines: 2,textAlign: TextAlign.left,),style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: other_accent_color)
                      )
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(other_accent_color),
                )
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Center(child: Text("VFXfood",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(

                              child: Image.asset("assets/projects/2.png"),onTap: (){_launchUrl("https://bit.ly/3sniezC");},),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Center(child: Text("Vanilai",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),
                          MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(child: Image.asset("assets/projects/1.png"),onTap: (){_launchUrl("https://bit.ly/3xNRytQ");},))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Center(child: Text("Ballot",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),
                          MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(child: Image.asset("assets/projects/3.png"),onTap: (){_launchUrl("https://github.com/arun7dev/final_year_project.git");},))


                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      );
    }



  }

  Widget WorkSamples(height,context){
    return Container(
      color: common_color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          ElevatedButton(onPressed: (){}, child: Text("Work Samples",style: GoogleFonts.getFont('Staatliches',color: common_color),textScaleFactor:5 ,maxLines: 2,textAlign: TextAlign.left,),style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: other_accent_color)
                )
            ),
            backgroundColor: MaterialStateProperty.all<Color>(other_accent_color),
          )
          ),
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Text("Github Profile",style: GoogleFonts.getFont('Staatliches',color: other_accent_color),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(onPressed: (){_launchUrl("https://github.com/arun7dev");},child: Text("Github",style: TextStyle(color:common_color),),style: ButtonStyle(    backgroundColor: MaterialStateProperty.all(other_accent_color),)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Text("Developer account link",style: GoogleFonts.getFont('Staatliches',color: other_accent_color),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(onPressed: (){_launchUrl("https://play.google.com/store/apps/dev?id=5595603757420873953");},child: Text("Developer account",style: TextStyle(color:common_color),),style: ButtonStyle(    backgroundColor: MaterialStateProperty.all(other_accent_color),)),
                  ),
                ],
              ),
            ],
          )
        ],),
      ),
    );
  }

  Widget Contact(height,context){
    return Container(
      color: accent_color,
      //height: height,
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(

                  onPressed: (){}, child: Text("Get in touch",style: GoogleFonts.getFont('Staatliches',color: other_accent_color),textScaleFactor:5 ,maxLines: 2,textAlign: TextAlign.left,),style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: common_color!)
                    )
                ),
                backgroundColor: MaterialStateProperty.all<Color>(common_color!),
              )
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: common_color,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
                                child: Icon(Icons.house,size: 50,color: other_accent_color,),
                              ),
                              Text("Location",style: TextStyle(fontWeight: FontWeight.bold,color: other_accent_color),textScaleFactor: 2,),
                              Text("Chennai,India",style: TextStyle(color: other_accent_color),textScaleFactor: 1,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: common_color,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(


                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
                                child: Icon(Icons.phone,size: 50,color: other_accent_color,),
                              ),
                              Text("Phone",style: TextStyle(fontWeight: FontWeight.bold,color: other_accent_color),textScaleFactor: 2,),
                              Text("8072269982",style: TextStyle(color: other_accent_color),textScaleFactor: 1,),
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
                        onTap: (){
                          launchMailto();
                        },
                        child: Card(
                          color: common_color,


                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
                                    child: Icon(Icons.email,size: 50,color: other_accent_color,),
                                  ),
                                  Text("Email",style: TextStyle(fontWeight: FontWeight.bold,color: other_accent_color),textScaleFactor: 2,),
                                  Text("arun042000@gmail.com",style: TextStyle(color: other_accent_color),textScaleFactor: 1,),
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
        )
    );
  }

  HoverCrossFadeWidget hoverCrossFadeWidget(ih,location,title) {
    return HoverCrossFadeWidget(
                  duration: Duration(milliseconds: 300),
                  firstChild:  Image.asset(location, fit: BoxFit.contain,height: ih,width: ih,),
                  secondChild: Container(
                      width: ih,
                      height: ih,
                      child: Center(child: Text(title,style: GoogleFonts.getFont('Work Sans',color: common_color),)),),
                );
  }

  Padding AppBarTitles(title,index,height) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
              child: Text(title,
                  style: GoogleFonts.getFont('Work Sans'),
              ),
              style: OutlinedButton.styleFrom(
                primary: other_accent_color,
                side: BorderSide(color: other_accent_color, width: 2),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: () {
                ScrolltoItam(index);
                },


            ),
    );
  }
}


final List<String> imgList = [
  ""
];


void _launchUrl(url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}

launchMailto() async {
  final mailtoLink = Mailto(
    to: ['arun042000@gmail.com'],
  );
  // Convert the Mailto instance into a string.
  // Use either Dart's string interpolation
  // or the toString() method.
  await launch('$mailtoLink');
}