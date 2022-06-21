import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:url_launcher/url_launcher.dart';

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

class MyMobileBody extends StatelessWidget {
  final ScrollController _controller = ScrollController();
  final about = GlobalKey();
  final skills = GlobalKey();
  final projects = GlobalKey();
  final worksamples = GlobalKey();
  final contact = GlobalKey();



  void _animateToIndex(int index,double height) {
    _controller.animateTo(
      height,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
  Future ScrolltoItam(index) async{
    final context=index.currentContext!;
    await Scrollable.ensureVisible(context);
  }


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:  AppBar(

        backgroundColor: Colors.pinkAccent,
        title: Text("Arun",style: GoogleFonts.getFont('Major Mono Display'),textScaleFactor: 3,),),

      endDrawer: Drawer(

        backgroundColor: Colors.pinkAccent,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Center(child: Text("Arun",style: GoogleFonts.getFont('Major Mono Display',color: Colors.white,),textScaleFactor: 3,)),
            AppBarTitles("ABOUT",about,0,context),
            AppBarTitles("SKILLS",skills,800,context),
            AppBarTitles("PROJECTS",projects,800+500,context),
            AppBarTitles("WORK SAMPLES",worksamples,800+500+800,context),
            AppBarTitles("CONTACT", contact, 800, context),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: height,
              child: ListView(
                controller: _controller,
                children: [
                  Container(key:about,child: EachPages(0, 800.0,context)),
                  Container(key:skills,child: EachPages(1, 500.0,context)),
                  Container(key:projects,child: EachPages(2, 1500.0,context)),
                  Container(key:worksamples,child: EachPages(3, 800,context)),
                  Container(key:contact,child: EachPages(4, 800,context)),
                ],
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
      case 2: return Projects(height, context);
      break;
      case 3: return WorkSamples(height, context);
      break;
      case 4: return Contact(height, context);
      break;


    }
    return Container(color: Colors.white,
      child: Text(""),);

  }

  Container About(height) {
    const textcolor=Colors.white;
    return Container(
      color: Colors.pinkAccent,
      height: height,
      child: Column(
        children:  [
          Center(child: FittedBox(child: Text("Arun",textScaleFactor: 20, style: GoogleFonts.getFont('Francois One',color: textcolor),))),
          Center(child: FittedBox(child: Text("Aspiring Developer",textScaleFactor: 6  ,style: GoogleFonts.getFont('Work Sans',color: textcolor),))),
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

          Center(child: Icon(Icons.arrow_downward_outlined,color: Colors.white,))
        ],
      ),
    );


  }

  Widget Skills(height,context) {
    var ih=height/6;
    if(MediaQuery.of(context).size.width<350)
    {
      ih=height/15;
      print(height);
    }
    else if(MediaQuery.of(context).size.width<375){
      ih=height/11;

    }
    else if(MediaQuery.of(context).size.width<420){
      ih=height/10;

    }
    else if (MediaQuery.of(context).size.width<612){
    ih=height/9;
    }
    else{
      ih=height/9;
    }
    const textcolor=Colors.white;
    return Container(

        height: height,
        child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ElevatedButton(onPressed: (){}, child: Text("Skills",style: GoogleFonts.getFont('Staatliches',color: Colors.white),textScaleFactor:4 ,maxLines: 2,textAlign: TextAlign.left,),style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.pinkAccent)
                        )
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  )
                  ),
                  Expanded(child:  Center(child: Text("Programming languages",style: GoogleFonts.getFont('Staatliches',color: Colors.pinkAccent),textScaleFactor:2 )),),
                  Expanded(child: Wrap(
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
                  )),
                  Expanded(child:  Center(child: Text("Frameworks",style: GoogleFonts.getFont('Staatliches',color: Colors.pinkAccent),textScaleFactor:2 )),),
                  Expanded(child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      hoverCrossFadeWidget(ih,"assets/logos/flutter.png","Flutter"),
                      hoverCrossFadeWidget(ih,"assets/logos/react.png","React"),
                      hoverCrossFadeWidget(ih,"assets/logos/node.png","NodeJS"),
                      hoverCrossFadeWidget(ih,"assets/logos/ejs.png","ExpressJS"),


                    ],
                    spacing: 2,runSpacing: 2,
                  )),
                  Expanded(child:  Center(child: Text("Databases",style: GoogleFonts.getFont('Staatliches',color: Colors.pinkAccent),textScaleFactor:2 )),),
                  Expanded(child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      hoverCrossFadeWidget(ih,"assets/logos/firebase.png","Firebase"),
                      hoverCrossFadeWidget(ih,"assets/logos/sql.png","SQL"),
                      hoverCrossFadeWidget(ih,"assets/logos/mongoDB.png","MongoDB"),

                    ],
                    spacing: 2,runSpacing: 2,
                  )),
                ],
              ),
            ),
          ],
        )
    );


  }

  Container Projects(height,context) {
    const textcolor=Colors.white;
      return  Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height<900?height:MediaQuery.of(context).size.height*2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(onPressed: (){}, child: Text("Projects",style: GoogleFonts.getFont('Staatliches',color: Colors.pinkAccent),textScaleFactor:4 ,maxLines: 2,textAlign: TextAlign.left,),style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Colors.white)
                      )
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                )
                ),
                Expanded(
                  child: Column(
                    children: [
                      Center(child: Text("VFXfood",style: GoogleFonts.getFont('Staatliches',color: Colors.pinkAccent),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),
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
                                child: ElevatedButton(onPressed: (){_launchUrl("https://bit.ly/3sniezC");},child: Text("PlayStore",style: TextStyle(color:textcolor),),style: ButtonStyle(    backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),)),
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
                      Center(child: Text("Vanilai",style: GoogleFonts.getFont('Staatliches',color: Colors.pinkAccent),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),
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
                                child: ElevatedButton(onPressed: (){_launchUrl("https://bit.ly/3xNRytQ");},child: Text("PlayStore",style: TextStyle(color:textcolor),),style: ButtonStyle(    backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),)),
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
                      Center(child: Text("Ballot",style: GoogleFonts.getFont('Staatliches',color: Colors.pinkAccent),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),
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
                                child: ElevatedButton(onPressed: (){_launchUrl("https://github.com/arun7dev/final_year_project.git");},child: Text("Github",style: TextStyle(color:textcolor),),style: ButtonStyle(    backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),)),
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
          )
      );
  




  }

  Widget WorkSamples(height,context){
    return Container(
      color: Colors.pinkAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          ElevatedButton(onPressed: (){}, child: Text("Work Samples",style: GoogleFonts.getFont('Staatliches',color: Colors.pinkAccent),textScaleFactor:4 ,maxLines: 2,textAlign: TextAlign.left,),style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.white)
                )
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          )
          ),
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Text("Github Profile",style: GoogleFonts.getFont('Staatliches',color: Colors.white),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(onPressed: (){_launchUrl("https://github.com/arun7dev");},child: Text("Github",style: TextStyle(color:Colors.pinkAccent),),style: ButtonStyle(    backgroundColor: MaterialStateProperty.all(Colors.white),)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Text("Developer account link",style: GoogleFonts.getFont('Staatliches',color: Colors.white),textScaleFactor:2 ,maxLines: 2,textAlign: TextAlign.center,)),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(onPressed: (){_launchUrl("https://play.google.com/store/apps/dev?id=5595603757420873953");},child: Text("Developer account link",style: TextStyle(color:Colors.pinkAccent),),style: ButtonStyle(    backgroundColor: MaterialStateProperty.all(Colors.white),)),
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
    return  Container(

      //height: height,
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: (){}, child: Text("Get in touch",style: GoogleFonts.getFont('Staatliches',color: Colors.white),textScaleFactor:4 ,maxLines: 2,textAlign: TextAlign.left,),style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.pinkAccent)
                    )
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
              )
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.pinkAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.house,size: 50,color: Colors.white,),
                              Text("Location",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2,),
                              Text("Chennai,India",style: TextStyle(color: Colors.white),textScaleFactor: 1,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.pinkAccent,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [

                              Icon(Icons.phone,size: 50,color: Colors.white,),
                              Text("Phone",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2,),
                              Text("8072269982",style: TextStyle(color: Colors.white),textScaleFactor: 1,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.pinkAccent,


                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              Icon(Icons.email,size: 50,color: Colors.white,),
                              Text("Email",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2,),
                              Text("arun042000@gmail.com",style: TextStyle(color: Colors.white),textScaleFactor: 1,),
                            ],
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
        child: Center(child: Text(title,style: GoogleFonts.getFont('Work Sans',color: Colors.pinkAccent,fontSize: 10),)),),
    );
  }


  Padding AppBarTitles(title,index,height,context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        child: Text(title,
          style: GoogleFonts.getFont('Work Sans'),
        ),
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: BorderSide(color: Colors.white, width: 2),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: () {
          ScrolltoItam(index);
          Navigator.of(context).pop();
        },


      ),
    );
  }
}


final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];


void _launchUrl(url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}