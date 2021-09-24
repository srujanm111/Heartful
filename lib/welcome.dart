import 'package:flutter/material.dart';
import 'package:heartful/form.dart';
import 'package:heartful/widgets.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: 320,
            left: 74,
            child: CustomText(
              text: "Heartful.",
              red: false,
              size: 60,
            ),
          ),
          Positioned(
            top: 401,
            left: 34,
            right: 34,
            child: CustomText(
              text: "An ML solution to predicting survival of heart failure patients",
              red: false,
              size: 24,
            ),
          ),
          Positioned(
            top: 764,
            left: 34,
            right: 34,
            child: CustomButton(
              text: "Get Started",
              inverted: true,
              onPress: () => Navigator.of(context).pushReplacement(PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 200),
                pageBuilder: (context, animation1, animation2) => PatientInfoForm(),
                transitionsBuilder: (context, animation1, animation2, child) => FadeTransition(opacity: animation1, child: child,),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
