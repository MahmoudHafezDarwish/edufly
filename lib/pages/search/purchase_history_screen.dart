import 'history_items_list.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PurchaseHistoryScreen extends StatelessWidget {
  // HttpService httpService = new HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Purchase History')),
      backgroundColor: Color(0xFFF1F3F8),
      body: HistoryItemsList(),
    );
  }
}
