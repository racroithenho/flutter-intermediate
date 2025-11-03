import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(child: Text('No expenses yet.'));
    }

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final e = expenses[index];
        return ListTile(
          leading: const Icon(Icons.money),
          title: Text(e.title),
          subtitle: Text('${e.date.day}/${e.date.month}/${e.date.year}'),
          trailing: Text('\$${e.amount.toStringAsFixed(2)}'),
        );
      },
    );
  }
}
