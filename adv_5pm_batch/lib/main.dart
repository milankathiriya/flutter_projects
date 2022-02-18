import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        '/': (context) => const HomePage(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime _initialDate = DateTime.now();
  TimeOfDay _initialTime = TimeOfDay.now();

  String selectedDate = "-- / -- / --";
  String selectedTime = "-- : --";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Flutter App"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("showBottomSheet"),
              onPressed: openBottomSheet,
            ),
            ElevatedButton(
              child: Text("showModalBottomSheet"),
              onPressed: openModalBottomSheet,
            ),
            Text(
              selectedDate,
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
              child: Text("showDatePicker"),
              onPressed: openDatePicker,
            ),
            Text(
              selectedTime,
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
              child: Text("showTimePicket"),
              onPressed: openTimePicker,
            ),
          ],
        ),
      ),
    );
  }

  openBottomSheet() {
    _scaffoldKey.currentState!.showBottomSheet(
      (context) => Container(
        color: Colors.blueGrey,
        height: 320,
      ),
    );
  }

  openModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Colors.blueGrey,
        height: 320,
      ),
    );
  }

  openDatePicker() async {
    DateTime? res = await showDatePicker(
        context: context,
        initialDate: _initialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDatePickerMode: DatePickerMode.day,
        helpText: "Choose a Date",
        cancelText: "DISMISS",
        confirmText: "Book Now",
        errorFormatText: "Invalid Format",
        errorInvalidText: "Invalid Input",
        fieldLabelText: "Booking Date",
        fieldHintText: "month/date/year",
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark(),
            child: child!,
          );
        },
        selectableDayPredicate: (DateTime day) {
          if (day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
              day.isBefore(DateTime.now().add(const Duration(days: 10)))) {
            return true;
          }
          return false;
        });

    setState(() {
      selectedDate = res!.day.toString() +
          " / " +
          res.month.toString() +
          " / " +
          res.year.toString();

      // selectedDate = res.toString().split(" ")[0];
    });
  }

  openTimePicker() async {
    TimeOfDay? res = await showTimePicker(
      context: context,
      initialTime: _initialTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    print(res!.period);
    print(res.periodOffset);

    String amOrpm = (res.periodOffset == 0) ? "am" : "pm";

    setState(() {
      selectedTime =
          res.hour.toString() + ":" + res.minute.toString() + " " + amOrpm;
    });
  }
}
