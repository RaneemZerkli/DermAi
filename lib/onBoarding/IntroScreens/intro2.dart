import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:Column(

        children: [
          const SizedBox(height: 200,),
          Lottie.asset('assets/m.json'),
          // SizedBox(height: 30,),
          const Text("Use Our ChatBot",
            style: TextStyle(fontSize: 30,
                color:  Colors.black,
                fontWeight: FontWeight.bold),
          ),
          Divider(indent: 20, endIndent: 20, thickness: 5, color: Colors.teal[200],),
          const SizedBox(height: 30,),
          const Text("We want to understand your skin better "
              "so we can recommend the best products for you."
            ,
            textAlign:TextAlign.center,
            style: TextStyle(fontSize: 20,color: Colors.black),
          )

        ],
      ),
    );
  }
}