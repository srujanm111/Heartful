import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String text;
  final double size;
  final bool red;

  CustomText({this.text, this.size, this.red});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: red ? Theme.of(context).primaryColor : Colors.white,
        fontFamily: "Raleway",
      ),
      textAlign: TextAlign.center,
    );
  }

}

class CustomButton extends StatefulWidget {

  final VoidCallback onPress;
  final String text;
  final bool inverted;

  CustomButton({this.onPress, this.text, this.inverted = false});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  bool isPressedDown = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) => setState(() => isPressedDown = true),
      onPointerUp: (event) => setState(() => isPressedDown = false),
      onPointerCancel: (event) => setState(() => isPressedDown = false),
      child: GestureDetector(
        onTap: widget.onPress,
        child: AnimatedOpacity(
          opacity: isPressedDown ? 0.6 : 1,
          duration: Duration(milliseconds: isPressedDown ? 10 : 100),
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              color: widget.inverted ? Colors.white : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: CustomText(
                text: widget.text,
                red: widget.inverted,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContentCard extends StatelessWidget {

  final CustomText title;
  final Widget child;
  final CustomButton button;

  ContentCard({this.title, this.child, this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title,
            SizedBox(height: 30),
            child,
            SizedBox(height: 20),
            button,
          ],
        ),
      ),
    );
  }
}
