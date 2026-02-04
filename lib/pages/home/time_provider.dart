import 'dart:async' as timer;
import 'package:flutter/material.dart';

class TimeProvider with ChangeNotifier {
  DateTime _currentDate = DateTime.now();
  DateTime cafeteriaCloseTime = DateTime.now().add(const Duration(minutes: 5));

  TimeProvider() {
    timer.Timer.periodic(const Duration(minutes: 5), (timer) {
      _updateCurrentDate();
      getClickableHours();
    });

    _updateCurrentDate();
  }

  void _updateCurrentDate() {
    _currentDate = DateTime.now();
    notifyListeners();
  }

  void updateCafeteriaCloseTime(DateTime closeTime) {
    cafeteriaCloseTime = closeTime;
    //notifyListeners();
  }

  List<String> getClickableHours() {

    //print("Obteniendo horas clickables");
    int differenceInMinutes = cafeteriaCloseTime.difference(_currentDate).inMinutes;

    List<String> clickableHours = [];
    int currentHour =  0;
    String hourSuffix="minutos";
    bool isGreaterThanHour = false;

    while(differenceInMinutes>60){
      if(!isGreaterThanHour){
        isGreaterThanHour = true;
      }
      if(currentHour<10){
        clickableHours.add("0$currentHour:05 $hourSuffix");
        clickableHours.add("0$currentHour:10 $hourSuffix");
        clickableHours.add("0$currentHour:15 $hourSuffix");
        clickableHours.add("0$currentHour:30 $hourSuffix");
        clickableHours.add("0$currentHour:45 $hourSuffix");
        clickableHours.add("0${currentHour+1}:00 $hourSuffix");
      }
      else{
        clickableHours.add("$currentHour:05 $hourSuffix");
        clickableHours.add("$currentHour:10 $hourSuffix");
        clickableHours.add("$currentHour:15 $hourSuffix");
        clickableHours.add("$currentHour:30 $hourSuffix");
        clickableHours.add("$currentHour:45 $hourSuffix");
        clickableHours.add("${currentHour+1}:00 $hourSuffix");
      }
      currentHour ++;
      //print(differenceInMinutes);
      differenceInMinutes-=60;
      hourSuffix="hrs";
    }

    if(isGreaterThanHour){
      hourSuffix="hrs";
    }
    else{
      hourSuffix="minutos";
    }
    if(differenceInMinutes<=60){

      if(differenceInMinutes>=05){
        if(currentHour<10){
          clickableHours.add("0$currentHour:05 $hourSuffix");
        }else{
          clickableHours.add("$currentHour:05 $hourSuffix");
        }
      }
      if(differenceInMinutes>=10){
        if(currentHour<10){
          clickableHours.add("0$currentHour:10 $hourSuffix");
        }else{
          clickableHours.add("$currentHour:10 $hourSuffix");
        }
      }

      if(differenceInMinutes>=15 ){
        if(currentHour<10){
          clickableHours.add("0$currentHour:15 $hourSuffix");
        }else{
          clickableHours.add("$currentHour:15 $hourSuffix");
        }
      }
      if(differenceInMinutes>=30){
        if(currentHour<10){
          clickableHours.add("0$currentHour:30 $hourSuffix");
        }else{
          clickableHours.add("$currentHour:30 $hourSuffix");
        }
      }
      if(differenceInMinutes>=45 ){
        if(currentHour<10){
          clickableHours.add("0$currentHour:45 $hourSuffix");
        }else{
          clickableHours.add("$currentHour:45 $hourSuffix");
        }

      }

    }
    
    return clickableHours;
  }



  DateTime getCurrentDate() {
    return _currentDate;
  }



}