import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/round_button.dart';
import '../constants/branb_colour.dart';
import '../constants/globalvariables.dart';

class VehicleInfo extends StatelessWidget {
  static const Id = 'vehicleinfo';

  final GlobalKey<ScaffoldState> _scafoldKey = new GlobalKey<ScaffoldState>();
  var _modelController = TextEditingController();
  var _colourController = TextEditingController();
  var _numberController = TextEditingController();

  void updateProfile() {
    String id = currentUser.user.uid;

    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child('drivers/$id/vehicle_details');
    Map carMap = {
      'carmodel' : _modelController.text,
      'carcolour' : _colourController.text,
      'carnumber' : _numberController.text,
    };

     databaseReference.set(carMap);
  }

  void showSnackBar(String tittle) {
    final snackBar = SnackBar(
      content: Text(
        tittle,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    _scafoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 00, 30, 30),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assetes/images/logo.png',
                  height: 110,
                  width: 110,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Text(
                      'Enter Vehicle Details.',
                      style: TextStyle(
                        fontFamily: 'BoltSemi',
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _modelController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Car model',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _colourController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Car colour',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _numberController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Car number',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RoundButton(
                      'PROCEED',
                      BrandColors.colorGreen,
                      () {
                        if (_modelController.text.length < 3) {
                          showSnackBar('Please enter a valid model');
                        }
                        if (_colourController.text.length < 3) {
                          showSnackBar('Please enter a valid colour');
                        }

                        if (_numberController.text.length < 3) {
                          showSnackBar('Please enter a valid number');
                        }
                        updateProfile();
                      },
                    )


                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
