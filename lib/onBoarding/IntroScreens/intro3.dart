import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:Column(

        children: [
          const SizedBox(height: 20,),
          Lottie.asset('assets/clock.json'),
          // SizedBox(height: 30,),
          const Text("Don't Waste Time!",
            style: TextStyle(fontSize: 30,
                color:  Colors.black,
                fontWeight: FontWeight.bold),
          ),
          Divider(indent: 20, endIndent: 20, thickness: 5, color: Colors.teal[200],),
          const SizedBox(height: 30,),
          const Text("One of the most dangerous diseases that\n"
              "AI Dermatologist can help identify is skin cancer."
            ,
            textAlign:TextAlign.center,
            style: TextStyle(fontSize: 20,color: Colors.black),
          )

        ],
      ),
    );
  }
}