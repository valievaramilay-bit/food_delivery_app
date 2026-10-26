class FoodItem {
  final String name;
  final double rating;
  final int reviewsCount;
  final String deliveryTime;
  final int price;
  final String imageUrl;

  FoodItem({
    required this.name,
    required this.rating,
    required this.reviewsCount,
    required this.deliveryTime,
    required this.price,
    required this.imageUrl,
  });
}

List<FoodItem> dummyFoods = [
  FoodItem(
    name: "Дерзкая Марго", // Пицца
    rating: 4.5,
    reviewsCount: 100,
    deliveryTime: "25-30 мин",
    price: 300,
    imageUrl: "assets/images/pizza.jpg",
  ),
  FoodItem(
    name: "Горячий парень", // Кебаб
    rating: 4.5,
    reviewsCount: 100,
    deliveryTime: "25-30 мин",
    price: 300,
    imageUrl: "assets/images/kebab.jpg",
  ),
  FoodItem(
    name: "Вкусняшка Миа", // Десерт
    rating: 4.5,
    reviewsCount: 100,
    deliveryTime: "25-30 мин",
    price: 300,
    imageUrl: "assets/images/dessert.jpg",
  ),
  FoodItem(
    name: "Сытый Питт", // Бургер
    rating: 4.5,
    reviewsCount: 100,
    deliveryTime: "25-30 мин",
    price: 300,
    imageUrl: "assets/images/burger.jpg",
  ),
];