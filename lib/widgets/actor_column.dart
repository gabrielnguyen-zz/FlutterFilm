import 'package:flutter/material.dart';

class ActorColumn extends StatelessWidget {
  final String url;
  final String title;
  final String subtitle;
  final Function onTap;
  final IconData icon;
  ActorColumn(
      {
        this.url,
      this.title,
      this.subtitle,
      this.onTap,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 10.0),
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(url),
              ),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '"' +subtitle + '"',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w200,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Icon(icon),
            ],
          ),
          SizedBox(height:10),
        ],
      ),
    );
  }
}
