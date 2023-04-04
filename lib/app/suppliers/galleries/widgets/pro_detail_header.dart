import 'package:flutter/material.dart';

class ProDetailsHeader extends StatelessWidget {
  final String label;
  const ProDetailsHeader({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              thickness: 1,
              color: Colors.yellow.shade900,
            ),
          ),
          Text(
            '    $label    ',
            style: TextStyle(
              color: Colors.yellow.shade900,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              thickness: 1,
              color: Colors.yellow.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
