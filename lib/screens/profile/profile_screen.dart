import 'package:flutter/material.dart';
import 'package:plmmobileapp_v2/screens/home/home_guest.dart';
import '../../model/request.dart';
import 'account_info_screen.dart';
import 'changepassword_screen.dart';
import '../../services/api_service.dart';
import '../../widgets/button.dart';

// Test hd
import 'package:url_launcher/url_launcher.dart';

// end Test
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  String firstName = '';
  String lastName = '';
  String userId = '';

  void initState() {
    super.initState();
    fetchInformation();
  }

  void fetchInformation() async {
    APIService apiService = new APIService();
    apiService.user().then((value) async => {
          await UserSecureStorage.setFirstName(value.firstname),
          await UserSecureStorage.setLastName(value.lastname),
        });
    firstName = await UserSecureStorage.getFirstName() ?? '';
    lastName = await UserSecureStorage.getLastName() ?? '';
    userId = await UserSecureStorage.getUserId() ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.account_circle)),
        automaticallyImplyLeading: false,
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                      image: AssetImage('assets/images/profile-default.jpg')),
                ),
              ),
              const SizedBox(height: 10),
              Text('${firstName} ${lastName}',
                  style: Theme.of(context).textTheme.headlineMedium),
              Text('${userId}', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 20),
              // ButtonFill(buttonText: 'Edit Profile'),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: 'Account Information',
                icon: Icons.account_circle,
                bgColor: Colors.amber.withOpacity(0.15),
                iconColor: Colors.amber,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccountInformation()));
                },
                endIcon: true,
              ),
              ProfileMenuWidget(
                title: 'Change Password',
                icon: Icons.key,
                bgColor: Colors.blue.withOpacity(0.15),
                iconColor: Colors.blue,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                },
                endIcon: true,
              ),
              ProfileMenuWidget(
                title: 'Logout',
                icon: Icons.logout_rounded,
                bgColor: Colors.red.withOpacity(0.15),
                iconColor: Colors.red,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeGuestPage()));
                },
                endIcon: true,

              // ProfileMenuWidget(
              //   title: 'Health Declaration',
              //   icon: Icons.medical_information_rounded,
              //   bgColor: Colors.red.withOpacity(0.15),
              //   iconColor: Colors.red,
              //   onPress: () {
              //     const url =
              //         'https://web4.plm.edu.ph/StudentHealthDeclaration/';
              //     launch(url.toString());
              //   },
              //   endIcon: true,
              ),
              // ProfileMenuWidget(
              //   title: 'Privacy and Security',
              //   icon: Icons.lock_open,
              //   bgColor: Colors.red.withOpacity(0.15),
              //   iconColor: Colors.red,
              //   onPress: () {},
              //   endIcon: true,
              // ),
              // ProfileMenuWidget(
              //   title: 'Notifications',
              //   icon: Icons.notifications_none,
              //   onPress: () {
              //   },
              //   endIcon: true,
              // ),
              // SizedBox(
              //   width: 200,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: Text('Edit Profile', style: Theme.of(context).textTheme.bodyLarge),
              //     style: ,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.bgColor,
    this.iconColor,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? bgColor;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color:
                bgColor != null ? bgColor : Colors.tealAccent.withOpacity(0.1)),
        child: Icon(
          icon,
          size: 18.0,
          color: iconColor != null ? iconColor : Colors.grey,
        ),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.tealAccent.withOpacity(0.1)),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 18.0,
                color: Colors.grey,
              ))
          : null,
    );
  }
}
