import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../providers/home_provider.dart';

class SwitcherWidget extends StatelessWidget {
  const SwitcherWidget({
    super.key,
    required this.homeProvider,
    required this.searchController,
  });

  final HomeProvider homeProvider;
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: homeProvider.visible == false
          ? Container(
              key: const Key('1'),
              width: double.infinity,
              height: 70,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'USERS',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        homeProvider.searchOnOff(true);
                      },
                      icon: const Icon(Icons.search),
                      iconSize: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            )
          : SizedBox(
              height: 70,
              width: double.infinity,
              key: const Key('2'),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: TextField(
                  controller: searchController,
                  onChanged: ((value) => homeProvider.searchStudent(value)),
                  decoration: InputDecoration(
                    hintText: 'Search User',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        homeProvider.searchOnOff(false);
                        homeProvider.searchStudent('');
                      },
                      child: const Icon(
                        CupertinoIcons.xmark_circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
