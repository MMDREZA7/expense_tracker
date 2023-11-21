import 'package:aathan_login/bar%20graf/bar_graf.dart';
import 'package:aathan_login/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraf(
          maxY: 100,
          sunAmount: 20,
          monAmount: 50,
          tueAmount: 10,
          wedAmount: 30,
          thurAmount: 24,
          friAmount: 3,
          satAmount: 90,
        ),
      ),
    );
  }
}
