import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:seed_flutter/main.dart';

void main() {
  dotenv.load(fileName: '.env.stage').then((value) => mainDelegate());
}
