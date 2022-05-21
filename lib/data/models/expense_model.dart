class Expense {
  String? name;
  double? amount;
  String? timestamp;
  String? id;

  Expense({this.amount, this.id, this.name, this.timestamp});

  factory Expense.fromJson(Map<String, dynamic> json, String docId) {
    return Expense(
      id: docId,
      name: json['name'],
      amount: json['amount'].toDouble(),
      timestamp: json['timestamp'],
    );
  }
}
