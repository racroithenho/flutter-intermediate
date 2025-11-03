import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense.dart';
import '../widgets/add_expense_dialog.dart';
import '../widgets/expense_list.dart';
import '../widgets/expense_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseBox = Hive.box<Expense>('expenses');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: expenseBox.listenable(),
        builder: (context, Box<Expense> box, _) {
          final expenses = box.values.toList();
          return Column(
            children: [
              Expanded(child: ExpenseChart(expenses: expenses)),
              Expanded(child: ExpenseList(expenses: expenses)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const AddExpenseDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
