import 'package:aathan_login/components/expense_summary.dart';
import 'package:aathan_login/components/expense_tile.dart';
import 'package:aathan_login/data/expense_data.dart';
import 'package:aathan_login/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseDollarController = TextEditingController();
  final newExpenseCentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // add new expence
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              decoration: const InputDecoration(
                hintText: "Expense name",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              controller: newExpenseNameController,
            ),

            Row(
              children: [
                // expense amount
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Dollers',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    controller: newExpenseDollarController,
                  ),
                ), // expense amount
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Cent',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    controller: newExpenseCentsController,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),

          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // saveNewExpenseButton
  void save() {
    // only svae expense if all text fields ore filled
    if (newExpenseCentsController.text.isNotEmpty &&
        newExpenseDollarController.text.isNotEmpty &&
        newExpenseCentsController.text.isNotEmpty) {
      // put dollars and cents together
      String amount =
          '${newExpenseDollarController.text}.${newExpenseCentsController.text}';
      // create expense item
      ExpenseItem newExpense = ExpenseItem(
        amount: amount,
        dateTime: DateTime.now(),
        name: newExpenseNameController.text,
      );
      // add the new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }
    Navigator.pop(context);
    clear();
  }

  // cancleNewExpenseButton
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear controllers
  void clear() {
    newExpenseNameController.clear();
    newExpenseDollarController.clear();
    newExpenseCentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            // weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),

            const SizedBox(height: 20),

            // expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: '\$${value.getAllExpenseList()[index].amount}',
                dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0) =>
                    deleteExpense(value.getAllExpenseList()[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
