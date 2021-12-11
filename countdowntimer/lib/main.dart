import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CountdownController countdownController = CountdownController(
      duration: Duration(seconds: 200, minutes: 1),
      onEnd: () {
        print('onEnd');
      });
  bool isRunning = false;
  int counter = 0;
  bool _buttonPressed = false;

  String timerText(int hour, int min, int sec) {
    String hourStr = '00';
    String minStr = '00';
    String secStr = '00';
    if (hour < 10) {
      hourStr = '0' + hour.toString();
    } else {
      hourStr = hour.toString();
    }
    if (min < 10) {
      minStr = '0' + min.toString();
    } else {
      minStr = min.toString();
    }
    if (sec < 10) {
      secStr = '0' + sec.toString();
    } else {
      secStr = sec.toString();
    }
    return hourStr + ':' + minStr + ':' + secStr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Countdown(
                countdownController: countdownController,
                builder: (_, Duration time) {
                  return Text(
                    timerText(
                        time.inHours, time.inMinutes % 60, time.inSeconds % 60),
                    style: TextStyle(fontSize: 20),
                  );
                }),
            Text('Counter: ' + counter.toString()),
            Listener(
              onPointerDown: (details) {
                _buttonPressed = true;
              },
              onPointerUp: (details) {
                _buttonPressed = false;
              },
              child: TextButton(
                  onPressed: () {},
                  onLongPress: () async {
                    while (_buttonPressed) {
                      counter++;
                      setState(() {});
                      await Future.delayed(Duration(seconds: 1));
                    }
                  },
                  child: Icon(Icons.stop_circle)),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isRunning ? Icons.stop : Icons.play_arrow),
        onPressed: () {
          if (!countdownController.isRunning) {
            countdownController.start();
            setState(() {
              isRunning = true;
            });
          } else {
            countdownController.stop();
            setState(
              () {
                isRunning = false;
              },
            );
          }
        },
      ),
    );
  }
}
