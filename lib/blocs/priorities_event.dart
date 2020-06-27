part of 'priorities_bloc.dart';

abstract class PrioritiesEvent extends Equatable {
  const PrioritiesEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class SetPrioritiesAreSetEvent extends PrioritiesEvent {
  final bool prioritiesAreSet;
  const SetPrioritiesAreSetEvent({this.prioritiesAreSet});
  @override
  List<Object> get props => [prioritiesAreSet];
}

class LoadInitialPrioritiesEvent extends PrioritiesEvent {}
