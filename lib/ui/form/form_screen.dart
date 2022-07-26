// Basic Imports
import 'package:flutter/material.dart';
import 'package:text_iot/data/repositories/esp_text_management_impl.dart';
import 'package:text_iot/domian/repositories/esp_text_management_contract.dart';
import 'package:text_iot/domian/use_cases/esp_text_management_use_cases.dart';
import '../../data/models/operation_result.dart';
import '../components/form_inputs.dart';

// Datasource
import '../../data/datasources/python_server.dart';

// Mixins
import '../mixins/form_mixin.dart';

class ESPTextFormScreen extends StatefulWidget {
  final ESPTextUseCases _learningCurveUseCases;
  ESPTextFormScreen({required ESPTextManagementImpl repository, Key? key})
      : _learningCurveUseCases = ESPTextUseCases(
          repository: repository,
          datasource: PythonServerDatasource(),
        ),
        super(key: key);

  @override
  ESPTextFormScreenState createState() => ESPTextFormScreenState();
}

class ESPTextFormScreenState extends State<ESPTextFormScreen> with FormMixin {
  static const double spacing = 8.0;
  final regex = RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController pythonIPController = TextEditingController(),
      espIPController = TextEditingController(),
      textToSendController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spacing * 2.5),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const FormTitle(
                title: "Innovation Lab\nText Over IoT",
              ),
              const SizedBox(
                height: spacing,
              ),
              SingleLineInputField(
                icon: Icons.link,
                label: "Python IP Address",
                controller: pythonIPController,
                validator: (String? value) {
                  if (value == null) {
                    return null;
                  } else {
                    if (value.trim().isEmpty) {
                      return FormMessages.MANDATORY_FIELD;
                    } else if (!regex.hasMatch(value)) {
                      return FormMessages.VALID_IP_ADDRESS;
                    } else {
                      return null;
                    }
                  }
                },
              ),
              const SizedBox(
                height: spacing,
              ),
              SingleLineInputField(
                icon: Icons.link,
                label: "ESP IP Address",
                controller: espIPController,
                validator: (String? value) {
                  if (value == null) {
                    return null;
                  } else {
                    if (value.trim().isEmpty) {
                      return FormMessages.MANDATORY_FIELD;
                    } else if (!regex.hasMatch(value)) {
                      return FormMessages.VALID_IP_ADDRESS;
                    } else {
                      return null;
                    }
                  }
                },
              ),
              const SizedBox(
                height: spacing,
              ),
              SingleLineInputField(
                icon: Icons.text_fields,
                label: "Text to Send",
                controller: textToSendController,
                validator: (String? value) {
                  return (value == null)
                      ? null
                      : (value.trim().isEmpty)
                          ? FormMessages.MANDATORY_FIELD
                          : null;
                },
              ),
              const SizedBox(
                height: spacing * 2.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text("Reset"),
                    onPressed: () {
                      pythonIPController.text = "";
                      espIPController.text = "";
                      textToSendController.text = "";
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text("Enviar"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Preparing Data
                        String pythonIP = pythonIPController.text.trim();
                        String espIP = espIPController.text.trim();
                        String textToSend = textToSendController.text.trim();

                        execute(
                          context: context,
                          useCasesFunction: Future<OperationResult>(
                            () =>
                                widget._learningCurveUseCases.displayTextOnESP(
                              pythonServerIP: pythonIP,
                              espIP: espIP,
                              textToSend: textToSend,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
