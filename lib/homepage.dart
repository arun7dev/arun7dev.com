
import 'package:arun_portfolio_2/responsive/desktop/desktop_body.dart';
import 'package:arun_portfolio_2/responsive/mobile/mobile_body.dart';
import 'package:arun_portfolio_2/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MyMobileBody(),
        desktopBody: MyDesktopBody(),
      ),
    );
  }
}
