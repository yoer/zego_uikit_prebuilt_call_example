import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:zego_uikit/prebuilts/call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.call),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ZegoUIKitPrebuiltCall(
              appID: yourAppID,
              appSign: yourAppSign,
              userID: math.Random().nextInt(10000).toString(),
              userName: "Jerry",
              callID: yourCallID,
              config: ZegoUIKitPrebuiltCallConfig(turnOnCameraWhenJoining: true),
            );
          }),
        ),
      ),
    );
  }
}