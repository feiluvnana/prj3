import 'package:flutter/material.dart';

InputDecoration flnInputDecoration(ThemeData themeData) => InputDecoration(
    fillColor: themeData.colorScheme.onInverseSurface,
    filled: true,
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: themeData.primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(8)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: themeData.colorScheme.error, width: 1.5),
        borderRadius: BorderRadius.circular(8)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: themeData.colorScheme.error),
        borderRadius: BorderRadius.circular(8)));
