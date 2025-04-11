import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../theme/app_theme.dart';
import '../widgets/transaction_list_item.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryColor,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textSecondaryColor,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Sent'),
            Tab(text: 'Received'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTransactionsList(dummyTransactions),
          _buildTransactionsList(dummyTransactions.where((tx) => tx.type == TransactionType.send).toList()),
          _buildTransactionsList(dummyTransactions.where((tx) => tx.type == TransactionType.receive).toList()),
        ],
      ),
    );
  }
  
  Widget _buildTransactionsList(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'No transactions found',
          style: TextStyle(color: AppTheme.textSecondaryColor),
        ),
      );
    }
    
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      separatorBuilder: (context, index) => const Divider(height: 24, color: AppTheme.surfaceColor),
      itemBuilder: (context, index) {
        return TransactionListItem(
          transaction: transactions[index],
          showDetails: true,
        );
      },
    );
  }
}
