import 'package:flutter/material.dart';
import 'package:withlaravel/provider/bottomnavbar.dart';
import 'package:withlaravel/screens/datadisplay.dart';
import 'package:provider/provider.dart';
import 'package:withlaravel/screens/formscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final varBottomNavProvider = Provider.of<BottomNavProvider>(
      context,
      listen: false,
    );

    List<Widget> widgetList = const [
      FormScreen(),
      UserData(),
    ];

    return Scaffold(
      body: Consumer<BottomNavProvider>(
        builder: (context, value, child) {
          return IndexedStack(
            index: varBottomNavProvider.currentPageIndex,
            children: widgetList,
          );
        },
      ),
      bottomNavigationBar: Consumer<BottomNavProvider>(
        builder: (context, value, child) {
          return NavigationBar(
            onDestinationSelected: (int index) {
              varBottomNavProvider.setCurrentIndex(index);
            },
            indicatorColor: Theme.of(context).primaryColor,
            selectedIndex: varBottomNavProvider.currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(
                  Icons.library_books,
                ),
                label: "Fill Form",
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.supervised_user_circle_sharp,
                ),
                label: "Users",
              ),
            ],
          );
        },
      ),
    );
  }
}
