import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
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
                        DynamicPersonalwidget('Name', Icons.person),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DynamicPersonalwidget('Email', Icons.email),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width,
                          child: ElevatedButton(
                              onPressed: () {
                                Column(
                                  children: [
                                    AnimatedButton(
                                      text: 'Info Dialog for Log out',
                                      pressEvent: () {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.info,
                                          borderSide: const BorderSide(
                                              color: Colors.green, width: 2),
                                          width: 200,
                                          buttonsBorderRadius: const BorderRadius.all(
                                              Radius.circular(2)),
                                          dismissOnTouchOutside: true,
                                          dismissOnBackKeyPress: false,
                                          headerAnimationLoop: false,
                                          title: 'Info',
                                          desc: 'Are you sure you want to sign out?',
                                          showCloseIcon: true,
                                        ).show();
                                      },
                                    ),
                                  ],
                                );

                                // Auth().signOut();
                              },
                              child: const Text('Log out')),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )

        //  Center(

        // )

        );
  }

  // ignore: non_constant_identifier_names
  Column DynamicPersonalwidget(String text, IconData icon) {
    return Column(
      children: [
        Row(
          children: [Icon(icon), Text(text)],
        ),
        TextField(
          decoration: InputDecoration(
            label: Text(text),
          ),
        )
      ],
    );
  }
}
