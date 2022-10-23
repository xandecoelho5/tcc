part of 'filter_bloc.dart';

abstract class FilterEvent {
  const FilterEvent(this.filter);

  final Filter filter;
}

class FilterApplyEvent extends FilterEvent {
  const FilterApplyEvent(Filter filter) : super(filter);
}
