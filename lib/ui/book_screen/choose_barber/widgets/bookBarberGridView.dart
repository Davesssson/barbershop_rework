

import 'package:flutter/material.dart';

import '../../../../models/barber/barber_model.dart';
import '../../../../models/barbershop/barbershop_model.dart';
import 'book_barber_tile.dart';

class bookBarberGridView extends StatelessWidget {
  const bookBarberGridView({
    Key? key,
    required this.barbershop,
    required this.barbers,
  }) : super(key: key);

  final Barbershop barbershop;
  final List<Barber> barbers;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      crossAxisCount: (MediaQuery.of(context).size.width / 200).toInt(),
      children: [
        ...barbers.map((existingBarber) {
          return bookBarberTile(existingBarber: existingBarber,barbershop: barbershop,);
        }).toList(),
      ],
    );
  }
}