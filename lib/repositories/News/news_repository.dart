
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackaton2/repositories/News/abstract_news.dart';
import 'models/models.dart';

class NewsRepository implements AbstractNewsRepository{
    @override
  Future<List<News>> loadNews() async {
  try {
    final db = FirebaseFirestore.instance;
    final response = await db.collection("news").get();
    
    List<News> newsList = response.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
       
        return News(imgUrl: data['img_url']);
      }).toList();
         for (var news in newsList ) {
        print(newsList);
      }
      return newsList;
    
  } catch (e) {
    print("Error loading menu: $e");
    // Доделать обработку ошибок(желательно)
    return [];
  }
  
}

}