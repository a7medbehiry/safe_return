import 'package:flutter/material.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.prefixIcon,
    required this.width,
    required this.height,
    this.obscureText = false,
    this.onChanged,
    this.fillColor = const Color(0xffEEE8D8),
    this.onTap,
    this.controller,
    this.readOnly = false,
    this.keyboardType,
    this.maxLines = 1,
    this.label,
    this.onSaved,
    this.validator, this.enabled,
  });
  final String? hintText;
  final Widget? prefixIcon;
  final double width, height;
  final bool obscureText;
  final Color fillColor;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final TextEditingController? controller;
  final bool readOnly;
  final TextInputType? keyboardType;

  final int? maxLines;
  final Widget? label;
  final bool? enabled;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode _focusNode;
  bool _isPrefixIconVisible = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isPrefixIconVisible = !_focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        enabled: widget.enabled,
        validator: widget.validator,
        focusNode: _focusNode,
        cursorColor: kPrimaryColor,
        maxLines: widget.maxLines,
        onTap: widget.onTap,
        controller: widget.controller,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        style: Styles.textStyleReg16.copyWith(
          color: Colors.black,
        ),
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
          fillColor: widget.fillColor,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
          ),
          prefixIcon: _isPrefixIconVisible ? widget.prefixIcon : null,
          prefixIconColor: kPrimaryColor,
          label: widget.label,
          labelStyle: Styles.textStyleReg16.copyWith(
            color: Colors.black,
          ),
          hintText: widget.hintText,
          hintStyle: Styles.textStyleReg16.copyWith(
            color: Colors.black,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
