// Models
import 'operation_result.dart';

class ESPText extends Equatable {
  final String espIP;
  final String text;

  ESPText({
    required this.espIP,
    required this.text,
  });

  Map<String, dynamic> toMap() => {
        "espIPs": espIP,
        "text": text,
      };

  @override
  List<Object?> get props => [
        espIP,
        text,
      ];
}

class Equatable {}
