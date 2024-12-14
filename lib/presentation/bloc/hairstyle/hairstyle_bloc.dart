import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:looksy_app/data/datasources/remote_datasources/hairstyle_remote_datasources.dart';
import 'package:looksy_app/domain/entities/hairstyle.dart';

part 'hairstyle_event.dart';
part 'hairstyle_state.dart';

class HairstyleBloc extends Bloc<HairstyleEvent, HairstyleState> {
  final HairstyleRemoteDatasources hairstyleRemoteDatasource;

  final List<HairStyle> _hairstyle = [];

  List<HairStyle> get hairstyle => List.unmodifiable(_hairstyle);

  HairstyleBloc({
    required this.hairstyleRemoteDatasource,
  }) : super(HairstyleInitial()) {
    on<GetHairstyleEvent>((event, emit) async {
      emit(HairstyleLoading());

      final response = await hairstyleRemoteDatasource.getSavedHairstyles();

      response.fold(
        (l) => emit(HairstyleFailed(errorMessage: l)),
        (r) {
          _hairstyle.addAll(r);
          emit(HairstyleSuccess(hairstyle: _hairstyle, buttonType: null));
        },
      );
    });

    on<SaveHairstyleEvent>((event, emit) async {
      emit(HairstyleLoading());

      final response =
          await hairstyleRemoteDatasource.saveHairstyle(event.hairstyleId);

      response.fold(
        (l) => emit(HairstyleFailed(errorMessage: l)),
        (r) {
          _hairstyle.add(r);
          emit(HairstyleSuccess(
              hairstyle: _hairstyle, buttonType: event.buttonType));
        },
      );
    });
  }
}
