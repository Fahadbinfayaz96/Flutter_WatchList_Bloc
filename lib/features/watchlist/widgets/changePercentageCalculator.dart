double calculateChangePercent(double change, double price) {
  if (price == 0) return 0;
  return (change / (price - change)) * 100;
}
