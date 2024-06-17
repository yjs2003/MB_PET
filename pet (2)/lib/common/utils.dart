import 'package:flutter/material.dart';

String formatDateTime(String dateTimeString) {
  // 주어진 문자열을 DateTime 객체로 변환
  DateTime dateTime = DateTime.parse(dateTimeString);

  // DateTime 객체의 연도, 월, 일, 시간, 분 가져오기
  String year = dateTime.year.toString();
  String month = dateTime.month.toString().padLeft(2, '0'); // 두 자리로 맞추기 위해 padLeft 사용
  String day = dateTime.day.toString().padLeft(2, '0'); // 두 자리로 맞추기 위해 padLeft 사용
  String hour = dateTime.hour.toString().padLeft(2, '0'); // 두 자리로 맞추기 위해 padLeft 사용
  String minute = dateTime.minute.toString().padLeft(2, '0'); // 두 자리로 맞추기 위해 padLeft 사용

  // 원하는 형식으로 문자열 구성
  String formattedDate = '$year/$month/$day $hour:$minute';

  return formattedDate;
}
