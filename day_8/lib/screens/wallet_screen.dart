import 'package:flutter/material.dart';
import '../models/crypto_currency.dart';
import '../theme/app_theme.dart';
import '../widgets/balance_card.dart';
import '../widgets/crypto_list_item.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BalanceCard(
              totalBalance: 12567.89,
              percentChange: 3.45,
            ),
            const SizedBox(height: 24),
            _buildPortfolioChart(),
            const SizedBox(height: 24),
            _buildAssetsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Portfolio Allocation',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CustomPaint(
                      painter: DonutChartPainter(),
                    ),
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '\$12,567.89',
                        style: TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildLegendItem('BTC', AppTheme.primaryColor, '45%'),
              _buildLegendItem('ETH', AppTheme.accentColor, '30%'),
              _buildLegendItem('SOL', AppTheme.warningColor, '15%'),
              _buildLegendItem('ADA', AppTheme.successColor, '10%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, String percentage) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '$label ($percentage)',
          style: const TextStyle(
            color: AppTheme.textSecondaryColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildAssetsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Assets',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dummyCryptos.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return CryptoListItem(
              crypto: dummyCryptos[index],
              showBalance: true,
            );
          },
        ),
      ],
    );
  }
}

class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0;
    
    // Draw segments
    var startAngle = 0.0;
    
    // BTC - 45%
    paint.color = AppTheme.primaryColor;
    canvas.drawArc(rect, startAngle, 0.45 * 2 * 3.14, false, paint);
    startAngle += 0.45 * 2 * 3.14;
    
    // ETH - 30%
    paint.color = AppTheme.accentColor;
    canvas.drawArc(rect, startAngle, 0.3 * 2 * 3.14, false, paint);
    startAngle += 0.3 * 2 * 3.14;
    
    // SOL - 15%
    paint.color = AppTheme.warningColor;
    canvas.drawArc(rect, startAngle, 0.15 * 2 * 3.14, false, paint);
    startAngle += 0.15 * 2 * 3.14;
    
    // ADA - 10%
    paint.color = AppTheme.successColor;
    canvas.drawArc(rect, startAngle, 0.1 * 2 * 3.14, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
