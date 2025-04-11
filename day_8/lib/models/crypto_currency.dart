class CryptoCurrency {
  final String name;
  final String symbol;
  final String iconPath;
  final double price;
  final double change24h;
  final double balance;

  CryptoCurrency({
    required this.name,
    required this.symbol,
    required this.iconPath,
    required this.price,
    required this.change24h,
    required this.balance,
  });
}

List<CryptoCurrency> dummyCryptos = [
  CryptoCurrency(
    name: 'Bitcoin',
    symbol: 'BTC',
    iconPath: 'assets/icons/bitcoin.png',
    price: 42356.78,
    change24h: 2.34,
    balance: 0.0245,
  ),
  CryptoCurrency(
    name: 'Ethereum',
    symbol: 'ETH',
    iconPath: 'assets/icons/ethereum.png',
    price: 2356.43,
    change24h: -1.23,
    balance: 0.567,
  ),
  CryptoCurrency(
    name: 'Solana',
    symbol: 'SOL',
    iconPath: 'assets/icons/solana.png',
    price: 134.56,
    change24h: 5.67,
    balance: 12.34,
  ),
  CryptoCurrency(
    name: 'Cardano',
    symbol: 'ADA',
    iconPath: 'assets/icons/cardano.png',
    price: 0.56,
    change24h: 0.89,
    balance: 345.67,
  ),
];
