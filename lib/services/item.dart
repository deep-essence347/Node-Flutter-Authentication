import 'sp/response.dart';

class ItemService {
  static addItem(String name, int price, String userId) {
    var data = {
      'name': name,
      'price': price,
    };
    return HttpServer().post(
      '/user/$userId/addItem',
      data: data,
    );
  }

  static getItems() {
    return HttpServer().get('/user/allData');
  }

  static searchItems(String queryText) {
    return HttpServer().get('/user/search', data: {'query': queryText});
  }
}
