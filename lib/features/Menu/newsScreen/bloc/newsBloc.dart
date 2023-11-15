import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackaton2/repositories/News/abstract_news.dart';
import 'package:hackaton2/repositories/News/models/models.dart';

part 'newsEvent.dart';
part 'newsState.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc(this.newsRepository) : super(NewsInitial()) {
    on<LoadNewsEvent>((event, emit) async {
      final newsList = await newsRepository.loadNews();
      emit(NewsLoaded(newsList: newsList));
    });
  }
  final AbstractNewsRepository newsRepository;
}