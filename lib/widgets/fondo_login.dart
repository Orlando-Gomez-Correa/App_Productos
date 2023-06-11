import 'package:flutter/material.dart';

class FondoLogin extends StatelessWidget {

  final Widget child;

  const FondoLogin({Key? key, required this.child})
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              child: Icon(
                Icons.person_pin,
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
          this.child,
        ],
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      width: double.infinity,
      //color: Colors.indigo,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 1),
          ]
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            child: _Esfera(),
            top: 90,
            left: 30,
            ),
            Positioned(
            child: _Esfera(),
            top: -40,
            left: -30,
            ),  
            Positioned(
            child: _Esfera(),
            top: -50,
            right: -20,
            ),
            Positioned(
            child: _Esfera(),
            bottom: -50,
            left: 10,
            ),
            Positioned(
            child: _Esfera(),
            bottom: 120,
            right: 20,
            ),   
        ],
      ),
    );
  }
}

class _Esfera extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}

