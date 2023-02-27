import 'package:flutter/material.dart';
import 'package:task_byte/model/button.dart';

class IconButtonWidget extends StatefulWidget {
  final Button button;
  const IconButtonWidget({required this.button, super.key});

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            widget.button.icon,
            height: 22,
            width: 22,
            color: Colors.black,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            widget.button.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontStyle: FontStyle.normal,
            ),
          )
        ],
      ),
    );
  }
}
