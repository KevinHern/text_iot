// Models
import 'package:text_iot/data/datasources/python_server.dart';

import '../../data/models/operation_result.dart';
import 'package:text_iot/data/models/esp_text.dart';

// Repositories
import 'package:text_iot/data/repositories/esp_text_management_impl.dart';
import 'package:text_iot/domian/repositories/esp_text_management_contract.dart';

class ESPTextUseCases {
  final ESPTextManagementContract _repository;
  final PythonServerDatasource _datasource;
  final int portNumber = 44321;

  ESPTextUseCases(
      {required ESPTextManagementImpl repository,
      required PythonServerDatasource datasource})
      : _repository = repository,
        _datasource = datasource;

  Future<OperationResult> displayTextOnESP({
    required String pythonServerIP,
    required String espIP,
    required String textToSend,
  }) async {
    // Creating Model
    final ESPText espText =
        _repository.createModel(espIP: espIP, text: textToSend);

    final OperationResult backendResult = await _datasource.sendText(
      url: "http://$pythonServerIP:$portNumber/text",
      encodedEspText: _repository.toJson(espText: espText),
    );

    // Checking result
    if (backendResult.success) {
      // Everything went smooth, proceed to decode JSON and make Graph Model
      final OperationResult mapResult = _repository.unpackMessage(
          encodedJson: backendResult.returnedObject! as String);

      if (mapResult.success) {
        return OperationResult(
          success: true,
          message: mapResult.returnedObject as String,
        );
      } else {
        return mapResult;
      }
    } else {
      return OperationResult(
        success: false,
        message: backendResult.returnedObject as String,
      );
    }
  }
}
