import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ithub_quiz/constants/colors.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 298;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
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
                        color: AppColors.backgroundColor,
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
                                    color: AppColors.secondaryColor,
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
                                height: 595 * fem,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100 * fem),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 120 * fem,
                            top: 72.8571472168 * fem,
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 80 * fem,
                                height: 39 * fem,
                                child: Text(
                                  'QUIZ',
                                  style: TextStyle(
                                    fontSize: 32 * ffem,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2125 * ffem / fem,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 120 * fem,
                            top: 21.25 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 50 * fem,
                                height: 50 * fem,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/quiz.png',
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
                    top: 250.4166564941 * fem,
                    child: SizedBox(
                      width: 193 * fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
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
                              const Expanded(
                                flex: 2,
                                child: TextField(
                                  enableSuggestions: true,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 80.23 * fem,
                            child: Stack(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
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
                                    const Expanded(
                                      flex: 2,
                                      child: TextField(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
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
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 25.0),
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.amber),
                                )),
                          ),
                          const Center(
                              child: Text(
                            'OR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                          const Center(
                            child: Text(
                              'Sign In with',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                child: FaIcon(
                                  FontAwesomeIcons.facebook,
                                  size: 35,
                                  color: HexColor("#3E529C"),
                                ),
                                onTap: () {},
                              ),
                           
                              GestureDetector(
                                child: FaIcon(
                                  FontAwesomeIcons.google,
                                  size: 35,
                                  color: HexColor("#3E529C"),
                                ),
                                onTap: () {},
                              ),
                           
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
