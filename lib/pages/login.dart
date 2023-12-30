import 'package:flutter/material.dart';
import 'package:library_app/constants/costum_color.dart';
import 'package:library_app/constants/membertype.dart';
import 'package:library_app/pages/admin_home.dart';
import 'package:library_app/pages/member_home.dart';
import 'package:library_app/pages/sign_in.dart';
import 'package:library_app/item-generators/database_widget_generator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isHide = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      backgroundColor: secondaryBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 303,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF251B40),
                    Color(0xFF1E133E),
                    Color(0xFF251B40)
                  ],
                  stops: [0, 0, 1],
                  begin: AlignmentDirectional(1, 0),
                  end: AlignmentDirectional(-1, 0),
                ),
              ),
              child: Container(
                width: 100,
                height: 131,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF251B40),
                      secondaryBackground,
                    ],
                    stops: [0.4, 1],
                    begin: AlignmentDirectional(0, -1),
                    end: AlignmentDirectional(0, 1),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0x00262D34),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          "assests/Icons/logo.png",
                        ),
                      ),
                    ),
                    const Text(
                      'README.BOOK',
                      style: headlineSmall,
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: emailController,
                          autofocus: true,
                          autofillHints: const [AutofillHints.email],
                          obscureText: false,
                          decoration: inputAuthStyle,
                          style: bodyMedium,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: passwordController,
                          autofillHints: const [AutofillHints.password],
                          obscureText: isHide,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: secondaryBackground,
                            contentPadding: const EdgeInsets.all(24),
                            suffixIcon: InkWell(
                              onTap: () => {setState(() => isHide = !isHide)},
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                isHide
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: secondaryText,
                                size: 24,
                              ),
                            ),
                          ),
                          style: bodyMedium,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 16),
                            child: TextButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    const Size(133, 23)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                                backgroundColor: MaterialStateProperty.all(
                                    secondaryBackground),
                                shape: MaterialStateProperty.all(
                                  ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const SigninPage()));
                              },
                              child: const Text(
                                'belum punya akun?',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: ElevatedButton(
                          onPressed: () async {
                            print("object");
                            Map data = await DatabaseWidgetGenerator.login(
                                emailController.text, passwordController.text);
                            if (data["memberType"] == MemberType.user) {
                              // gatau kenapa
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MemberPage(
                                        id: data["id"],
                                        name: data["name"],
                                        tingkat: data["tingkat"],
                                        sisaPinjam: data["sisa_pinjam"],
                                        tglBalik: data["tgl_balik"],
                                      )));
                            } else if (data["memberType"] == MemberType.admin) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AdminHomePage()));
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Ups.. Username atau Password salah '),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(230, 52)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFF2A862)),
                            elevation: MaterialStateProperty.all(3),
                            shape: MaterialStateProperty.all(
                              ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: titleSmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 40,
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: Text('Copyright Kevin & Rio 2023',
                        style: copyrightStyle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
