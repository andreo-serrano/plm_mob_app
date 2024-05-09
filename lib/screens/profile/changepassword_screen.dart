import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/button.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  Future<bool>  exitConfirm() async  {
    return await showDialog(
      barrierDismissible : false,
      useRootNavigator: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text('Cancel Change Password'),
          content: Text('Are you sure you want to cancel? Changes might not be saved!'),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: ButtonFill(
                    buttonText: 'Continue',
                    onPressed: () => Navigator.pop(context),
                    bgColor: Colors.grey.shade200,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ButtonFill(
                      buttonText: 'Exit',
                      onPressed: () { Navigator.of(context).pop(true); },
                      bgColor: error,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: exitConfirm,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // leading: BackButton(
          //     color: Colors.black,
          //     onPressed: () {Navigator.pop(context);}),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation:0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Change Password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA31920)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,20,0,20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text('Don’t forget your password. In order to protect your account, make sure your password:'),
                    ),
                    Text('\u2022 Must be at least 8-20 characters long only'),
                    Text('\u2022 A mixture of both uppercase and lowercase letters'),
                    Text('\u2022 A mixture of letters and numbers'),
                    Text('\u2022 Does not match or significantly contain your username,\n e.g. do not use “username123”'),
                  ],
                ),
              ),
              Form(child:
              Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter current password';
                      }
                      return null;
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Current Password',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter new password';
                      }
                      return null;
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'New Password',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password did not match';
                      }
                      return null;
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ],
              ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonFill(
                        buttonText: 'Update Password',
                        onPressed:  () {},
                    ),
                    ButtonFill(
                      buttonText: 'Cancel',
                      onPressed:  () { Navigator.of(context).pop(true); },
                      bgColor: Colors.grey.shade200,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
