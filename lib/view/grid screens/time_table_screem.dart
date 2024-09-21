import 'package:education_managment/components/table_item.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatelessWidget {
  const TimeTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      TableItem(text: "from \n to", color: Colors.green,),
                      TableItem(text: "8:00",color: Colors.black),
                      TableItem(text: "9:00",color: Colors.black),
                      TableItem(text: "10:00",color: Colors.black),
                      TableItem(text: "11:00",color: Colors.black),
                      TableItem(text: "12:00",color: Colors.black),
                      TableItem(text: "1:00",color: Colors.black),
                    ],
                  ),
                  Row(
                    children: [
                      TableItem(text: "Sun",color: Colors.black),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                    ],
                  ),
                  Row(
                    children: [
                      TableItem(text: "Mon",color: Colors.black),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                    ],
                  ),
                  Row(
                    children: [
                      TableItem(text: "Tue",color: Colors.black),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                    ],
                  ),
                  Row(
                    children: [
                      TableItem(text: "Wed",color: Colors.black),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                    ],
                  ),
                  Row(
                    children: [
                      TableItem(text: "Thu",color: Colors.black),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: "sad"),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                    ],
                  ),
                  Row(
                    children: [
                      TableItem(text: "Fri",color: Colors.black),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                      TableItem(text: ""),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}