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
      child: Material(
        child: InkWell(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //       builder: (_)=>StoryViewer(barber: barber)
            //   ),);
          },
          child: Container(
            //color: Colors.black54,
            color:Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
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
      ),
    );
  }
}