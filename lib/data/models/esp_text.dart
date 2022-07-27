// Models
import 'operation_result.dart';

class ESPText {
  final String espIP;
  final String text;

  ESPText({
    required this.espIP,
    required this.text,
  });

  Map<String, dynamic> toMap() => {
        "espIP": espIP,
        "text": text,
      };
}
