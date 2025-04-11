import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../theme/app_theme.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final bool showDetails;

  const TransactionListItem({
    super.key,
    required this.transaction,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: showDetails ? AppTheme.cardColor : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildTransactionIcon(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTransactionTitle(),
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM dd, yyyy • HH:mm').format(transaction.date),
                      style: const TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _getAmountText(),
                    style: TextStyle(
                      color: _getAmountColor(),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${transaction.amountUsd.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (showDetails && (transaction.toAddress != null || transaction.fromAddress != null)) ...[
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppTheme.surfaceColor),
            const SizedBox(height: 16),
            if (transaction.toAddress != null)
              _buildAddressRow('To', transaction.toAddress!),
            if (transaction.fromAddress != null)
              _buildAddressRow('From', transaction.fromAddress!),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status',
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    transaction.status,
                    style: const TextStyle(
                      color: AppTheme.successColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTransactionIcon() {
    IconData icon;
    Color color;
    Color backgroundColor;

    switch (transaction.type) {
      case TransactionType.send:
        icon = Icons.arrow_upward;
        color = AppTheme.errorColor;
        backgroundColor = AppTheme.errorColor.withOpacity(0.1);
        break;
      case TransactionType.receive:
        icon = Icons.arrow_downward;
        color = AppTheme.successColor;
        backgroundColor = AppTheme.successColor.withOpacity(0.1);
        break;
      case TransactionType.exchange:
        icon = Icons.swap_horiz;
        color = AppTheme.warningColor;
        backgroundColor = AppTheme.warningColor.withOpacity(0.1);
        break;
      case TransactionType.buy:
        icon = Icons.add;
        color = AppTheme.primaryColor;
        backgroundColor = AppTheme.primaryColor.withOpacity(0.1);
        break;
      case TransactionType.sell:
        icon = Icons.remove;
        color = AppTheme.errorColor;
        backgroundColor = AppTheme.errorColor.withOpacity(0.1);
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  String _getTransactionTitle() {
    switch (transaction.type) {
      case TransactionType.send:
        return 'Sent ${transaction.cryptoSymbol}';
      case TransactionType.receive:
        return 'Received ${transaction.cryptoSymbol}';
      case TransactionType.exchange:
        return 'Exchanged ${transaction.cryptoSymbol}';
      case TransactionType.buy:
        return 'Bought ${transaction.cryptoSymbol}';
      case TransactionType.sell:
        return 'Sold ${transaction.cryptoSymbol}';
    }
  }

  String _getAmountText() {
    String prefix = '';
    
    switch (transaction.type) {
      case TransactionType.send:
        prefix = '-';
        break;
      case TransactionType.receive:
        prefix = '+';
        break;
      case TransactionType.buy:
        prefix = '+';
        break;
      case TransactionType.sell:
        prefix = '-';
        break;
      case TransactionType.exchange:
        prefix = '';
        break;
    }
    
    return '$prefix${transaction.amount.toStringAsFixed(4)} ${transaction.cryptoSymbol}';
  }

  Color _getAmountColor() {
    switch (transaction.type) {
      case TransactionType.send:
      case TransactionType.sell:
        return AppTheme.errorColor;
      case TransactionType.receive:
      case TransactionType.buy:
        return AppTheme.successColor;
      case TransactionType.exchange:
        return AppTheme.warningColor;
    }
  }

  Widget _buildAddressRow(String label, String address) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              Text(
                _truncateAddress(address),
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 14,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.copy,
                  size: 16,
                  color: AppTheme.textSecondaryColor,
                ),
                onPressed: () {},
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(left: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _truncateAddress(String address) {
    if (address.length <= 12) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }
}
