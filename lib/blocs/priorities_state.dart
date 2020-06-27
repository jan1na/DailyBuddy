part of 'priorities_bloc.dart';

class PrioritiesState extends Equatable {
  final bool prioritiesAreSet;
  const PrioritiesState({this.prioritiesAreSet});

  @override
  List<Object> get props => [prioritiesAreSet];

  @override
  bool get stringify => true;
}

class PrioritiesInitial extends PrioritiesState {
  PrioritiesInitial() : super(prioritiesAreSet: false);
}
