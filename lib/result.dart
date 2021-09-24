import 'package:flutter/material.dart';
import 'package:heartful/widgets.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'form.dart';

const ageMean = 60.8;
const ageStd = 11.9;
const serumCreatinineMean = 1.39;
const serumCreatinineStd = 1.03;
const ejectionFractionMean = 38.1;
const ejectionFractionStd = 11.8;
const serumSodiumMean = 137;
const serumSodiumStd = 4.41;

class Results extends StatelessWidget {

  final double age;
  final double serumCreatinine;
  final double ejectionFraction;
  final double serumSodium;

  Results(
      {this.age,
      this.serumCreatinine,
      this.ejectionFraction,
      this.serumSodium});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 150,
            child: CustomText(
              text: "Results",
              size: 45,
              red: false,
            ),
          ),
          Positioned(
            top: 245,
            child: ContentCard(
              title: CustomText(
                text: "Likelihood of\nSurvival",
                size: 28,
                red: true,
              ),
              child: FutureBuilder(
                future: runModel(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) return Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: CustomText(
                      text: snapshot.data ? "LOW" : "HIGH",
                      red: true,
                      size: 60,
                    ),
                  );
                  return CircularProgressIndicator();
                },
              ),
              button: CustomButton(
                text: "Test Again",
                onPress: () => Navigator.of(context).pushReplacement(PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 200),
                  pageBuilder: (context, animation1, animation2) => PatientInfoForm(),
                  transitionsBuilder: (context, animation1, animation2, child) => FadeTransition(opacity: animation1, child: child,),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> runModel() async {
    final interpreter = await Interpreter.fromAsset('model.tflite');

    // convert form data to z-scores
    var ageNorm =
        (age - ageMean) / ageStd;
    var serumCreatinineNorm =
        (serumCreatinine - serumCreatinineMean) / serumCreatinineStd;
    var ejectionFractionNorm =
        (ejectionFraction - ejectionFractionMean) / ejectionFractionStd;
    var serumSodiumNorm =
        (serumSodium - serumSodiumMean) / serumSodiumStd;

    print("$ageNorm $serumCreatinineNorm $ejectionFractionNorm $serumSodiumNorm");

    // input tensor shape [4, 1]
    var input = [[serumCreatinineNorm], [ejectionFractionNorm], [ageNorm], [serumSodiumNorm]];

    // output tensor shape [1,1]
    var output = List(1*1).reshape([1,1]);

    // get prediction
    interpreter.runForMultipleInputs(input, {0: output});
    print(output);
    return output[0][0] > 0.55;
  }

}
