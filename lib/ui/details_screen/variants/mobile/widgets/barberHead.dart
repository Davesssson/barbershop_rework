import 'package:flutter/material.dart';

import '../../../../../models/barber/barber_model.dart';

class BarberHead extends StatelessWidget {
  const BarberHead({
    Key? key,
    required this.barber,
  }) : super(key: key);

  final Barber barber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;
          print("width = " + width.toString() + "height = " + height.toString());
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //       builder: (_)=>StoryViewer(barber: barber)
          //   ),);
        },
        child: Container(
          color:Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.height/20, //Magic number, kb ez ad 40 es értéket, szélességtől nem függ
                backgroundImage: NetworkImage(barber.prof_pic!),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  barber.name!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}