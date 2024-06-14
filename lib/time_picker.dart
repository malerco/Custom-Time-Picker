import 'package:flutter/material.dart';

class TimePickerScreen extends StatefulWidget {
  @override
  _TimePickerScreenState createState() => _TimePickerScreenState();
}

class _TimePickerScreenState extends State<TimePickerScreen> {
  int selectedHour = DateTime.now().hour;
  int selectedMinute = DateTime.now().minute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Time Picker")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hour picker
            _buildPicker(
              itemCount: 24,
              initialItem: selectedHour,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedHour = index;
                });
              },
            ),
            SizedBox(width: 20),
            // Minute picker
            _buildPicker(
              itemCount: 60,
              initialItem: selectedMinute,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedMinute = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPicker({
    required int itemCount,
    required int initialItem,
    required ValueChanged<int> onSelectedItemChanged,
  }) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 100,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListWheelScrollView.useDelegate(
          controller: FixedExtentScrollController(initialItem: initialItem),
          physics: FixedExtentScrollPhysics(),
          itemExtent: 60,
          onSelectedItemChanged: onSelectedItemChanged,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              bool isSelected = index == initialItem;
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: isSelected ? 80 : 60,
                alignment: Alignment.center,
                decoration: isSelected
                    ? BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 5),
                    ),
                  ],
                )
                    : null,
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: isSelected ? 24 : 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              );
            },
            childCount: itemCount,
          ),
        ),
      ),
    );
  }
}