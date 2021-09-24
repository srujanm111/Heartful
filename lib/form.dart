import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heartful/result.dart';
import 'package:heartful/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PatientInfoForm extends StatelessWidget {

  final PageController pageController = PageController();
  final TextEditingController age = TextEditingController();
  final TextEditingController serumCreatinine = TextEditingController();
  final TextEditingController ejectionFraction = TextEditingController();
  final TextEditingController serumSodium = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 110,
              child: CustomText(
                text: "Patient\nInformation",
                size: 45,
                red: false,
              ),
            ),
            Positioned(
              top: 245,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                child: PageView.builder(
                  itemCount: 4,
                  controller: pageController,
                  itemBuilder: (context, index) => Column(
                    children: [
                      getCard(context, index),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 752,
              child: SmoothPageIndicator(
                controller: pageController,
                count: 4,
                effect: ScaleEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.white,
                  dotWidth: 15,
                  dotHeight: 15,
                  scale: 1.5,
                ),
                onDotClicked: (index) => pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCard(BuildContext context, int index) {
    if (index == 0) return ContentCard(
      title: CustomText(
        text: "Age (years)",
        size: 28,
        red: true,
      ),
      child: CustomTextField(age),
      button: CustomButton(
        text: "Next",
        onPress: moveNext,
      ),
    );
    if (index == 1) return ContentCard(
      title: CustomText(
        text: "Level of serum creatinine in the blood (mg/dL)",
        size: 28,
        red: true,
      ),
      child: CustomTextField(serumCreatinine),
      button: CustomButton(
        text: "Next",
        onPress: moveNext,
      ),
    );
    if (index == 2) return ContentCard(
      title: CustomText(
        text: "Percentage of blood leaving the heart at each contraction",
        size: 28,
        red: true,
      ),
      child: CustomTextField(ejectionFraction),
      button: CustomButton(
        text: "Next",
        onPress: moveNext,
      ),
    );
    if (index == 3) return ContentCard(
      title: CustomText(
        text: "Level of serum sodium in the blood (mEq/L)",
        size: 28,
        red: true,
      ),
      child: CustomTextField(serumSodium),
      button: CustomButton(
        text: "Submit",
        onPress: () => Navigator.of(context).pushReplacement(PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (context, animation1, animation2) => Results(
            age: double.parse(age.text),
            serumCreatinine: double.parse(serumCreatinine.text),
            ejectionFraction: double.parse(ejectionFraction.text),
            serumSodium: double.parse(serumSodium.text),
          ),
          transitionsBuilder: (context, animation1, animation2, child) => FadeTransition(opacity: animation1, child: child,),
        )),
      ),
    );
    return Container();
  }

  void moveNext() => pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);

}

class CustomTextField extends StatelessWidget {

  final TextEditingController controller;

  CustomTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        cursorColor: Theme.of(context).primaryColor,
        textAlign: TextAlign.center,
        controller: controller,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 28,
          fontFamily: "Raleway",
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(17),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(17),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
        ),
      ),
    );
  }

}