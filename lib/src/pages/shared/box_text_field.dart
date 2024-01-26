// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class BoxTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSenha;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;

  const BoxTextField({
    Key? key,
    required this.icon,
    required this.label,
    this.isSenha = false,
    this.inputFormatters,
    this.initialValue,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<BoxTextField> createState() => _BoxTextFieldState();
}

class _BoxTextFieldState extends State<BoxTextField> {
  bool isObscure = false;

  @override
  void initState() {
    isObscure = widget.isSenha;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        autocorrect: false,
        obscureText: isObscure,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 14, left: 14),
            child: Icon(
              widget.icon,
              size: 24,
            ),
          ),
          suffixIcon: widget.isSenha
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  })
              : null,
          label: Text(widget.label),
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}