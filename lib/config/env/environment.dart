import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String apiURL = dotenv.env['FOOD_STRUCTURED_API_URL'] ?? 'http://localhost:3000';
}