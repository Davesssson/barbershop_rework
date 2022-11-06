import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../admin_edit_barber_screen/edit_barber_view.dart';

class addNewBarberTile extends StatelessWidget {
  const addNewBarberTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return editView( barberUnderEdit: null,);
            }
        ));
      },
      child: DottedBorder(
        color: Colors.white,
        strokeWidth: 2,
        dashPattern: [5, 5],
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            color: Colors.transparent,
            child: Column(
              children: [
                Text("add new"),
                Icon(Icons.add)
              ],
            ),
          ),
        ),
      ),
    );
  }
}