import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({super.key});

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  final TextEditingController _aboutController = TextEditingController();
  int _aboutLength = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        previousPageTitle: "Назад",
        middle: const Text('О себе'),
        border: null,
        backgroundColor: AppColors.background,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.greyLight.withAlpha(150),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _aboutController,
            maxLines: null,
            minLines: 4,
            maxLength: 250,
            keyboardType: TextInputType.multiline,
            style: AppTextStyles.bodyText1,
            decoration: const InputDecoration(
              hintStyle: AppTextStyles.textSecondary16,
              hintText:
                  "Например: Сколько времени вы уже работаете и каких результатов достигли за этот период?",
              border: InputBorder.none,
              counterText: "",
            ),
            onChanged: (text) {
              setState(() {
                _aboutLength = text.length;
              });
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$_aboutLength/250 символов',
          style: AppTextStyles.textSecondary12,
        ),
      ],
    );
  }
}
