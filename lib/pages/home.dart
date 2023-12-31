import 'package:flutter/material.dart';
import 'package:library_app/constants/costum_color.dart';
import 'package:library_app/pages/login.dart';
import 'package:library_app/item-generators/db_tools.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.selectedGenre}) : super(key: key);
  final String? selectedGenre;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void rebuild(){
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: const Color(0xFF251B40),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: Image.asset(
                    'assests/Icons/logo.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const Text('README.BOOK', style: headlineXSmall),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage(callback: rebuild,)));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 247, 187, 122)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(8, 0, 17, 0)),
                  fixedSize: MaterialStateProperty.all(const Size(100, 32))),
              child: const Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 22,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: "Readex",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: true,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF241243),
                  primaryBackground,
                ],
                stops: [0, 0.6],
                begin: AlignmentDirectional(-0.87, -1),
                end: AlignmentDirectional(0.87, 1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(14, 15, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Books ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 243, 177, 106),
                          fontSize: 14,
                          fontFamily: "Readex",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'of the week !',
                        style: bodyMedium,
                      ),
                    ],
                  ),
                ),
                MySQLDBFunctions.makeBookOfTheWeekCards("home"),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(14, 15, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Gen',
                        style: TextStyle(
                          color: Color.fromARGB(255, 243, 177, 106),
                          fontSize: 14,
                          fontFamily: "Readex",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        're',
                        style: bodyMedium,
                      ),
                    ],
                  ),
                ),
                MySQLDBFunctions.makeCategoryButtons("home"),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child:
                        MySQLDBFunctions.makeBookCards("home",genre: widget.selectedGenre),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
