import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Function onClickedFunction;

  MenuButton(this.onClickedFunction);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          onClickedFunction();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
