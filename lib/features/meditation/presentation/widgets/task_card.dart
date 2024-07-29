import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;

  const TaskCard({Key? key, required this.title, required this.description, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          SizedBox(width: 5,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        description,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                    SizedBox(height: 3),
                    // Container(
                    //   padding: EdgeInsets.all(3),
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey[200],
                    //     borderRadius: BorderRadius.circular(50)
                    //   ),
                    //   child: Icon(Icons.arrow_forward_ios),
                    // )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
