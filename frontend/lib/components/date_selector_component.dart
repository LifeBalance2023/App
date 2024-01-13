import 'package:flutter/material.dart';
import 'package:frontend/components/form_textfield.dart';
import 'package:intl/intl.dart';

class DateSelectorComponent extends StatefulWidget {
  final String label;
  final DateTime initialDate;
  final Function(DateTime) onDateChanged;
  final String dateFormatPattern;

  const DateSelectorComponent({
    Key? key,
    required this.label,
    required this.initialDate,
    required this.onDateChanged,
    this.dateFormatPattern = 'yyyy-MM-dd',
  }) : super(key: key);

  @override
  _DateSelectorComponentState createState() => _DateSelectorComponentState();
}

class _DateSelectorComponentState extends State<DateSelectorComponent> {
  late TextEditingController _dateTextController;

  @override
  void initState() {
    super.initState();
    _dateTextController = TextEditingController(text: _formatDate(widget.initialDate));
  }

  @override
  void dispose() {
    _dateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormTextfieldComponent(
      controller: _dateTextController,
      fieldName: widget.label,
      hintText: 'Select Date',
      obscureText: false,
      readOnly: true,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: widget.initialDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          setState(() {
            _dateTextController.text = _formatDate(picked);
          });
          widget.onDateChanged(picked);
        }
      },
    );
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat(widget.dateFormatPattern);
    return formatter.format(date);
  }
}
