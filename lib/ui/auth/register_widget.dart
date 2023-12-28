import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/ui/admin_screen/module/admin_module.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/validation/validation.dart';
import 'package:ithub_quiz/ui/app_routes.dart';
import 'package:ithub_quiz/ui/auth/auth_firebase.dart';
import 'package:ithub_quiz/ui/auth/module/auth_module.dart';
import 'package:ithub_quiz/utils/app_router.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                              controller: nameController,
                              enableSuggestions: true,
                              validator: FormValidator.validateName,
                              keyboardType: TextInputType.name,
                              decoration:
                                  const InputDecoration(hintText: 'Name'),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              validator: (email) {
                                if (email!.isEmpty) {
                                  return 'Please enter a email!';
                                } else if (!FormValidator.isEmailValid(email)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              controller: emailController,
                              enableSuggestions: true,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  const InputDecoration(hintText: 'Email'),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              validator: FormValidator.validatePassword,
                              controller: passwordController,
                              enableSuggestions: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration:
                                  const InputDecoration(hintText: 'Password'),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 25.0),
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await Auth()
                                          .createUserWithEmailAndPassword(
                                              email: emailController.text
                                                  .toString(),
                                              password: passwordController.text
                                                  .toString(),
                                              name: nameController.text
                                                  .toString(),
                                              role: 'user')
                                          .then((_) => AppRouter.changeRoute<
                                                  AdminModule>(AppRoutes.root,
                                              context: context));
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                        color: AppColors.primaryColor),
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
                                                AppRoutes.login,
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
