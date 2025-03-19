import 'package:diamond_app/template.dart';
import 'package:flutter/material.dart';
import 'changingBackground.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return // Figma Flutter Generator Splashscreen1Widget - FRAME
      // Figma Flutter Generator 0s11Widget - FRAME
      Container(
      width: 428,
      height: 926,
      decoration: BoxDecoration(
          color : Color.fromRGBO(0, 0, 0, 1),
  ),
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: -32,
        child: Container(
        width: 474,
        height: 926,
        decoration: BoxDecoration(
          image : DecorationImage(
          image: AssetImage('assets/images/image1.png'),
          fit: BoxFit.fill
      ),
  )
      )
      ),Positioned(
        top: -17,
        left: -10,
        child: Container(
        width: 452,
        height: 943,
        decoration: BoxDecoration(
          color : Color.fromRGBO(0, 0, 0, 0.4000000059604645),
  )
      )
      ),Positioned(
  top: 700,
  left: 76,
  child: GestureDetector(
    onTap: () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Template(userId: ,)),);
      print("Button Pressed!"); // Replace with navigation or action
    },
    child: Container(
      width: 261,
      height: 58,
      alignment: Alignment.center, // Center text
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40), // Simplified
        color: Color.fromRGBO(25, 21, 255, 1),
      ),
      child: Text(
        "Click Me",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),Positioned(
  top: 550,
  left: 10, // Adjusted to keep text visible
  right: 10, // Ensures it doesn’t go out of screen
  child: SizedBox(
  width: MediaQuery.of(context).size.width - 20, // Ensures it doesn't overflow
  child: Text(
    'Welcome to Karreau, your personalized jewelry shopping experience',
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.white,
      fontFamily: 'DM Sans',
      fontSize: 24,
      fontWeight: FontWeight.normal,
      height: 1.5,
      decoration: TextDecoration.none
    ),
    overflow: TextOverflow.visible, // Ensures wrapping instead of overflow
  ),
)

)

        ]
      )
    );  }
}


class Splashscreen2Widget extends StatelessWidget{
  const Splashscreen2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
    // Figma Flutter Generator Splashscreen2Widget - FRAME
      Container(
      width: 428,
      height: 926,
      decoration: BoxDecoration(
          color : Color.fromRGBO(0, 0, 0, 1),
  ),
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 433,
        left: 111,
        child: SizedBox(
      width: 199,
      height: 60,
      
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: Text('KARREAU', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Diamonds',
        fontSize: 50,
        letterSpacing: 0 ,//percentages not used in flutter. defaulting to zero/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),Positioned(
        top: 0,
        left: 0,
        child: Text('KARREAU', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Diamonds',
        fontSize: 50,
        letterSpacing: 0 ,///percentages not used in flutter. defaulting to zero/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),
        ]
      )
    )
      ),Positioned(
        top: 493,
        left: 64,
        child: Text('Your Ultimate Jewelry Destination', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Diamonds',
        fontSize: 22,
        letterSpacing: 0,// /percentages not used in flutter. defaulting to zero/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),Positioned(
        top: 493,
        left: 64,
        child: Text('Your Ultimate Jewelry Destination', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Diamonds',
        fontSize: 22,
        letterSpacing: 0 ,//percentages not used in flutter. defaulting to zero/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),Positioned(
        top: 519,
        left: 260.9935607910156,
        child: Container(
        width: 96,
        height: 95,
        decoration: BoxDecoration(
          image : DecorationImage(
          image: AssetImage('assets/images/0.S.1.2.png'),
          fit: BoxFit.fitWidth
      ),
  )
      ),
      )
        ]
      ),
        
      );
    
  }
}