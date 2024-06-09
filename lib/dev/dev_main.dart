import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kanban_flutter/main.dart';

void main() {
  dotenv.load(fileName: '.env.dev').then((value) => mainDelegate());
}
