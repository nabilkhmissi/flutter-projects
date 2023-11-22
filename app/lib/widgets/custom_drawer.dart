import 'package:app/screens/login_screen.dart';
import 'package:app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService auth_service = GetIt.I<AuthService>();

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.teal[400],
              height: 100,
              child: Center(
                child: Text(
                  "ToDoDay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Home'),
                      ),
                      ListTile(
                        leading: Icon(Icons.menu),
                        title: Text('Todos'),
                      ),
                    ],
                  ),
                  ListTile(
                    onTap: () => {
                      auth_service.logout(),
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      ),
                    },
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
