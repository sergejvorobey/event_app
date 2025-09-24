import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employer_profile_event.dart';
part 'employer_profile_state.dart';

class EmployerProfileBloc
    extends Bloc<EmployerProfileEvent, EmployerProfileState> {
  EmployerProfileBloc() : super(EmployerProfileInitial()) {
    on<LoadEmployerProfile>(_onLoadEmployerProfile);
    on<UpdateCompanyName>(_onUpdateCompanyName);
    on<UpdateCompanyDescription>(_onUpdateCompanyDescription);
    on<UpdateCompanyWebsite>(_onUpdateCompanyWebsite);
    on<UpdateCompanyPhone>(_onUpdateCompanyPhone);
    on<UpdateCompanyEmail>(_onUpdateCompanyEmail);
    on<UpdateCompanyAddress>(_onUpdateCompanyAddress);
    on<SaveEmployerProfile>(_onSaveEmployerProfile);
  }

  Future<void> _onLoadEmployerProfile(
    LoadEmployerProfile event,
    Emitter<EmployerProfileState> emit,
  ) async {
    try {
      emit(EmployerProfileLoading());

      // TODO: Загрузить данные из API или локального хранилища
      await Future.delayed(const Duration(seconds: 1));

      emit(
        EmployerProfileLoaded(
          companyName: 'Название компании',
          companyDescription: 'Описание компании',
          companyWebsite: 'https://company.com',
          companyPhone: '+7 (999) 123-45-67',
          companyEmail: 'info@company.com',
          companyAddress: 'Москва, ул. Примерная, д. 1',
          isVerified: false,
        ),
      );
    } catch (e) {
      emit(EmployerProfileError('Не удалось загрузить профиль: $e'));
    }
  }

  void _onUpdateCompanyName(
    UpdateCompanyName event,
    Emitter<EmployerProfileState> emit,
  ) {
    if (state is EmployerProfileLoaded) {
      final currentState = state as EmployerProfileLoaded;
      emit(currentState.copyWith(companyName: event.companyName));
    }
  }

  void _onUpdateCompanyDescription(
    UpdateCompanyDescription event,
    Emitter<EmployerProfileState> emit,
  ) {
    if (state is EmployerProfileLoaded) {
      final currentState = state as EmployerProfileLoaded;
      emit(currentState.copyWith(companyDescription: event.description));
    }
  }

  void _onUpdateCompanyWebsite(
    UpdateCompanyWebsite event,
    Emitter<EmployerProfileState> emit,
  ) {
    if (state is EmployerProfileLoaded) {
      final currentState = state as EmployerProfileLoaded;
      emit(currentState.copyWith(companyWebsite: event.website));
    }
  }

  void _onUpdateCompanyPhone(
    UpdateCompanyPhone event,
    Emitter<EmployerProfileState> emit,
  ) {
    if (state is EmployerProfileLoaded) {
      final currentState = state as EmployerProfileLoaded;
      emit(currentState.copyWith(companyPhone: event.phone));
    }
  }

  void _onUpdateCompanyEmail(
    UpdateCompanyEmail event,
    Emitter<EmployerProfileState> emit,
  ) {
    if (state is EmployerProfileLoaded) {
      final currentState = state as EmployerProfileLoaded;
      emit(currentState.copyWith(companyEmail: event.email));
    }
  }

  void _onUpdateCompanyAddress(
    UpdateCompanyAddress event,
    Emitter<EmployerProfileState> emit,
  ) {
    if (state is EmployerProfileLoaded) {
      final currentState = state as EmployerProfileLoaded;
      emit(currentState.copyWith(companyAddress: event.address));
    }
  }

  Future<void> _onSaveEmployerProfile(
    SaveEmployerProfile event,
    Emitter<EmployerProfileState> emit,
  ) async {
    try {
      if (state is EmployerProfileLoaded) {
        final currentState = state as EmployerProfileLoaded;
        emit(EmployerProfileSaving());

        // TODO: Сохранить данные в API
        await Future.delayed(const Duration(seconds: 1));

        emit(EmployerProfileSaved('Профиль успешно сохранен!'));

        // Возвращаемся к загруженному состоянию
        emit(currentState);
      }
    } catch (e) {
      emit(EmployerProfileError('Не удалось сохранить профиль: $e'));
    }
  }
}

