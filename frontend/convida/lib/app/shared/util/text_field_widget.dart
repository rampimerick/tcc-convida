library my_prj.util.textfields;

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

textField(
    {String initialValue,
    String labelText,
    IconData icon,
    onChanged,
    int maxLength,
    String Function() errorText}) {
  return TextFormField(
    initialValue: initialValue,
    onChanged: onChanged,
    maxLength: maxLength,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
      alignLabelWithHint: true,
      labelText: labelText,
      errorText: errorText == null ? null : errorText(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      //icon: Icon(icon),
    ),
  );
}

textFieldObscure(
    {String initialValue,
    String labelText,
    IconData icon,
    onChanged,
    int maxLength,
    String Function() errorText}) {
  return TextFormField(
    initialValue: initialValue,
    obscureText: true,
    onChanged: onChanged,
    maxLength: maxLength,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
      hintText: labelText,
      hintStyle: TextStyle(height: 1, fontSize: 12.0),
      errorText: errorText == null ? null : errorText(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
//      icon: Icon(icon),
    ),
  );
}

textFieldController(
    {String initialValue,
    TextEditingController controller,
    String labelText,
    IconData icon,
    onChanged,
    int maxLength,
    String Function() errorText}) {
  return TextFormField(
    initialValue: initialValue,
    controller: controller,
    onChanged: onChanged,
    maxLength: maxLength,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
      labelText: labelText,
      errorText: errorText == null ? null : errorText(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      icon: Icon(icon),
    ),
  );
}

textFieldLines(
    {int maxLines,
    String initialValue,
    String labelText,
    IconData icon,
    onChanged,
    int maxLength,
    String Function() errorText}) {
  return TextFormField(
    maxLines: maxLines,
    // RZR
    textInputAction: TextInputAction.newline,
    //expands: true,
    initialValue: initialValue,
    onChanged: onChanged,
    maxLength: maxLength,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
      labelText: labelText,
      alignLabelWithHint: true,
      errorText: errorText == null ? null : errorText(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      //icon: Icon(icon),
    ),
  );
}

textFieldInitialValue(
    {String initialValue,
    String labelText,
    IconData icon,
    onChanged,
    int maxLength,
    String Function() errorText,
    String initalValue}) {
  return TextFormField(
    initialValue: initialValue,
    onChanged: onChanged,
    maxLength: maxLength,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
      labelText: labelText,
      errorText: errorText == null ? null : errorText(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      //icon: Icon(icon),
    ),
  );
}

textFieldLogin(
    {String initialValue,
    String labelText,
    onChanged,
    int maxLength,
    String Function() errorText,
    bool obscureText}) {
  return TextFormField(
    initialValue: initialValue,
    onChanged: onChanged,
    maxLength: maxLength,
    obscureText: obscureText,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
      hintText: labelText,
      errorText: errorText == null ? null : errorText(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    ),
  );
}

textFieldMask(
    {String initialValue,
    MaskTextInputFormatter maskFormatter,
    TextInputType keyboardType,
    String labelText,
    IconData icon,
    onChanged,
    int maxLength,
    String Function() errorText}) {
  return TextFormField(
    initialValue: initialValue,
    inputFormatters: [maskFormatter],
    keyboardType: keyboardType,
    onChanged: onChanged,
    maxLength: maxLength,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
      labelText: labelText,
      errorText: errorText == null ? null : errorText(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      //icon: Icon(icon),
    ),
  );
}

textFieldKeyboard(
    {String initialValue,
    TextInputType keyboardType,
    String labelText,
    IconData icon,
    onChanged,
    int maxLength,
    String Function() errorText}) {
  return TextFormField(
    initialValue: initialValue,
    keyboardType: keyboardType,
    onChanged: onChanged,
    maxLength: maxLength,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
      labelText: labelText,
      errorText: errorText == null ? null : errorText(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      icon: Icon(icon),
    ),
  );
}

textFieldWithoutIcon(
    {int maxLines,
    String initialValue,
    String labelText,
    IconData icon,
    onChanged,
    int maxLength,
    String Function() errorText}) {
  return TextFormField(
    maxLines: maxLines,
    initialValue: initialValue,
    onChanged: onChanged,
    maxLength: maxLength,
    decoration: InputDecoration(
      isDense: true,
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
      labelText: labelText,
      errorText: errorText == null ? null : errorText(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    ),
  );
}
