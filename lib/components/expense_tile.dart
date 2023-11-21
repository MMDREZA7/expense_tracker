import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;

  const ExpenseTile({
    super.key,
    required this.amount,
    required this.dateTime,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text("${dateTime.day}/${dateTime.month}/${dateTime.year}"),
        trailing: Text(amount),
      ),
    );
  }
}
