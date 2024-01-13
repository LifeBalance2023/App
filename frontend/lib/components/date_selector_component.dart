import 'package:flutter/material.dart';
import 'package:frontend/components/form_textfield.dart';
import 'package:intl/intl.dart';

class DateTimeSelectorComponent extends StatefulWidget {
  final String label;
  final DateTime initialDateTime;
  final Function(DateTime) onDateTimeChanged;
  final bool includeTime;
  final double? horizontalPadding;


  const DateTimeSelectorComponent({
    Key? key,
    required this.label,
    required this.initialDateTime,
    required this.onDateTimeChanged,
    this.includeTime = true,
    this.horizontalPadding,
  }) : super(key: key);

  @override
  _DateTimeSelectorComponentState createState() => _DateTimeSelectorComponentState();
}

class _DateTimeSelectorComponentState extends State<DateTimeSelectorComponent> {
  late TextEditingController _dateTimeTextController;
  late String _dateTimeFormatPattern;

  @override
  void initState() {
    super.initState();
    // Set the format pattern based on includeTime
    _dateTimeFormatPattern = widget.includeTime ? 'yyyy-MM-dd HH:mm' : 'yyyy-MM-dd';
    _dateTimeTextController = TextEditingController(text: _formatDateTime(widget.initialDateTime));
  }

  @override
  void dispose() {
    _dateTimeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormTextfieldComponent(
      controller: _dateTimeTextController,
      fieldName: widget.label,
      hintText: 'Select Date and Time',
      obscureText: false,
      readOnly: true,
      horizontalPadding: widget.horizontalPadding,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: widget.initialDateTime,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
        );
        if (pickedDate != null) {
          DateTime finalDateTime = pickedDate;
          if (widget.includeTime) {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(widget.initialDateTime),
            );
            if (pickedTime != null) {
              finalDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
            }
          }
          setState(() {
            _dateTimeTextController.text = _formatDateTime(finalDateTime);
          });
          widget.onDateTimeChanged(finalDateTime);
        }
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat(_dateTimeFormatPattern);
    return formatter.format(dateTime);
  }
}
