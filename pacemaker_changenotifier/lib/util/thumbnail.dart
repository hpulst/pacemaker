import 'package:flutter/material.dart';

Color buildColor(String intensity) {
  switch (intensity) {
    case '':
      return Colors.primaries[12];
      break;
    case 'SL':
      return Colors.primaries[11];
      break;
    case 'LD':
      return Colors.primaries[10];
      break;
    case 'MD':
      return Colors.primaries[9];
      break;
    case 'SD':
      return Colors.primaries[1];
      break;
    case 'TD':
      return Colors.primaries[0];
      break;
    case 'SWL':
      return Colors.primaries[3];
      break;
    default:
      return Colors.primaries[17];
  }
}
