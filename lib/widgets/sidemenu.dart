import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
    width: 250,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/it_logo.jpg"),
          ),
          DrawerListTile(
            title: "Classrooms Tables",
            icon: Icons.school,
            press: () {},
          ),
          DrawerListTile(
            title: "Lecturers Tables",
            icon: Icons.assignment_ind,
            press: () {},
          ),
          DrawerListTile(
            title: "Stuednts Tables",
            icon: Icons.groups,
            press: () {},
          ),
          DrawerListTile(
            title: "Create Inputs",
            icon: Icons.edit,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: Colors.white54,
        size: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
