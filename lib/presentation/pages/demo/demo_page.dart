import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: const Center(
        child: TextField(),
      ),
    );
  }
}
