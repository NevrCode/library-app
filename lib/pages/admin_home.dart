// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:library_app/constants/costum_color.dart';
import 'package:library_app/pages/addBookpage.dart';
import 'package:library_app/item-generators/db_tools.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage(
      {Key? key, this.callback = _doNothing, this.selectedGenre})
      : super(key: key);

  final VoidCallback callback;
  final String? selectedGenre;
  static void _doNothing() {}
  @override
  AdminHomePageWidgetState createState() => AdminHomePageWidgetState();
}

class AdminHomePageWidgetState extends State<AdminHomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController genreController = TextEditingController();

  void rebuild() {
    setState(() {
      widget.callback();
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
      backgroundColor: secondaryText,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF251B40),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color(0x3B1D2429),
                            offset: Offset(0, -3),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 16, 0, 0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                      },
                                      style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                          const Size(double.infinity, 60),
                                        ),
                                        side: MaterialStateProperty.all(
                                          const BorderSide(
                                            width: 2,
                                            color: error,
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                primaryBackground),
                                      ),
                                      child: const Text(
                                        'Logout',
                                        style: TextStyle(
                                          color: error,
                                          fontSize: 16,
                                          fontFamily: "Readex",
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'ADMIN',
                    style: TextStyle(
                      fontFamily: 'Readex',
                      color: Color(0xFFF2AA64),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Panel',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Readex',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(14, 12, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Gen',
                              style: TextStyle(
                                  fontFamily: 'Readex',
                                  color: Color(0xFFF3B06A),
                                  fontSize: 18),
                            ),
                            Text(
                              're',
                              style: TextStyle(
                                  fontFamily: 'Readex',
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 17, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    width: double.infinity,
                                    height: 493,
                                    decoration: const BoxDecoration(
                                      color: secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Color(0x3B1D2429),
                                          offset: Offset(0, -3),
                                        )
                                      ],
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 0, 10, 16),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(),
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller:
                                                          genreController,
                                                      autofillHints: const [
                                                        AutofillHints.name
                                                      ],
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Category Name',
                                                        labelStyle: labelMedium,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color: alternate,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color: primary,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color: error,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                            color: error,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            secondaryBackground,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(24),
                                                      ),
                                                      style: bodyMedium,
                                                      keyboardType:
                                                          TextInputType.text,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  if (genreController
                                                      .text.isEmpty) {
                                                    return;
                                                  }
                                                  await MySQLDBFunctions
                                                      .addGenre(
                                                          genreController.text);
                                                  rebuild();
                                                  widget.callback();
                                                  Navigator.of(context).pop();
                                                },
                                                icon: const Icon(
                                                    Icons.check_rounded),
                                                color: tertiary,
                                                style: ButtonStyle(
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          const EdgeInsets
                                                              .fromLTRB(
                                                              17, 0, 24, 0)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          const CircleBorder()),
                                                  fixedSize:
                                                      MaterialStateProperty.all(
                                                    const Size(57, 57),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 16, 0, 0),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ButtonStyle(
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all(
                                                        const Size(
                                                            double.infinity,
                                                            60),
                                                      ),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .transparent),
                                                    ),
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 175, 175, 175),
                                                        fontSize: 16,
                                                        fontFamily: "Readex",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 247, 187, 122)),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(8, 0, 17, 0)),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(115, 26))),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 22,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Category",
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(0, 16, 49, 74),
                    ),
                    child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                        child: MySQLDBFunctions.makeCategoryButtons("admin")),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 17.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddBookPage(
                                    callback: rebuild,
                                  )));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 247, 187, 122)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.fromLTRB(8, 0, 17, 0)),
                            fixedSize:
                                MaterialStateProperty.all(const Size(90, 26))),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 22,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Book",
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
                MySQLDBFunctions.makeBookCards("admin",
                    callback: rebuild, genre: widget.selectedGenre),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(14, 12, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Member',
                        style: TextStyle(
                            fontFamily: 'Readex',
                            color: Color(0xFFF3B06A),
                            fontSize: 18),
                      ),
                      Text(
                        ' Information',
                        style: TextStyle(
                            fontFamily: 'Readex',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SizedBox(
                        child: MySQLDBFunctions.makeAdminMemberCards(rebuild))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
