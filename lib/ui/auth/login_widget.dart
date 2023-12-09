import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/ui/admin_screen/module/admin_module.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/validation/validation.dart';
import 'package:ithub_quiz/ui/app_routes.dart';
import 'package:ithub_quiz/ui/auth/auth_firebase.dart';
import 'package:ithub_quiz/ui/auth/module/auth_module.dart';
import 'package:ithub_quiz/utils/app_router.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        ],
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Positioned(
                      left: 64 * fem,
                      top: 250.4166564941 * fem,
                      child: SizedBox(
                        width: 193 * fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _emailController,
                              enableSuggestions: true,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  const InputDecoration(hintText: 'Email'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: FormValidator.validatePassword,
                              enableSuggestions: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration:
                                  const InputDecoration(hintText: 'Password'),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 25.0),
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Auth()
                                          .signInWithEmailAndPassword(
                                              email: _emailController.text
                                                  .toString(),
                                              password: _passwordController.text
                                                  .toString())
                                          .then((_) => AppRouter.changeRoute<
                                                  AdminModule>(AppRoutes.root,
                                              context: context));
                                    }
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.black),
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
                            ),
                            const SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                  text: 'Don\'t have an account?',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' Sign up',
                                        style: const TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 18),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            AppRouter.changeRoute<AuthModule>(
                                                AppRoutes.register,
                                                context: context);
                                          })
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
