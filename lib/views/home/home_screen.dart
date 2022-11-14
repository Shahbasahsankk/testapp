import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/views/home/widgets/animated_switcher.dart';

import '../../providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeProvider.searchStudent('');
    });
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Consumer<HomeProvider>(builder: (context, searchValue, _) {
              return SwitcherWidget(
                searchController: searchValue.searchController,
                homeProvider: searchValue,
              );
            }),
            Expanded(
              child: Consumer<HomeProvider>(
                builder: (BuildContext context, HomeProvider homeValues,
                    Widget? child) {
                  return homeValues.foundUsers.isEmpty
                      ? Center(
                          child: Text(
                            homeValues.visible == true
                                ? 'No User Found'
                                : 'No User Data',
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                background: Container(
                                  alignment: AlignmentDirectional.centerEnd,
                                  color: Colors.red,
                                  child: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                confirmDismiss:
                                    (DismissDirection dismissDirection) async {
                                  switch (dismissDirection) {
                                    case DismissDirection.endToStart:
                                      return homeValues.deleteShowDialogue(
                                        homeProvider.foundUsers[index].id,
                                        context,
                                        homeProvider,
                                      );
                                    default:
                                      return null;
                                  }
                                },
                                child: ListTile(
                                  onTap: () => homeValues.toWeatherScreen(
                                    context,
                                    homeValues.isSwitched,
                                  ),
                                  title: Row(
                                    children: [
                                      Text(homeValues
                                          .foundUsers[index].firstName),
                                      const SizedBox(width: 3),
                                      Text(homeValues
                                          .foundUsers[index].lastName),
                                    ],
                                  ),
                                  subtitle:
                                      Text(homeValues.foundUsers[index].email),
                                  leading: const CircleAvatar(
                                    radius: 30,
                                    child: Icon(Icons.person),
                                  ),
                                  trailing: Switch.adaptive(
                                    activeColor: Colors.blue,
                                    inactiveThumbColor: Colors.black,
                                    inactiveTrackColor: Colors.black54,
                                    value: homeValues.isSwitched,
                                    onChanged: (value) =>
                                        homeValues.switchOnOff(value),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: homeValues.foundUsers.length,
                          ),
                        );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => homeProvider.toAddUserScreen(context),
          child: const Icon(
            Icons.person_add,
          ),
        ),
      ),
    );
  }
}
