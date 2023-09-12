import 'package:flutter/material.dart';

import 'content_expansion_tile.dart';
class CustomExpansionTile extends StatefulWidget {
   const CustomExpansionTile({super.key, required this.title, required this.count, required this.child});
  final String title ;
  final String count;
  final Widget child ;
  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
   bool _customExpandedTile = false ;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:  ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(

        title:  Text(widget.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(widget.count),
            IconButton(
              onPressed: () {},
              icon: Icon(_customExpandedTile
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_up),
              color: _customExpandedTile
                  ? Colors.blue
                  : Colors.grey.shade400,
            ),
          ],
        ),
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25)),
            child: widget.child),
        ],
        onExpansionChanged: (value) {
          setState(() {
            _customExpandedTile = value;
          });
        },
      ),
    );
  }
}

