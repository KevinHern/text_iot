// Basic Immports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormMessages {
  static const String MANDATORY_FIELD = 'Complete la información';
  static const String VALID_IP_ADDRESS = 'Introduce una dirección IP válida';
  static const String POSITIVE_ONLY = 'Solo números positivos';
}

class FormTile extends StatelessWidget {
  final Widget child;
  const FormTile({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      title: this.child,
    );
  }
}

class TextInputField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final bool readOnly, isSingleLine, isLastInput;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final Function(String?)? validator;
  const TextInputField(
      {required this.icon,
      required this.label,
      required this.controller,
      required this.textCapitalization,
      this.readOnly = false,
      this.isSingleLine = true,
      this.isLastInput = false,
      this.textInputType = TextInputType.none,
      this.validator,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormTile(
      child: TextFormField(
        decoration: InputDecoration(
          hintText: label,
          icon: Icon(icon),
          labelText: label,
        ),
        style: Theme.of(context).textTheme.bodyText2,
        controller: controller,
        readOnly: readOnly,
        textCapitalization: textCapitalization,
        maxLines: (isSingleLine) ? 1 : null,
        textInputAction:
            (isLastInput) ? TextInputAction.done : TextInputAction.next,
        keyboardType: textInputType,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        validator:
            (validator != null) ? (String? value) => validator!(value) : null,
      ),
    );
  }
}

class SingleLineInputField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final bool isLastInput, readOnly, isIPInput;
  final Function(String?)? validator;

  const SingleLineInputField({
    required this.icon,
    required this.label,
    required this.controller,
    this.isIPInput = false,
    this.isLastInput = false,
    this.validator,
    this.readOnly = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextInputField(
      icon: this.icon,
      label: this.label,
      controller: this.controller,
      textCapitalization: TextCapitalization.sentences,
      isLastInput: this.isLastInput,
      isSingleLine: true,
      textInputType: (isIPInput)
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      readOnly: this.readOnly,
      validator: this.validator,
    );
  }
}

class FormTitle extends StatelessWidget {
  final String title;
  const FormTitle({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: TextStyle(
        fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,
        fontSize: Theme.of(context).textTheme.headline1!.fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.black.withOpacity(0.75),
      ),
      textAlign: TextAlign.center,
    );
  }
}
