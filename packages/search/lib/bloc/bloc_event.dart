
abstract class BlocEvent {}
class SearchBlocEvent extends BlocEvent{
  final String text;

  SearchBlocEvent({required this.text});
}
