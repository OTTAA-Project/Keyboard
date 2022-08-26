import 'package:flutter/material.dart';
import 'package:keyboards/app/utils/constants.dart';

class TemporaryLogin extends StatelessWidget {
  const TemporaryLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keyboard'),
        backgroundColor: kColorAppbar,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            color: kPrimaryBG,
            child: Center(
                child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: constraints.maxHeight * 0.7,
                  width: constraints.maxWidth * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            Text(
                              'Bienvenido',
                              style: TextStyle(
                                  color: Color(0xFF777777), fontSize: 25),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Registrate con tu cuenta de Google para acceder a todas las funciones de la aplicacion',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF989898), fontSize: 16),
                            ),
                          ],
                        ),

                        // GOOGLE BUTTON
                        GestureDetector(
                          onTap: () async {
                            //todo: add the login procedure here
                            /*log('Google Button Tapped');
                            if (true) {
                              try {
                                //todo: add the login here
                                // bool isDone = await cAuth.login();
                                // isDone ? Get.off(() => MainView()) : null;
                              } catch (e) {
                                log('====ERROR OCCURED $e');
                              }
                            } else {
                              //todo: add the snackbar here
                             */ /* Get.snackbar(
                                '${cAuth.currentUser.value?.displayName}',
                                'You are already LoggedIn',
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                mainButton: TextButton(
                                  onPressed: () {
                                    //todo: add the login here
                                  },
                                  child: const Text(
                                    'Goto Main Screen',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );*/ /*
                            }*/
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          ('assets/images/gIcon.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                const Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Acceder con Google',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  top: -40,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/logoOttaa.jpg'),
                  ),
                )
              ],
            )),
          );
        },
      ),
    );
  }
}
