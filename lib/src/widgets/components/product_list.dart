import 'package:flutter/material.dart';
import 'app_state.dart';
import 'app_state_widget.dart';
import 'server.dart';

import '../../model/product_model.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  void _handleToCart(String id, BuildContext context) {
    AppStateWidget.of(context).addToCart(id);
  }

  void _handleRemoveFromCart(String id, BuildContext context) {
    AppStateWidget.of(context).removeFromCart(id);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> productList = AppStateScope.of(context).productsList;
    return Column(
      children: productList
          .map((id) => ProductTile(
                product: Server.getProductById(id),
                purchased: AppStateScope.of(context).itemsInCart.contains(id),
                onAddToCart: () => _handleToCart(id, context),
                onRemoveFromCart: () => _handleRemoveFromCart(id, context),
              ))
          .toList(),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  final bool purchased;
  final VoidCallback onAddToCart;
  final VoidCallback onRemoveFromCart;

  const ProductTile({
    required this.product,
    required this.purchased,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color getButtonColor(Set<MaterialState> states) {
      return purchased ? Colors.grey : Colors.black;
    }

    BorderSide getButtonSide(Set<MaterialState> states) {
      return BorderSide(
        color: purchased ? Colors.grey : Colors.black,
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 15,
      ),
      color: const Color(0xFFF8F8F8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(product.title),
          ),
          Text.rich(
            product.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: OutlinedButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith(getButtonColor),
                side: MaterialStateProperty.resolveWith(getButtonSide),
              ),
              onPressed: purchased ? onRemoveFromCart : onAddToCart,
              child: purchased
                  ? const Text('Remove from cart')
                  : const Text('Add to cart'),
            ),
          ),
          Image.network(product.pictureURL),
        ],
      ),
    );
  }
}
