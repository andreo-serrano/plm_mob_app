import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../model/login_model.dart';
import '../../model/progressHUD.dart';
import 'guest_screen.dart';
import '../home/home_guest.dart';
import '../home/home_screen.dart';
import '../../services/api_service.dart';
import '../../widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';


class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final storage = new FlutterSecureStorage();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  late LoginRequestModel requestModel;
  bool isApiCallProcess = false;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel(username: "", password: "");
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetUp(context),
      inAsyncCall: isApiCallProcess,
    );
  }

  @override
  Widget _uiSetUp(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF006699),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: screenHeight - 200,
              child: Align(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/plmseal.png'),
                    Text("Welcome to", style: TextStyle(fontSize: 22.0, color: Colors.white)),
                    SizedBox(height: 5.0),
                    Text("PLM Student Portal", style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 10.0),
                    Text("The PLM Mobile is the official mobile application of Pamantasan ng Lungsod ng Maynila. "
                        "It is designed to provide easy access to important information for students, faculty, "
                        "staff, and visitors.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonFill(
                          buttonText: "Login",
                          bgColor: Colors.amber,
                          onPressed: () {
                            // Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Form(
                                      key: globalFormKey,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text('Welcome PLMAyer!',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFA31920)),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text('Login to continue!',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFA5A5A5)),
                                            ),
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.text,
                                            onSaved: (value) =>
                                            {value = value ?? '', requestModel.username = value},
                                            validator: (value) =>
                                            (value == null || value.isEmpty) // EMPTY INPUT
                                                ? 'Please enter student number'
                                                : null,
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Enter your Student Number',
                                            ),
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.text,
                                            onSaved: (value) =>
                                            {value = value ?? 'a', requestModel.password = value},
                                            validator: (value) =>
                                            (value == null || value.isEmpty) // EMPTY INPUT
                                                ? 'Please enter your password'
                                                : null,
                                            obscureText: hidePassword,
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Enter your password',
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                  onPressed: () {
                                                    launch("mailto:ithelp@plm.edu.ph?subject=Forgot Password&body=Please include your name, student number, contact number, and reason. For more inquiries, you can contact your chairperson for urgent response");
                                                  },
                                                  child: Text(
                                                    'Forgot Password?',
                                                    style: TextStyle(color: Colors.grey),
                                                  ))
                                          ),
                                          ButtonFill(
                                            buttonText: "Login",
                                            bgColor: Colors.amber,
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              if (validateAndSave()) {
                                                setState(() {
                                                  isApiCallProcess = true;
                                                });
                                                APIService apiService = new APIService();
                                                apiService
                                                    .login(requestModel, requestModel.username, requestModel.password)
                                                    .then((value) {
                                                    setState(() {
                                                      isApiCallProcess = false;
                                                    });

                                                    if (value.access_token.isNotEmpty) {
                                                      if (value.role == 'student') {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => HomePage(userId: requestModel.username, userRole: value.role)));
                                                      }
                                                    }
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                  // LoginBottomSheet(requestModel: requestModel);
                              },
                            );
                          },
                        ),
                        ButtonOutline(
                            buttonText: "Skip",
                            onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => AfterWelcomeGuest())),
                            color: Colors.white,
                        ),
                      ],
                    )
            ))
          ],
        ),
      ),
    );
  }
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

