import 'package:division/division.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/subWidgets/build_single_order_details.dart';
import 'package:flutter/material.dart';

class WholeOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0, centerTitle: true, title: Txt(LocaleKeys.orderDetails)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: List.generate(
            10,
            (index) => BuildSingleOrderDetails(),
          ),
        ),
      ),
    );
  }
}
