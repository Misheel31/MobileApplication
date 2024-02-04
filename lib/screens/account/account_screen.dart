import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocerystore/screens/auth/Login.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/global_ui_viewmodel.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late GlobalUIViewModel _ui;
  User? _loggedInUser;
  Color lightBackgroundColor = Colors.blueGrey;

  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _loggedInUser = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/images/logo.jpg",
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 10,
            ),
            _loggedInUser != null
                ? Container(
              // color: Colors.deepPurple,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Email:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  // Text(''
                  //     'Username:'),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Text(
                    _loggedInUser!.email!,
                    style: TextStyle(fontSize: 20),
                  ),

                  // Text(
                  //   _loggedInUser!.username!,
                  //   style: TextStyle(fontSize: 20),
                  // ),
                ],
              ),
            )
                : Container(), // Handle the case when the user is not logged in
            SizedBox(
              height: 10,
            ),
            makeSettings(
              icon: Icon(Icons.logout),
              title: "Logout",
              subtitle: "Logout from this application",
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
            makeSettings(
              icon: Icon(Icons.android),
              title: "Version",
              subtitle: "0.0.1",
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget makeSettings({
    required Icon icon,
    required String title,
    required String subtitle,
    Function()? onTap,
  }) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Card(
            elevation: 4,
            color: Colors.white,
            child: ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              leading: icon,
              title: Text(
                title,
              ),
              subtitle: Text(
                subtitle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
