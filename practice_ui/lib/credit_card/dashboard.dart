import 'package:flutter/material.dart';

import 'card.dart';
import 'component/appbar.dart';
import 'config/colors.dart';
import 'config/size.dart';
import 'expense.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return Scaffold(
      body: Container(
        color: AppColors.primaryWhite,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height / 8,
                child: const CustomAppBar(),
              ),
              const Expanded(
                child: CardWidget(),
              ),
              const Expanded(child: ExpensesWidget())
            ],
          ),
        ),
      ),
    );
  }
}