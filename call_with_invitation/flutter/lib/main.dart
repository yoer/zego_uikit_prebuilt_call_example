import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:zego_uikit/zego_uikit.dart';

import 'navigation_service.dart';

void main() {
  NavigationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var localUserID = math.Random().nextInt(10000).toString();
  TextEditingController inviteeUserIDTextCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    ZegoUIKitPrebuiltCallInvitationService.instance.init(
      appID: 355964969,
      appSecret: '8ab7a8831f337e25e3685ae48c13ad8a',
      appSign:
          'd5e65d6c62f272eafdb8a69ed21db1e151365d6fb4a0ab880d11ad2a5f768e15',
      userID: localUserID,
      userName: "user_$localUserID",
      configQuery: (ZegoCallInvitationData data) {
        return ZegoUIKitPrebuiltCallConfig();
      },
      contextQuery: () {
        return locator<NavigationService>().navigatorKey.currentContext!;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    ZegoUIKitPrebuiltCallInvitationService.instance.uninit();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your User ID: $localUserID'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  inviteeUserIDInput(),
                  const SizedBox(width: 5),
                  callButton(false),
                  const SizedBox(width: 5),
                  callButton(true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inviteeUserIDInput() => SizedBox(
        width: 200,
        child: TextFormField(
          controller: inviteeUserIDTextCtrl,
          decoration: const InputDecoration(
            isDense: true,
            hintText: "Please Enter Invitee User ID",
            labelText: "Invitee User ID",
          ),
        ),
      );

  Widget callButton(bool isVideoCall) =>
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: inviteeUserIDTextCtrl,
        builder: (context, inviteeUserID, _) {
          return ZegoStartCallCallInvitation(
            isVideoCall: isVideoCall,
            invitees: [
              ZegoUIKitUser(
                id: inviteeUserIDTextCtrl.text,
                name: 'user_${inviteeUserIDTextCtrl.text}',
              )
            ],
            iconSize: const Size(30, 30),
            buttonSize: const Size(40, 40),
          );
        },
      );
}
