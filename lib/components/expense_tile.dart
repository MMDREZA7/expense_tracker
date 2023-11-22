import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  ExpenseTile({
    super.key,
    required this.amount,
    required this.dateTime,
    required this.name,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // delete button
          SlidableAction(
            borderRadius: BorderRadius.circular(4),
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
          ),
        ],
      ),
      child: Container(
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
      ),
    );
  }
}
