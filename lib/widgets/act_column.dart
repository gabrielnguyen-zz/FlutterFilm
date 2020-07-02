import 'package:flutter/material.dart';

class ActColumn extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;
  final IconData icon;
  ActColumn(
      {
      this.title,
      this.subtitle,
      this.onTap,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 10.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45),
                ),
              ],
            ),
          ),
          Spacer(),
          Icon(icon),
        ],
      ),
    );
  }
}
