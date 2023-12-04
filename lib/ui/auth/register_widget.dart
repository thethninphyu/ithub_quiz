import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/ui/app_routes.dart';
import 'package:ithub_quiz/ui/auth/module/auth_module.dart';
import 'package:ithub_quiz/utils/app_router.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  @override
  Widget build(BuildContext context) {
     double baseWidth = 300;
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
                      width: 300 * fem,
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
                                width: 300 * fem,
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
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2125 * ffem / fem,
                                  color: const Color(0xff000000),
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
                          
                          const TextField(
                            enableSuggestions: true,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Name'
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const TextField(
                          enableSuggestions: true,
                          
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email'
                          ),
                                                    ),
                         const SizedBox(height: 15,),
                                                 
                           const TextField(
                            enableSuggestions: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: 'Password'
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 25.0),
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'Register',
                                  style: TextStyle(color: Colors.amber),
                                )),
                          ),

                          RichText(
                            text: TextSpan(
                                text: 'Already have an account?',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' Login',
                                      style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 18),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          AppRouter.changeRoute<AuthModule>(
                                              AppRoutes.login);
                                        })
                                ]),
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
