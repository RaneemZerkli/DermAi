import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:Column(

        children: [
          const SizedBox(height: 170,),
          Lottie.asset('assets/Cosmetics.json'),
          const SizedBox(height: 30,),
          const Text("Say No To Skin Disease!",
            style: TextStyle(fontSize: 30,
                color:  Colors.black,
                fontWeight: FontWeight.bold),
          ),
          Divider(indent: 20, endIndent: 20, thickness: 5, color: Colors.teal[200],),
          const SizedBox(height: 30,),
          const Text("Check your skin on the smartphone \n"
              "and get instant results within 1 minute."
            ,
            textAlign:TextAlign.center,
            style: TextStyle(fontSize: 20,color: Colors.black),
          )

        ],
      ),
    );
  }
}
