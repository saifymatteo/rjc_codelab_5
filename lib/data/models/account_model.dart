class Account {
  String? id;
  String? type;
  String? accountNumber;
  double? balance;

  Account({this.accountNumber, this.balance, this.id, this.type});

  factory Account.fromJson(Map<String, dynamic> json, String docId) {
    return Account(
      id: docId,
      type: json['type'],
      accountNumber: json['account_number'],
      balance: json['balance'].toDouble(),
    );
  }
}
