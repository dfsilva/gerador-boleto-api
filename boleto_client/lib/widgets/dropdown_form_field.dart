import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownController extends ValueNotifier<dynamic> {
  DropDownController(dynamic value) : super(value);
}

class DropDownFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic initialValue;
  final List? dataSource;
  final String? textField;
  final String? valueField;
  final Function? onChanged;
  final bool filled;
  final Widget? prefixIcon;
  final DropDownController? controller;
  final bool disabled;

  DropDownFormField(
      {this.controller,
      FormFieldSetter<dynamic>? onSaved,
      FormFieldValidator<dynamic>? validator,
      AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
      this.titleText = 'Title',
      this.hintText = 'Select one option',
      this.required = false,
      this.errorText = 'Please select one option',
      this.initialValue,
      this.dataSource,
      this.textField,
      this.valueField,
      this.onChanged,
      this.filled = true,
      this.prefixIcon,
      this.disabled = false})
      : assert(initialValue == null || controller == null),
        super(
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          initialValue: controller != null ? controller.value : (initialValue ?? ''),
          builder: (FormFieldState<dynamic> state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                        labelText: titleText,
                        filled: filled,
                        prefixIcon: prefixIcon),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        hint: Text(
                          hintText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        value: state.value,
                        disabledHint: Text(
                          (state != null && state.value != null)
                              ? dataSource?.firstWhere((element) => element[valueField] == state.value)[textField]
                              : hintText,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onChanged: disabled
                            ? null
                            : (dynamic newValue) {
                                state.didChange(newValue);
                                if (onChanged != null) onChanged(newValue);
                              },
                        items: dataSource?.map((item) {
                          return DropdownMenuItem<dynamic>(
                            value: item[valueField],
                            child: Text(
                              item[textField],
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: state.hasError ? 5.0 : 0.0),
                  Text(
                    state.hasError ? state.errorText! : '',
                    style: TextStyle(color: Colors.redAccent.shade700, fontSize: state.hasError ? 12.0 : 0.0),
                  ),
                ],
              ),
            );
          },
        );

  @override
  _DropDownFormFieldState createState() => _DropDownFormFieldState();
}

class _DropDownFormFieldState extends FormFieldState<dynamic> {
  DropDownController? _controller;

  DropDownController? get _effectiveController => widget.controller ?? _controller;

  @override
  DropDownFormField get widget => super.widget as DropDownFormField;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = DropDownController(widget.initialValue);
    } else {
      setValue(widget.controller?.value);
      widget.controller?.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(DropDownFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller = DropDownController(oldWidget.controller?.value);
      if (widget.controller != null) {
        setValue(widget.controller?.value);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(dynamic value) {
    super.didChange(value);
    if (_effectiveController?.value != value) _effectiveController?.value = value;
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController?.value = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController?.value != value) didChange(_effectiveController?.value);
  }
}
