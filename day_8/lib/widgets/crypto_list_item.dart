import 'package:flutter/material.dart';
import '../models/crypto_currency.dart';
import '../theme/app_theme.dart';

class CryptoListItem extends StatelessWidget {
  final CryptoCurrency crypto;
  final bool showBalance;

  const CryptoListItem({
    super.key,
    required this.crypto,
    this.showBalance = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                crypto.symbol.substring(0, 1),
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crypto.name,
                  style: const TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  crypto.symbol,
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
                '\$${crypto.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    crypto.change24h >= 0
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: crypto.change24h >= 0
                        ? AppTheme.successColor
                        : AppTheme.errorColor,
                    size: 12,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${crypto.change24h.abs().toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: crypto.change24h >= 0
                          ? AppTheme.successColor
                          : AppTheme.errorColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (showBalance) ...[
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${crypto.balance.toStringAsFixed(4)} ${crypto.symbol}',
                  style: const TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${(crypto.balance * crypto.price).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
