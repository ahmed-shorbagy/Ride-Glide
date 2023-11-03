import 'package:flutter/material.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_nav_drawer.dart';

import 'widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key); // Use key argument here

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(); // Use an instance-specific key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Use the instance-specific key
      drawer: const NavDrawer(),
      body: HomeViewBody(scaffoldKey: scaffoldKey),
    );
  }
}
