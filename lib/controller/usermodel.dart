class usermodel {
  final String? id;
  final String name;
  final String last_name;
  final String phone_number;
  const usermodel(
      {this.id,
      required this.name,
      required this.last_name,
      required this.phone_number});

  toJson() {
    return {
      "الإسم": this.name,
      "اللقب": this.last_name,
      "رقم الهاتف": this.phone_number
    };
  }
}
