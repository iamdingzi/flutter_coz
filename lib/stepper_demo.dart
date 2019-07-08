import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyState();
}

class MyState extends State<MyStatefulWidget> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Row(
          children: <Widget>[
            RaisedButton(
              onPressed: onStepContinue,
              child: Text(
                "CONTINUE",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
            ),
            RaisedButton(
              onPressed: onStepCancel,
              child: Text(
                "CANCEL",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            )
          ],
        );
      },
      steps: getStep(),
      currentStep: _currentStep,
      onStepContinue: () {
        setState(() {
          if (_currentStep != 2) {
            _currentStep++;
          }
        });
      },
      onStepCancel: () {
        setState(() {
          if (_currentStep != 0) {
            _currentStep--;
          }
        });
      },
    );
  }

  List<Step> getStep() {
    List<Step> items = [];
    items.add(Step(
        title: Text("A"),
        subtitle: Text('a is first step'),
        isActive: _currentStep == 0,
        content: SizedBox(
          child: ListTile(
            title: Text('complete your  admintion'),
          ),
        )));
    items.add(Step(
        title: Text('B'),
        isActive: _currentStep == 1,
        content: SizedBox(
          width: 100,
          height: 100,
        )));
    items.add(Step(
      title: Text('C'),
      content: SizedBox(width: 100, height: 100),
      isActive: _currentStep == 2,
    ));
    return items;
  }
}
