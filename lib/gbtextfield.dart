import 'package:flutter/material.dart';
import 'package:flutterassignment/address/extension.dart';

class GigaBankTextField extends StatefulWidget {
  final TextEditingController ctlr;
  final Function(String) onChanged;
  final String title;
  final bool? hasSearcableValue;
  final bool? hasSuffix;
  final List<String>? searchedValue;
  final Function(String)? onSelected;

  const GigaBankTextField({
    super.key,
    required this.ctlr,
    required this.onChanged,
    required this.title,
    this.hasSearcableValue = false,
    this.searchedValue,
    this.onSelected,
    this.hasSuffix = false,
  });

  @override
  State<GigaBankTextField> createState() => _GigaBankTextFieldState();
}

class _GigaBankTextFieldState extends State<GigaBankTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.ctlr,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [],
          validator: (v) =>
              v!.fieldvalidation(field: widget.title, value: widget.ctlr.text),
          onChanged: (value) => {
            widget.onChanged(value),
          },
          decoration: InputDecoration(
            labelText: widget.title,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            contentPadding: const EdgeInsets.only(
              top: 14.0,
              bottom: 12.0,
              left: 5.0,
              right: 14.0,
            ),

            // fillColor: Colors.white70,
            suffixIcon: widget.hasSuffix! ? const Icon(Icons.search) : null,
            hintText: widget.title,
            hintStyle: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        widget.ctlr.text.isNotEmpty & widget.hasSearcableValue!
            ? Container(
                height: 130,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0;
                          i < widget.searchedValue!.length;
                          i++) ...[
                        widget.searchedValue!.isEmpty
                            ? SizedBox()
                            : ListTile(
                                visualDensity:
                                    const VisualDensity(vertical: -3),
                                onTap: () {
                                  widget.onSelected!(widget.searchedValue![i]);
                                },
                                title: Text(
                                  widget.searchedValue![i],
                                ),
                              ),
                      ],
                    ],
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
