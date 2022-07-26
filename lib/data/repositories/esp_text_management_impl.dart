// Basic Imports
import 'dart:convert';

// Repositories
import '../../domian/repositories/esp_text_management_contract.dart';

// Models
import 'package:text_iot/data/models/esp_text.dart';
import 'package:text_iot/data/models/operation_result.dart';

class ESPTextManagementImpl implements ESPTextManagementContract {
  @override
  ESPText createModel({required String espIP, required String text}) =>
      ESPText(espIP: espIP, text: text);

  @override
  String toJson({required ESPText espText}) => jsonEncode(espText.toMap());

  @override
  OperationResult unpackMessage({required String encodedJson}) {
    // Deserialize Json
    final decodedJson = jsonDecode(encodedJson);

    // Extract Message
    try {
      return OperationResult(
          success: true, returnedObject: decodedJson['message']);
    } catch (error) {
      return OperationResult(
        success: false,
        message:
            "Un error ocurrió durante la deserialización del JSON. Un JSON Object llegó de la siguiente forma:\n${error.toString()}",
      );
    }
  }
}
