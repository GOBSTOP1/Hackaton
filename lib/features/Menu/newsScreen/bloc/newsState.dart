part of 'newsBloc.dart';


class NewsState{}

class NewsInitial extends NewsState{}

class NewsLoading extends NewsState{}

class NewsLoaded extends NewsState{
  final List<News> newsList;

  NewsLoaded({required this.newsList});
}

class NewsLoadingFailure extends NewsState{}