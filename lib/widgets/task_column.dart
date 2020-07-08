import 'package:flutter/material.dart';

class TaskColumn extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final Function onTap;
  TaskColumn(
      {this.icon,
      this.iconBackgroundColor,
      this.title,
      this.subtitle,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 30.0,
            backgroundColor: iconBackgroundColor,
            child: Icon(
              icon,
              size: 30.0,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ],
          )
        ],
      ),
    );
  }
}
