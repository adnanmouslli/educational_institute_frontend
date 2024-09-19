import 'package:flutter/material.dart';

class TableItem extends StatelessWidget {
   const TableItem({super.key, required this.text, this.color});

  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        height: 70,
        width: 100,
        decoration: BoxDecoration(
          color:color ?? Colors.grey[500],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
