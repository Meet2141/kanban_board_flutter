import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:seed_flutter/main.dart';

void main() {
  dotenv.load(fileName: '.env.test').then((value) => mainDelegate());
}
