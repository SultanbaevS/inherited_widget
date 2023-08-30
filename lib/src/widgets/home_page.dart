import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: DataOwnerStatefull(),
      ),
    );
  }
}

class DataOwnerStatefull extends StatefulWidget {
  const DataOwnerStatefull({super.key});

  @override
  _DataOwnerStatefullState createState() => _DataOwnerStatefullState();
}

class _DataOwnerStatefullState extends State<DataOwnerStatefull> {
  int _value = 0;

  void _increment() {
    _value += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _increment,
            child: const Text('Жми'),
          ),
          DataProviderInherited(
            value: _value,
            child: const DataConsumerStateless(),
          ),
        ],
      ),
    );
  }
}

class DataConsumerStateless extends StatelessWidget {
  const DataConsumerStateless({super.key});

  @override
  Widget build(BuildContext context) {
    final value = DataProviderInherited.of(context).value;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$value'),
          const DataConsumerStatefull(),
        ],
      ),
    );
  }
}

class DataConsumerStatefull extends StatefulWidget {
  const DataConsumerStatefull({super.key});

  @override
  _DataConsumerStatefullState createState() => _DataConsumerStatefullState();
}

class _DataConsumerStatefullState extends State<DataConsumerStatefull> {
  @override
  Widget build(BuildContext context) {
    final value = DataProviderInherited.of(context).value;
    return Text('$value');
  }
}

class DataProviderInherited extends InheritedWidget {
  final int value;

  const DataProviderInherited({
    super.key,
    required this.value,
    required Widget child,
  }) : super(child: child);

  static DataProviderInherited of(BuildContext context) {
    final DataProviderInherited? result =
        context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
    assert(result != null, 'No DataProviderInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    return value != oldWidget.value;
  }
}

// T? getInherit<T>(BuildContext context) {
//   final element =
//       context.getElementForInheritedWidgetOfExactType<DataProviderInherited>();
//   final widget = element?.widget;
//   if (widget is T) {
//     return widget as T;
//   } else {
//     return null;
//   }
// }
