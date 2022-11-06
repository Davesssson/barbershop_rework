import 'package:flutter/material.dart';
import '../../../../models/barber/barber_model.dart';
import '../../admin_edit_barber_screen/edit_barber_view.dart';

class BarberTile extends StatelessWidget {
  const BarberTile({
    required this.existingBarber,
    Key? key,
  }) : super(key: key);
  final Barber existingBarber;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return editView( barberUnderEdit: existingBarber, );
            }
        ));
      },
      child: Container(
        height: 50,
        width: 50,
        color: Colors.black,
        child: Text(existingBarber.name!),
      ),
    );
  }
}