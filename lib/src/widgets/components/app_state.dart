import 'package:flutter/material.dart';

class AppState {
  final List<String> productsList;
  final Set<String> itemsInCart;

  AppState({
    required this.productsList,
    this.itemsInCart = const <String>{},
  });

  AppState copyWith({
    List<String>? productsList,
    Set<String>? itemsInCart,
  }) {
    return AppState(
      productsList: productsList ?? this.productsList,
      itemsInCart: itemsInCart ?? this.itemsInCart,
    );
  }
}

class AppStateScope extends InheritedWidget {
  final AppState data;

  const AppStateScope(
    this.data, {
    super.key,
    required Widget child,
  }) : super(child: child);

  static AppState of(BuildContext context) {
    final AppStateScope? result =
        context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(result != null, 'No AppStateScope found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
    return data != oldWidget.data;
  }
}
