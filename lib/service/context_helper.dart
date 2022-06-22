import 'package:flutter/material.dart';

class ContextHelper {
  MediaQueryData getMediaQuery(BuildContext context) => MediaQuery.of(context);

  ScaffoldMessengerState getScaffoldMessenger(BuildContext context) =>
      ScaffoldMessenger.of(context);
}
