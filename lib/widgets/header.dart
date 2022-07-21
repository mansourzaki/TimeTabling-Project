import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../responsive.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.search}) : super(key: key);
  final void Function(String) search;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headline6,
        ),
        const Spacer(flex: 2),
        Expanded(
            child: SearchField(
          onChanged: search,
        )),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({Key? key, required this.onChanged}) : super(key: key);
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
