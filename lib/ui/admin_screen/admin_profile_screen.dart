import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ithub_quiz/ui/admin_screen/dialog_util.dart';

import 'package:ithub_quiz/ui/auth/auth_firebase.dart';

import 'package:ithub_quiz/utils/app_logger.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile Screen',
            style: TextStyle(color: Colors.amber),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height / 2.8,
                child: const Center(
                    child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 100,
                  child: Text('Admin'),
                )),
              ),
              const Divider(
                color: Colors.black12,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                color: Colors.white,
                width: width / 1.1,
                child: Card(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 20, right: 5, left: 5),
                  elevation: 2,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(width: 1.4, color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Personal  Info',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<String>(
                          future: Auth().getUserName(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              if (mounted) {
                                return DynamicPersonalwidget(
                                    'Name', Icons.person, snapshot.data!);
                              } else {
                                return const SizedBox();
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DynamicPersonalwidget(
                            'Email', Icons.email, _auth.currentUser!.email!),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await DialogUtils.createConfirmationDialog(
                                  context: context,
                                  title: 'Confirmation',
                                  width: width / 1.2 * 2,
                                  dialogType: DialogType.info,
                                  description:
                                      'Are you sure you want to sign out?',
                                  onOkPressed: () async {
                                    if (mounted) {
                                      await Auth().signOut();
                                      // Modular.to.pushNamedAndRemoveUntil(
                                      //   '/admin/login', (route) => false);
                                    }
                                  },
                                ).show();
                              } catch (e) {
                                logger.e('Dialog error $e');
                              }
                            },
                            child: const Text('Log out'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Column DynamicPersonalwidget(String text, IconData icon, String value) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                text,
                style: const TextStyle(color: Colors.amber),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextField(
            controller: TextEditingController(text: value),
            readOnly: true,
          ),
        ),
      ],
    );
  }
}
