import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {
  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 0.2,),
              Text(
                'MORE INFORMATION',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(_expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ],
          ),
          Visibility(
            visible: _expanded,
            child: Container(
              padding: EdgeInsets.only(left: 10,right:2,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DISCO,EDM,INDIE,RAP'),
                  Text('4 HR'),
                  Text('MALAYALAM,HINDI'),
                  Text('ALL AGE GROUPS')
                  // Add more Text widgets as needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
