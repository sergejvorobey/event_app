import 'package:auto_route/auto_route.dart';
import 'package:event_app/routers/routers.dart';
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
    return _contentV2();
  }

  Widget _contentV2() {
    return AutoTabsScaffold(
      routes: const [MainRoute(), ProfileRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return CupertinoTabBar(
          iconSize: 24,
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) => _openPage(index, tabsRouter),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill),
              label: 'Главный',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_fill),
              label: 'Профиль',
            ),
          ],
        );
      },
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}