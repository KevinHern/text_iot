// Models
import 'dart:convert';

import '../models/operation_result.dart';

// Backend
import 'package:http/http.dart' as http;

class PythonServerDatasource {
  Future<OperationResult> sendText(
      {required String url, required String encodedEspText}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: encodedEspText,
      );

      if (response.statusCode == 200) {
        return OperationResult(
          success: true,
          message: "Cálculos realizados con éxito",
          returnedObject: response.body,
        );
      } else {
        return OperationResult(
            success: false,
            returnedObject: jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return OperationResult(
          success: false,
          returnedObject:
              "Ocurrió un error al pedir los cálculos: ${error.toString()}");
    }
  }
}
