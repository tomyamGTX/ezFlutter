import 'package:flutter/material.dart';

buttonStyle() {
  return ElevatedButton.styleFrom(
    elevation: 2,
    minimumSize: const Size(200, 40),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  );
}
