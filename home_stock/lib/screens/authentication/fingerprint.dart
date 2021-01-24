

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:home_stock/screens/home/home.dart';

class FingerPrint extends StatefulWidget {

  @override
  _FingerPrintState createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {

  LocalAuthentication _auth = LocalAuthentication();
  bool _checkBio= false;
  bool _isBioFinger= false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
    _listBioAndFingerType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('Authorize owner'),
      ),
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.fingerprint,
                size: 50,
              ),
              onPressed: _startAuth,
              iconSize: 60,
            ),
            SizedBox(height: 15),
            Text('Authorize to enter private photo'),
          ],
        ),
      ),

    );
  }


  void _checkBiometrics() async {
    try {
      final bio= await _auth.canCheckBiometrics;
      setState(() {
        _checkBio= bio;
      });
      print( 'Biometrics= $_checkBio');
    } catch (e) {}

  } //end method

  void _listBioAndFingerType () async {
    List<BiometricType> _listType;
    try {
      _listType = await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e.message);
    }
    print ('List Biometrics = $_listType');

    if (_listType.contains(BiometricType.fingerprint)) {
      setState(() {
        _isBioFinger = true;
      });
    } //end if
    print('Fingerprint is $_isBioFinger');
  } //end void



  void _startAuth() async {
    bool _isAuthenticated= false;
    AndroidAuthMessages _msg= AndroidAuthMessages(
      signInTitle: 'Sign in to enter',
      cancelButton: 'Cancel',
    );
    try {
      _isAuthenticated= await  _auth.authenticateWithBiometrics(
        localizedReason: 'Scan your fingerprint',
        useErrorDialogs: true,
        stickyAuth: true,// native process
        androidAuthStrings: _msg,
      );
    } on PlatformException catch (e) {
      print(e.message);
    }

    if (_isAuthenticated) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => Home()));
    }

  }// end void
}
