import 'package:flutter/material.dart';

import '../../../../../models/barbershop/barbershop_model.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.bs,
  }) : super(key: key);

  final Barbershop bs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          //color: Colors.red,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(bs.main_image!))),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent])),
        ),
        Positioned(
            left: 10,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bs.name!,
                  style: const TextStyle(fontSize: 30, color: Colors.white70),
                ),
              ],
            )),
      ],
    );
  }
}