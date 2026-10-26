import 'package:flutter/material.dart';
import '../models/food_item.dart';

class DetailScreen extends StatelessWidget {
  final FoodItem food;

  const DetailScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center( // <-- Добавили Center
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600), // <-- Ограничиваем ширину (как на главном экране)
          child: CustomScrollView(
            slivers: [
              // ... ваш код SliverAppBar и т.д.
          // --- ШАПКА С КАРТИНКОЙ ---
                    SliverAppBar(
            expandedHeight: 300, 
            pinned: true,
            backgroundColor: Colors.white,
            leadingWidth: 70, 
            
                        // --- ЛЕВАЯ ИКОНКА (НАЗАД) ---
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: CircleAvatar(
                  radius: 22, 
                  backgroundColor: const Color(0xFFF2F2F2), 
                  child: Image.asset(
                    'assets/images/icons/back.png', 
                    width: 24, // Поставьте 24 или 28, чтобы иконка не была слишком большой
                    height: 24, 
                    // УБРАЛИ СТРОКУ color: ... - теперь картинка будет своего родного цвета
                  ),
                ),
              ),
            ),
            
            
            // --- ПРАВАЯ ИКОНКА (КОРЗИНА) ---
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 16.0),
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 22, 
                    backgroundColor: const Color(0xFFF2F2F2),
                    child: Image.asset(
                      'assets/images/icons/cart_white.png', 
                      width: 24, 
                      height: 24, 
                      // УБРАЛИ СТРОКУ color: ...
                    ),
                  ),
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                food.imageUrl, 
                fit: BoxFit.cover, 
              ),
            ),
          ),
          
          // --- КОНТЕНТ ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0), // Увеличили отступы по бокам
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Сердечко (справа)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/images/icons/heart.png',
                      width: 24,
                      height: 24,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  
                  // Название и цена
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start, // Выравниваем по верху
                    children: [
                      Expanded(
                        child: Text(
                          food.name, 
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF333333))
                        ),
                      ),
                      // Цена с иконкой рубля
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0), // Опустили цену чуть ниже
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Image.asset(
                                'assets/images/icons/ruble.png',
                                width: 12,
                                height: 14,
                                color: const Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "${food.price}",
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xFF333333), height: 1.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Рейтинг и время
                  Row(
                    children: [
                      Image.asset('assets/images/icons/star.png', width: 16, height: 16, color: const Color(0xFF333333)),
                      const SizedBox(width: 4),
                      Text(
                        "${food.rating.toString().replaceAll('.', ',')}", 
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF333333))
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "(${food.reviewsCount}+)", 
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF828282))
                      ),
                      const SizedBox(width: 12),
                      Text(
                        food.deliveryTime, 
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF333333))
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Описание (сделали черным)
                  const Text(
                    "Et consectetur commodo ut consectetur ex nulla voluptate commodo ipsum incididunt qui dolor.",
                    style: TextStyle(color: Color(0xFF333333), height: 1.5, fontSize: 14), // <-- Изменили цвет
                  ),
                  const SizedBox(height: 20),
                  
                  // Кнопка Купить
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF2C94C),
                        foregroundColor: const Color(0xFF333333),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                        onPressed: () {
                        // При нажатии возвращаемся назад и передаем "1" (один добавленный товар)
                        Navigator.pop(context, 1); 
                      },
                      child: const Text("Купить", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // --- ВКЛАДКИ ---
                  Row(
                    children: [
                      Column(
                        children: [
                          const Text("Дополнительно", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF333333))),
                          const SizedBox(height: 8),
                          Container(
                            height: 2,
                            width: 60, 
                            color: const Color(0xFF333333),
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      const Text("Похожие", style: TextStyle(color: Color(0xFF828282), fontSize: 16)),
                      const SizedBox(width: 20),
                      const Text("Отзывы", style: TextStyle(color: Color(0xFF828282), fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // --- СПИСОК КОФЕ ---
                  _buildAddonItem(),
                   _buildAddonItem(),
                  _buildAddonItem(),
                ],
              ),
            ),
          ),
        ], // Закрывает slivers: [
      ), // Закрывает CustomScrollView
      
      ), // Закрывает ConstrainedBox
      ), // Закрывает Center
      
    ); // Закрывает Scaffold
  }


  Widget _buildAddonItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/images/coffee.jpg", 
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Просто кофе", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF333333))),
                Text("Вкусный зерновой кофеечек", style: TextStyle(color: Color(0xFF828282), fontSize: 13)),
              ],
            ),
          ),
          const Text("200 руб", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF333333))),
        ],
      ),
    );
  }
}