import 'package:flutter/material.dart';
import 'settings.dart';

class ActionButton extends StatelessWidget {
  final Function onClickedFunction;
  final Icon buttonIcon;
  final LastButtonPressed nextAction;

  ActionButton(this.onClickedFunction, this.buttonIcon, this.nextAction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () {
          onClickedFunction(nextAction);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.all(16),
        ),
        child: buttonIcon,
      ),
    );
  }
}
