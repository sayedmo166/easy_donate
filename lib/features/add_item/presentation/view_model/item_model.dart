class Item {
  final String address;
  final String phone;
  final String itemType;
  final String imageUrl;
  final String userId;
  final String userName;
  final DateTime createdAt;
  final String id;

  Item({
    required this.address,
    required this.phone,
    required this.itemType,
    required this.imageUrl,
    required this.userId,
    required this.userName,
    required this.createdAt,
    required this.id,
  });

  factory Item.fromMap(Map<String, dynamic> data, String id) {
    return Item(
      id: id,
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      itemType: data['itemType'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'phone': phone,
      'itemType': itemType,
      'imageUrl': imageUrl,
      'userId': userId,
      'userName': userName,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
