import 'package:flutter/material.dart';

class SidemenuProvider extends ChangeNotifier {

  static late AnimationController menuController;
  static bool isOpen = false;

  static Animation<double> movement = Tween<double>(begin: -244, end: 0).animate(
    CurvedAnimation(
      parent: menuController,
      curve: Curves.easeInOut,
    ) );

    static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: menuController,
        curve: Curves.easeInOut,
    ) );

    static void openMenu() {
      isOpen = true;
      menuController.forward();
    }

    static void closeMenu() {
      isOpen = false;
      menuController.reverse();
    }

    static void toggleMenu() {
      (isOpen) 
        ? menuController.reverse()
        : menuController.forward();

      isOpen = !isOpen;
    }
  
}