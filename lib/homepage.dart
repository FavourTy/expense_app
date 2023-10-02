import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transactiion.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List<Transaction> _transactions = [];
  final List<Transaction> _userTransaction = [
    // Transaction(
    //  id: "tl", title: "New dress", amount: 1000, date: DateTime.now()),
    // Transaction(id: "tl", title: "Grocies", amount: 500, date: DateTime.now()),
    // Transaction(id: "tl", title: "Outings", amount: 1500, date: DateTime.now()),
  ];
  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        amount: txAmount,
        title: txTitle,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  // String titleInput = "";
  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =  MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      actions: [
        IconButton(
            onPressed: () => _startNewTransaction(context),
            icon: const Icon(Icons.add))
      ],
      title: const Text(
        "PERSONAL EXPENSES APP",
        style: TextStyle(
          fontFamily: 'OpenSans',
        ),
      ),
      centerTitle: true,
    );
    final txListWidget =  Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child:
                        TransactionList(_userTransaction, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
         if (isLandscape)  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Chart"),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
              ],
            ),
            // ignore: sized_box_for_whitespace
            if(!isLandscape) Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(_recentTransactions)),
                    if(!isLandscape) txListWidget,
          if(isLandscape)  _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(_recentTransactions))
                : txListWidget
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
