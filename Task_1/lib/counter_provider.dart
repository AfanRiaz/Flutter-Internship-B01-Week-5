import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier{
  int _count = 0;
  var _themeMode= ThemeMode.light;
  ThemeMode get themeMode{
    return _themeMode;
}
void toggleTheme(themeMode){
    _themeMode=themeMode;
    notifyListeners();
}
  int get count{
    return _count;
  }
  void setCount(){
    _count++;
    notifyListeners();
  }
  void increment(){
    _count++;
    notifyListeners();
  }
  void decrement(){
    _count--;
    notifyListeners();
  }
}