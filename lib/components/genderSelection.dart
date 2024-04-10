import 'package:flutter/material.dart';

class GenderSelection extends StatefulWidget {
  final String initialGender = 'male'; // default value
  final ValueChanged<String> onChanged = (value) {}; // default empty function

  GenderSelection({
    String? initialGender,
    ValueChanged<String>? onChanged,
  }) {
    if (initialGender != null) {
      initialGender = initialGender;
    }
    if (onChanged != null) {
      onChanged = onChanged;
    }
  }

  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 44,),
            Expanded(
              child: Text(
                "GENDER",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Container(
          width: 320,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: Text('M'),
                  value: 'male',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                      widget.onChanged(_selectedGender!);
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: Text('F'),
                  value: 'female',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                      widget.onChanged(_selectedGender!);
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: Text('O'),
                  value: 'other',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                      widget.onChanged(_selectedGender!);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}