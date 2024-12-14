part of 'hairstyle_bloc.dart';

sealed class HairstyleEvent extends Equatable {
  const HairstyleEvent();

  @override
  List<Object> get props => [];
}

final class GetHairstyleEvent extends HairstyleEvent {
  const GetHairstyleEvent();

  @override
  List<Object> get props => [];
}

final class SaveHairstyleEvent extends HairstyleEvent {
  final int hairstyleId;
  final String buttonType;

  const SaveHairstyleEvent({
    required this.hairstyleId,
    required this.buttonType,
  });

  @override
  List<Object> get props => [hairstyleId, buttonType];
}
