import 'package:cab_driver/widgets/round_button.dart';
import 'package:flutter/material.dart';
import '../constants/branb_colour.dart';
import '../widgets/TaxiOutlineButton.dart';

class ConfrimSheet extends StatelessWidget {

  String tittle;
  String subTittle;
  Function onPressed;
  ConfrimSheet({this.tittle,this.subTittle,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black26,
            blurRadius: .5,
            spreadRadius: .5,
            offset: Offset(.7, .7))
      ]),
      height: 210,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              tittle,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'BoltSemi',
                  color: BrandColors.colorText),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              subTittle,
              style: TextStyle(
                  fontFamily: 'BoltSemi', color: BrandColors.colorText),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: TaxiOutlineButton(
                    title: 'GO BACK',
                    color: BrandColors.colorLightGray,
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RoundButton(
                    'CONFIRM',
                    BrandColors.colorGreen,
                    onPressed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
