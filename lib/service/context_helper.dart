import 'package:flutter/material.dart';

class ContextHelper {
  ScaffoldMessengerState getScaffoldMessenger(BuildContext context) =>
      ScaffoldMessenger.of(context);
}
