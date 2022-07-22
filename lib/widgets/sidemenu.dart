
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/navigation_state.dart';

// class SideMenu extends StatefulWidget {
//   const SideMenu({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<SideMenu> createState() => _SideMenuState();
// }

// class _SideMenuState extends State<SideMenu> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<NavigationScreenState>(context);
//     return Drawer(
//       width: 250,
//       child: ListView(
//         children: [
//           // DrawerHeader(
//           //   child: Image.asset("assets/images/it_logo.jpg"),
//           // ),
//           DrawerListTile(
//             title: "Classrooms Tables",
//             icon: Icons.school,
//             press: () {
//               // provider.jumpToNewScreen(1);
//               context.read<NavigationScreenState>().jumpToNewScreen(0);
//             },
//           ),
//           DrawerListTile(
//             title: "Lecturers Tables",
//             icon: Icons.assignment_ind,
//             press: () {
//               provider.jumpToNewScreen(1);
//             },
//           ),
//           DrawerListTile(
//             title: "Stuednts Tables",
//             icon: Icons.groups,
//             press: () {},
//           ),
//           DrawerListTile(
//             title: "Create Inputs",
//             icon: Icons.edit,
//             press: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DrawerListTile extends StatelessWidget {
//   const DrawerListTile({
//     Key? key,
//     // For selecting those three line once press "Command+D"
//     required this.title,
//     required this.icon,
//     required this.press,
//   }) : super(key: key);

//   final String title;
//   final IconData icon;
//   final VoidCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: press,
//       horizontalTitleGap: 0.0,
//       leading: Icon(
//         icon,
//         color: Colors.white54,
//         size: 16,
//       ),
//       title: Text(
//         title,
//         style: TextStyle(color: Colors.white54),
//       ),
//     );
//   }
// }
