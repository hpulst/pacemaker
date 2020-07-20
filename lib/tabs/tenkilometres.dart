import 'dart:convert';

import 'package:Pacemaker/data/json_strings_marathon.dart';
import 'package:flutter/material.dart';

class TenKilometresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic parsedJSON = jsonDecode(JsonMarathon.marathon330);

    return ListView();
  }
}
