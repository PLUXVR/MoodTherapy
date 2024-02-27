import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/data/boxes.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    String allToDo = boxToDo.length.toString();
    String allDoneToDo =
        boxToDo.values.where((element) => element.isDone).length.toString();
    int vibe = 40;

    return Scaffold(
      backgroundColor: tdBGColor,
      body: Column(
        children: <Widget>[
          Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [tdBGColor, tdTeal])),
              child: SizedBox(
                width: double.infinity,
                height: 450.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 170,
                        width: 170,
                        child: Lottie.asset(getVibe(vibe), reverse: true),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Максим Беседин",
                        style: TextStyle(
                          fontSize: 29.0,
                          fontWeight: FontWeight.bold,
                          color: tdBGColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: tdBGColor,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    const Text(
                                      'Задач \n'
                                      'задумано',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: tdGreen,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      allToDo,
                                      style: const TextStyle(
                                        fontSize: 27.0,
                                        color: tdGreen,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    const Text(
                                      "Задач выполнено",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: tdGreen,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      allDoneToDo,
                                      style: const TextStyle(
                                        fontSize: 27.0,
                                        color: tdGreen,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Общее настроение",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: tdGreen,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "1300",
                                      style: TextStyle(
                                        fontSize: 27.0,
                                        color: tdGreen,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),

          allToDo == allDoneToDo
              ?

              // TODO Место под дополнительную информацию
              const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Bio:",
                        style: TextStyle(
                            color: tdRed,
                            fontStyle: FontStyle.normal,
                            fontSize: 28.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'My name is Alice and I am  a freelance mobile app developper.\n'
                        'if you need any mobile app for your company then contact me for more informations',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                )
              : Text('ddd')
          // const SizedBox(
          //   height: 20.0,
          // ),
          // SizedBox(
          //   width: 300.00,
          //   child: FloatingActionButton(
          //       onPressed: () {},
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(80.0)),
          //       elevation: 0.0,
          //       child: Ink(
          //         decoration: BoxDecoration(
          //           gradient: const LinearGradient(
          //               begin: Alignment.centerRight,
          //               end: Alignment.centerLeft,
          //               colors: [tdRed, tdRed]),
          //           borderRadius: BorderRadius.circular(30.0),
          //         ),
          //         child: Container(
          //           constraints:
          //               const BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
          //           alignment: Alignment.center,
          //           child: const Text(
          //             "Contact me",
          //             style: TextStyle(
          //                 color: tdBGColor,
          //                 fontSize: 26.0,
          //                 fontWeight: FontWeight.w300),
          //           ),
          //         ),
          //       )),
          // ),
        ],
      ),
    );
  }
}

String getVibe(int vibe) {
  switch (vibe) {
    case 40:
      return 'assets/lottie/gloomy.json';
    default:
      return 'assets/lottie/very_sad.json';
  }
}
