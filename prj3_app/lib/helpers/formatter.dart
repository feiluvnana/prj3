import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

String fileSizeFormatter(int bytes) {
  return bytes ~/ 1024 ~/ 1024 > 0
      ? "${(bytes / 1024 / 1024).toStringAsFixed(1)}MB"
      : bytes ~/ 1024 > 0
          ? "${(bytes / 1024).toStringAsFixed(1)}KB"
          : "${bytes}B";
}

IconData fileExtensionFormatter(String filename) {
  var ext = filename.split(".").last;
  return switch (ext) {
    "pdf" => FontAwesomeIcons.filePdf,
    "doc" || "docx" => FontAwesomeIcons.fileWord,
    _ => FontAwesomeIcons.fileExcel
  };
}

String dateTimeFormatter(DateTime? date) {
  if (date == null) return "Không rõ.";
  return DateFormat("dd/MM/yy HH:mm").format(date);
}

String timeFormatter(int time) {
  return "${(time ~/ 3600).toString().padLeft(2, "0")}:${(time % 3600 ~/ 60).toString().padLeft(2, "0")}";
}
