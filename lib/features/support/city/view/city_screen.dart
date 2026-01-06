import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/common_loading_indicator.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/features/support/city/bloc/city_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CityScreen extends StatefulWidget {
  final String? selectedCityTitle;

  const CityScreen({super.key, this.selectedCityTitle});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final CityBloc _cityBloc = CityBloc();

  @override
  void initState() {
    super.initState();
    _cityBloc.add(FetchCities(selectedCityTitle: widget.selectedCityTitle));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: const Text('Город'),
        leading: Text(""),
        trailing: CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Закрыть"),
        ),
        border: null,
        backgroundColor: AppColors.background,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: BlocConsumer<CityBloc, CityState>(
        bloc: _cityBloc,
        listener: (context, state) {
          // switch (state) {
          //   case EditprofileNotification(:final type, :final title, :final message):
          //     showToast(
          //       title: title,
          //       message: message,
          //       type: type,
          //     );
          //     break;
          // }
        },
        builder: (context, state) {
          switch (state) {
            case CityLoading():
              return Scaffold(body: makeCommonLoadingIndicator());
            case CityContent():
              return Scaffold(body: _makeContent(state));
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _makeContent(CityContent state) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.cities.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final city = state.cities[index];
        return GestureDetector(
          onTap: () {
            // Обновляем состояние: только один выбран
            final updatedCities =
                state.cities.map((c) {
                  return c.title == city.title
                      ? c.copyWith(isSelected: true)
                      : c.copyWith(isSelected: false);
                }).toList();

            _cityBloc.add(UpdateCities(updatedCities));
            Navigator.of(context).pop(city);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.greyLight.withAlpha(200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(city.title, style: AppTextStyles.bodyText1),
                CupertinoCheckbox(
                  activeColor: AppColors.primary,
                  value: city.isSelected,
                  onChanged: (_) {
                    final updatedCities =
                        state.cities.map((c) {
                          return c.title == city.title
                              ? c.copyWith(isSelected: true)
                              : c.copyWith(isSelected: false);
                        }).toList();
                    _cityBloc.add(UpdateCities(updatedCities));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
