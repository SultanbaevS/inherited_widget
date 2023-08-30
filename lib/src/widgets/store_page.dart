import 'package:flutter/material.dart';
import 'package:inherit_lesson/src/widgets/components/app_state_widget.dart';
import 'package:inherit_lesson/src/widgets/components/server.dart';

import 'components/product_list.dart';
import 'components/shopping_cart_icon.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool _inSearch = false;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  void _toggleSearch(BuildContext context) {
    setState(() {
      _inSearch = !_inSearch;
    });

    AppStateWidget.of(context).setProductList(Server.getProductList());
    _controller.clear();
  }

  void _handleSearch(BuildContext context) {
    _focusNode.unfocus();
    final String filter = _controller.text;
    AppStateWidget.of(context).setProductList(Server.getProductList(
      filter: filter,
    ));
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network('$baseAssetURL/google-logo.png'),
            ),
            title: _inSearch
                ? TextField(
                    autofocus: true,
                    focusNode: _focusNode,
                    controller: _controller,
                    onSubmitted: (_) => _handleSearch(context),
                    decoration: InputDecoration(
                        hintText: 'Search Goolgle Store',
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => _handleSearch(context),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => _toggleSearch(context),
                        )),
                  )
                : null,
            actions: [
              if (!_inSearch)
                IconButton(
                  onPressed: () => _toggleSearch(context),
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              const ShoppingCartIcon(),
            ],
            backgroundColor: Colors.white,
            pinned: true,
          ),
          const SliverToBoxAdapter(
            child: ProductListWidget(),
          )
        ],
      ),
    );
  }
}
