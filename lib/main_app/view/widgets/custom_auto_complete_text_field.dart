import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
export 'package:flutter_typeahead/flutter_typeahead.dart';


class CustomAutoCompleteTextField<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final EdgeInsetsGeometry contentPadding;
  final Widget prefix;
  final ValueChanged<T> onChanged;
  final bool isRequired;
  final TextEditingController controller;
  final int maxLength;
  final SuggestionSelectionCallback<T> onSuggestionSelected;
  final ItemBuilder<T> itemBuilder;
  final SuggestionsCallback<T> suggestionsCallback;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final WidgetBuilder noItemsFoundBuilder;
  final Key textFieldKey;
  final bool enabled;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<T> onSubmitted;

  const CustomAutoCompleteTextField({
    this.noItemsFoundBuilder,
    this.controller,
    this.isRequired = false,
    this.textInputAction,
    this.maxLength,
    this.validator,
    this.textFieldKey,
    this.prefix,
    this.onSaved,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.onSubmitted,
    this.focusNode,
    this.enabled = true,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    @required this.onSuggestionSelected,
    @required this.itemBuilder,
    @required this.suggestionsCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text("  ${labelText ?? ""}",
                style: TextStyle(fontWeight: FontWeight.bold)),
            if (isRequired)
              Text(
                " *",
                style: TextStyle(color: Colors.red),
              )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(color: Color(0xff000000).withOpacity(0.2), blurRadius: 7),
              BoxShadow(color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 7),
            ]
          ),
          child: TypeAheadFormField<T>(
            key: textFieldKey,
            textFieldConfiguration: TextFieldConfiguration(
                textInputAction:textInputAction,
                controller: controller,
                onSubmitted: onSubmitted ?? this.onSubmitted,
                enabled: enabled,
                focusNode: focusNode,
                decoration: InputDecoration(
                  enabled: enabled,
                  hintText: hintText,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                )),
            itemBuilder: itemBuilder,
            onSuggestionSelected: onSuggestionSelected,
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            suggestionsCallback: suggestionsCallback,
            validator: validator,
            noItemsFoundBuilder: noItemsFoundBuilder ??
                (context) {
                  return SizedBox();
                },
          ),
        ),
      ],
    );
  }
}
