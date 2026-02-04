import 'package:flutter/material.dart';

class RoundedTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onEditPressed;

  RoundedTextField({
    required this.label,
    required this.controller,
    required this.onEditPressed,
  });

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 44,
            ),
            Expanded(
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isEditing)
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    isEditing = false;
                  });
                  widget.onEditPressed();
                },
              )
            else
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() async {
                    if (widget.label == 'DOB') {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        widget.controller.text = picked
                            .toString()
                            .split(' ')[0]; // Only the date without the time
                      }
                    } 
                    else {
                      setState(() {
                      isEditing = true;
                      }
                     );
                    }
                  });
                },
              ),
          ],
        ),
        Container(
          width: 320,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: widget.controller,
              enabled: isEditing,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 16, bottom: 16),
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
