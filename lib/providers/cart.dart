import 'package:flutter/cupertino.dart';
import 'package:wooapp/services/cart.dart';
import 'package:wooapp/services/product.dart';

class CartProvider with ChangeNotifier{
  bool cartStatus;
  CartServices _cartServices = CartServices();

  getCartStatus({String id, String quantity, String variation, String variation_id}) async{
    cartStatus = await _cartServices.getAddToCart(id:id, quantity:quantity, variation: variation, variation_id: variation_id  );
    notifyListeners();
  }
}
