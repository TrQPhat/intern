enum TransactionType { send, receive, exchange, buy, sell }

class Transaction {
  final String id;
  final TransactionType type;
  final String cryptoSymbol;
  final String cryptoIconPath;
  final double amount;
  final double amountUsd;
  final DateTime date;
  final String status;
  final String? toAddress;
  final String? fromAddress;

  Transaction({
    required this.id,
    required this.type,
    required this.cryptoSymbol,
    required this.cryptoIconPath,
    required this.amount,
    required this.amountUsd,
    required this.date,
    required this.status,
    this.toAddress,
    this.fromAddress,
  });
}

List<Transaction> dummyTransactions = [
  Transaction(
    id: 'tx1',
    type: TransactionType.receive,
    cryptoSymbol: 'BTC',
    cryptoIconPath: 'assets/icons/bitcoin.png',
    amount: 0.0025,
    amountUsd: 105.89,
    date: DateTime.now().subtract(const Duration(hours: 2)),
    status: 'Completed',
    fromAddress: '0x1a2b3c4d5e6f',
  ),
  Transaction(
    id: 'tx2',
    type: TransactionType.send,
    cryptoSymbol: 'ETH',
    cryptoIconPath: 'assets/icons/ethereum.png',
    amount: 0.15,
    amountUsd: 353.46,
    date: DateTime.now().subtract(const Duration(days: 1)),
    status: 'Completed',
    toAddress: '0xabcdef123456',
  ),
  Transaction(
    id: 'tx3',
    type: TransactionType.buy,
    cryptoSymbol: 'SOL',
    cryptoIconPath: 'assets/icons/solana.png',
    amount: 5.0,
    amountUsd: 672.80,
    date: DateTime.now().subtract(const Duration(days: 3)),
    status: 'Completed',
  ),
  Transaction(
    id: 'tx4',
    type: TransactionType.exchange,
    cryptoSymbol: 'BTC',
    cryptoIconPath: 'assets/icons/bitcoin.png',
    amount: 0.001,
    amountUsd: 42.36,
    date: DateTime.now().subtract(const Duration(days: 5)),
    status: 'Completed',
  ),
];
