class CartRepository {
  final List<Map<String, dynamic>> data = <Map<String, dynamic>>[
    {
      'id_cart': 1,
      'qty': 1,
      'item': {
        "id_menu": 2,
        "name": "Chicken Slam ",
        "category": "food",
        "harga": 13000,
        "deskripsi":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.s",
        "foto": "https://i.ibb.co/R9kJtny/1637916829.png",
      },
    },
    {
      'id_cart': 2,
      'qty': 2,
      'item': {
        "id_menu": 3,
        "name": "Lemon Tea",
        "category": "drink",
        "harga": 5000,
        "deskripsi": "Daun Teh dengan irisan lemon",
        "foto": "https://javacode.landa.id/img/menu/gambar_62660e379fdf4.png",
        "status": 1
      },
    },
    {
      'id_cart': 3,
      'qty': 1,
      'item': {
        "id_menu": 13,
        "name": "Fried Rice",
        "category": "food",
        "harga": 13000,
        "deskripsi": "fr",
        "foto": "https://javacode.landa.id/img/menu/gambar_62660ef6630d6.png",
        "status": 1
      },
    },
  ];

  List<Map<String, dynamic>> getListOfData() {
    return data;
  }
}
