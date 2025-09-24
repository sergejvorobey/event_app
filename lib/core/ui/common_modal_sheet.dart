import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CommonModalSheetScreen extends StatefulWidget {
  final Widget child;
  final double heightFactor;

  const CommonModalSheetScreen({
    super.key,
    required this.child,
    this.heightFactor = 0.86,
  });

  @override
  State<CommonModalSheetScreen> createState() => _CommonModalSheetScreenState();
}

class _CommonModalSheetScreenState extends State<CommonModalSheetScreen> { 
@override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return CupertinoPopupSurface(
        isSurfacePainted: true,
        child: SizedBox(
          height: height * widget.heightFactor,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Scaffold(
              backgroundColor: AppColors.background,
              body: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_buildDragHandle(), Expanded(child: widget.child)],
                ),
              ),
            ),
          ),
        ),
    );
  }

  Widget _buildDragHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Center(
        child: Container(
          width: 36,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}