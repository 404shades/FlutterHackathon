import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 5,
          child: FlareActor(
            'assets/person.flr',
            animation: 'conn',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
