import 'package:auto_route/auto_route.dart';
import 'package:event_app/features/profile/view/profile_screen.dart';
import 'package:flutter/cupertino.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return _content();
  }

  Widget _content() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        iconSize: 24,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: 'Главный',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet_below_rectangle),
            label: 'Заказы',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_fill),
            label: 'Профиль',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: Center(child: Text('Главный')),
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: Center(child: Text('Заказы')),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              // onGenerateRoute: Routers.generateRoute,
              builder: (context) {
                return CupertinoPageScaffold(child: ProfileScreen());
              },
            );
          default:
            return Spacer();
        }
      },
    );
  }
}
