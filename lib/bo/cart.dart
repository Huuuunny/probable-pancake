import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  final _items = <Article>[];

  String priceTotalInCents() {
    var totalCents = _items.fold(0, (total, item) => total + (item.prix * 100).toInt());
    return "$totalCents";
  }

  List<Article> get items => _items;
  //<Article>[].fold(0 as num, (previousValue, element) => previousValue + element.prix)

  void addArticle(Article article) {
    _items.add(article);
    notifyListeners();
  }

  void removeArticle(Article article) {
    _items.remove(article);
    notifyListeners();
  }
}
