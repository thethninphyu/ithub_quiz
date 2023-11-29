import 'package:flutter/material.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var width, height;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 298;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile Screen',
            style: TextStyle(color: Colors.amber),
          ),
        ),
        body: SizedBox(
            width: double.infinity,
            child: SizedBox(
              width: double.infinity,
              height: 595 * fem,
              child: Stack(
                children: [
                  Positioned(
                    left: 0 * fem,
                    top: 0 * fem,
                    child: Container(
                      width: 298 * fem,
                      height: 595 * fem,
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0 * fem,
                            top: 0 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 298 * fem,
                                height: 197.32 * fem,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff080c6d),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(30 * fem),
                                      bottomLeft: Radius.circular(30 * fem),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 28 * fem,
                            top: 147.7380981445 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 242 * fem,
                                height: 415.89 * fem,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffffffff)),
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100 * fem),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 98 * fem,
                            top: 72.8571472168 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 80 * fem,
                                height: 39 * fem,
                                child: Text(
                                  'QUIZ',
                                  style: TextStyle(
                                    fontSize: 32 * ffem,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2125 * ffem / fem,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 101 * fem,
                            top: 21.25 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 96 * fem,
                                height: 40.48 * fem,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0x33ffffff),
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                        'assets/page-1/images/decision-bg.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 109 * fem,
                            top: 186.1904907227 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 62 * fem,
                                height: 25 * fem,
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 20 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2125 * ffem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 64 * fem,
                    top: 290.4166564941 * fem,
                    child: SizedBox(
                      width: 193 * fem,
                      height: 100.51 * fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 8.27 * fem),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 12 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2125 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 77.23 * fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 1.5 * fem,
                                  top: 52.0807037354 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 191.5 * fem,
                                      height: 1.55 * fem,
                                      // child: Image.asset(
                                      //   'assets/page-1/images/line-3.png',
                                      //   width: 191.5 * fem,
                                      //   height: 1.55 * fem,
                                      // ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0 * fem,
                                  top: 22.7678527832 * fem,
                                  child: SizedBox(
                                    width: 76 * fem,
                                    height: 29.35 * fem,
                                    child: Text(
                                      'Password',
                                      style: TextStyle(
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2125 * ffem / fem,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 2 * fem,
                                  top: 62.2321472168 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 102 * fem,
                                      height: 15 * fem,
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2125 * ffem / fem,
                                          color: const Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
