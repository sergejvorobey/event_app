import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        previousPageTitle: "Назад",
        middle: const Text('О себе'),
        border: null,
        backgroundColor: AppColors.background,
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return SafeArea(child: Container());
  }
}
