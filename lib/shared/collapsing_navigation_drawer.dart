import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetabling/screens/main_view.dart';

import '../models/navigaton_model.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildWidget(context, widget);
  }

  Widget buildWidget(context, widget) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text('Godwin Asuquo'),
                trailing: Icon(CupertinoIcons.person),
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 60,
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 20,
                      color: Colors.transparent,
                    );
                  },
                  itemBuilder: (context, counter) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentIndex = counter;
                        });
                      },
                      child: Icon(navigationItems[counter].icon),
                    );
                  },
                  itemCount: navigationItems.length,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                },
                child: Icon(
                  Icons.menu,
                  color: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600)
                      .color,
                  size: 30.0,
                ),
              ),
              SizedBox(height: 40.0),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: BuildPages(currentIndex),
          ),
        )
      ],
    );
  }
}

class BuildPages extends StatelessWidget {
  final int index;

  BuildPages(this.index);
  final pages = [
    Table(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent, body: pages[index]);
  }
}
