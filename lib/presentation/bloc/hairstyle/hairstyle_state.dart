part of 'hairstyle_bloc.dart';

sealed class HairstyleState extends Equatable {
  const HairstyleState();

  @override
  List<Object> get props => [];
}

class HairstyleInitial extends HairstyleState {}

class HairstyleLoading extends HairstyleState {}

class HairstyleSuccess extends HairstyleState {
  final List<HairStyle> hairstyle;
  final String? buttonType;

  const HairstyleSuccess({
    required this.hairstyle,
    required this.buttonType,
  });

  @override
  List<Object> get props => [hairstyle];
}

class HairstyleFailed extends HairstyleState {
  final String errorMessage;

  const HairstyleFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
