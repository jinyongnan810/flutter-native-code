import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _batteryLevel;
  Future<void> _getBatteryLevel() async {
    const platform = MethodChannel('samples.flutter.io/battery');
    try {
      final batteryLevel = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = batteryLevel;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Native Code'),
        ),
        body: Center(
          child: Text('Battery Level ${_batteryLevel ?? "not accessable"}'),
        ));
  }
}
