import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    // return PopScope(
    //   canPop: false,
    //   child: _content()
    // );
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: const Text('Главный экран'),
        leading: SizedBox(),
        border: null,
        backgroundColor: AppColors.background,
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return SafeArea(
      child: Column(
        children: [
          // const CupertinoNavigationBar(
          //   middle: Text('Главный экран'),
          //   leading: SizedBox(),
          //   backgroundColor: AppColors.background,
          //   border: null,
          // ),
          const Expanded(child: Center(child: Text('Добро пожаловать!'))),
          
        ],
      ),
    );
  }
}
