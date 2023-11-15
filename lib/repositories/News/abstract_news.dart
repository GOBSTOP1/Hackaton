import 'package:hackaton2/repositories/News/models/models.dart';

abstract class AbstractNewsRepository{
  Future<List<News>> loadNews();
}