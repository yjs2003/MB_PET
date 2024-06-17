import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:light/light.dart';
//카메라 권한 요청
void PermissionQuest() async{
  var photoPer = await Permission.photos.request();
  var cameraPer = await Permission.camera.request();
}

Light? _light;
StreamSubscription? _subscription;

void onData(int luxValue) async {
  print("Lux value: $luxValue");
}


void startListening() {
  _light = Light();

  try {
    _subscription = _light?.lightSensorStream.listen(onData);
  } on LightException catch (exception) {
    print(exception);
  }
}

void stopListening() {
  _subscription?.cancel();
}
