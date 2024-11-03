import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final bool? obscurer;
  final bool? autoFocus;
  final bool? enableInput;
  final EdgeInsets? inputPadding;
  final EdgeInsets margin;
  final bool? isPasswordInput;
  final String placeHolder;
  final String? initialValue;
  final TextStyle? textStyle;
  final TextStyle? errorStyle;
  final String? errorText;
  final String? label;
  final TextEditingController? inputController;
  final TextInputType inputType;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Color? fillColor;

  final InputBorder? inputBorder;
  final BoxConstraints? constraints;
  final Function(String) onChangedFunction;
  final Function(String) onSubmittedFunction;
  final Function()? suffixIconFunction;

  const CustomTextFormField(
      {Key? key,
      this.focusNode,
      this.initialValue,
      this.constraints,
      this.margin =
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      required this.placeHolder,
      required this.onChangedFunction,
      required this.onSubmittedFunction,
      required this.inputType,
      this.inputPadding,
      this.label,
      this.textStyle,
      this.inputController,
      this.errorStyle,
      this.enableInput,
      this.errorText,
      this.inputBorder,
      this.autoFocus,
      this.isPasswordInput,
      this.obscurer,
      this.suffixIcon,
      this.fillColor,
      this.suffixIconFunction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        constraints: constraints,
        child: TextFormField(
          maxLines: 1,
          initialValue: initialValue,
          keyboardType: inputType,
          onFieldSubmitted: onSubmittedFunction,
          onChanged: onChangedFunction,
          autofocus: autoFocus ?? false,
          obscureText: obscurer ?? false,
          focusNode: focusNode,
          decoration: InputDecoration(
              label: label != null ? Text(label ?? "") : null,
              errorText: errorText,
              errorStyle: errorStyle,
              contentPadding: inputPadding ??
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              focusColor: Colors.grey,
              hintText: placeHolder,
              fillColor: fillColor ?? Colors.transparent,
              filled: (fillColor != null) ? true : false,
              focusedBorder: inputBorder ??
                  OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
              border: inputBorder ??
                  OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
              enabledBorder: inputBorder ??
                  OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
              suffixIcon: (isPasswordInput ?? false)
                  ? IconButton(
                      icon: suffixIcon ?? const Icon(Icons.remove_red_eye),
                      onPressed: suffixIconFunction ?? () {})
                  : null),
          controller: inputController,
          enabled: (enableInput != null) ? enableInput : true,
          style: textStyle ?? GoogleFonts.sourceSansPro(),
        ));
  }
}
