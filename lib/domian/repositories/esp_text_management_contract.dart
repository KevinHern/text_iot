// Models
import 'package:text_iot/data/models/esp_text.dart';
import '../../data/models/operation_result.dart';

abstract class ESPTextManagementContract {
  ESPText createModel({
    required String espIP,
    required String text,
  });
  String toJson({required ESPText espText});
  OperationResult unpackMessage({required String encodedJson});
}
