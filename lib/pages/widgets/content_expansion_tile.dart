import 'package:flutter/material.dart';

class ContentExpansionTile extends StatelessWidget {
  const ContentExpansionTile({
    super.key,
    required this.color,
    required this.title,
    required this.date,
    required this.subject,
    this.description,
    required this.tags,
   required this.photoList,
  });

  final int color;
  final String title;

  final String date;

  final String subject;

  final String? description;

  final String tags;

  final Widget photoList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 22, left: 11),
          child: Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              radius: 6,
              backgroundColor: Color(color),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        date, overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(overflow: TextOverflow.ellipsis,
                            fontSize: 10, color: Colors.grey.shade500),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey.shade500,
                        size: 22,
                      )
                    ],
                  )
                ],
              ),
              Text(
                subject,
                style: const TextStyle(fontSize: 12),
              ),
              if (description != null)
                Text(
                  description!,
                  style: const TextStyle(fontSize: 12, color: Colors.blue),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(
                height: 14,
              ),
              Text(
                tags,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue),
              ),
              const SizedBox(
                height: 14,
              ),
              photoList
            ],
          ),
        ),
      ],
    );
  }
}
