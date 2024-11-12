import 'package:feriaweb/constants/colors.dart';
import 'package:flutter/material.dart';


class CustomInputs {

  static InputDecoration loginInputDecoration({
    required String hint,
    required String label,
    IconData? icon,
    Color colorBorder = Colors.white,
  }){
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: colorBorder)
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorBorder)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColor.buttons)
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon( icon, color: Colors.grey ),
      labelStyle: TextStyle( color: Colors.grey ),
      hintStyle: TextStyle( color: Colors.grey ),
    );
  }


  static InputDecoration createUser({
    required String hint,
    required String label,
    Color colorBorder = Colors.white,
  }){
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: colorBorder)
      ),
      enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: colorBorder)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: CustomColor.buttons)
      ),
      hintText: hint,
      labelText: label,
      labelStyle: TextStyle( color: Colors.grey ),
      hintStyle: TextStyle( color: Colors.grey ),
    );
  }

  static InputDecoration dropDownItem({
    required String hint,
    required String label,
    Color colorBorder = Colors.white,
  }){
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorBorder)
      ),
      enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorBorder)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: CustomColor.buttons)
      ),
      hintText: hint,
      labelText: label,
      labelStyle: TextStyle( color: Colors.grey ),
      hintStyle: TextStyle( color: Colors.grey ),
    );
  }


    static InputDecoration searchBar({
    required String hint,
    required String label,
    required IconData icon,
    Color colorBorder = Colors.white,
  }){
    return InputDecoration(
      prefixIcon: Icon( icon, color: Colors.grey ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorBorder)
      ),
      enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorBorder)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: CustomColor.buttons)
      ),
      hintText: hint,
      labelText: label,
      labelStyle: TextStyle( color: Colors.grey ),
      hintStyle: TextStyle( color: Colors.grey ),
    );
  }


}