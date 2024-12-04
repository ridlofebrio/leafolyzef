import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/article/article_event.dart';
import 'package:leafolyze/blocs/article/article_state.dart';
import 'package:leafolyze/models/article.dart';
import 'package:leafolyze/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository _repository;
  List<Article> _allArticles = [];

  ArticleBloc(this._repository) : super(ArticleInitial()) {
    on<LoadArticles>(_onLoadArticles);
    on<SearchArticles>(_onSearchArticles);
  }

  Future<void> _onLoadArticles(
    LoadArticles event,
    Emitter<ArticleState> emit,
  ) async {
    emit(ArticleLoading());
    try {
      _allArticles = await _repository.getArticles();
      emit(ArticleLoaded(_allArticles));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }

  Future<void> _onSearchArticles(
    SearchArticles event,
    Emitter<ArticleState> emit,
  ) async {
    if (_allArticles.isNotEmpty) {
      final filteredArticles = _allArticles
          .where((article) =>
              article.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(ArticleLoaded(filteredArticles));
    } else {
      emit(ArticleLoaded([])); // Jika tidak ada artikel
    }
  }
}
