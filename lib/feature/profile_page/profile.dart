import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/core/resources/constants/colors.dart';
import 'package:to_do_app/data/boxes.dart';
import 'package:to_do_app/core/widgets/motivatedItem.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    String allToDo = boxToDo.length.toString();
    String allDoneToDo =
        boxToDo.values.where((element) => element.isDone).length.toString();
    int vibe = 0;

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
                              Expanded(
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
                                      vibe.toString(),
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
          allToDo == allDoneToDo ? const Text('aaa') : const MotivatedItem()
        ],
      ),
    );
  }
}

String getVibe(int vibe) {
  if (vibe >= 90 && vibe <= 100) return 'assets/lottie/smile100.json';
  if (vibe >= 80 && vibe < 90) return 'assets/lottie/smile90.json';
  if (vibe >= 70 && vibe < 80) return 'assets/lottie/smile80.json';
  if (vibe >= 60 && vibe < 70) return 'assets/lottie/smile70.json';
  if (vibe >= 50 && vibe < 60) return 'assets/lottie/smile60.json';
  if (vibe >= 40 && vibe < 50) return 'assets/lottie/smile50.json';
  if (vibe >= 30 && vibe < 40) return 'assets/lottie/smile40.json';
  if (vibe >= 20 && vibe < 30) return 'assets/lottie/smile30.json';
  if (vibe >= 10 && vibe < 20) return 'assets/lottie/smile20.json';
  return 'assets/lottie/smile10.json';
}
