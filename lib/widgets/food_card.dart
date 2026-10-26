import 'package:flutter/material.dart';
import '../models/food_item.dart';

class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;

  const FoodCard({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Картинка
            Image.asset(
              food.imageUrl,
              height: 220, 
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- НАЗВАНИЕ И ЦЕНА ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          food.name,
                          style: const TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.w700, 
                            color: Color(0xFF333333)
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Цена с иконкой рубля (выровнено по низу)
                      Row(
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
                            "${food.price}", // Выводим цену из модели
                            style: const TextStyle(
                              fontSize: 32, // Размер как вы просили
                              fontWeight: FontWeight.w700, 
                              color: Color(0xFF333333),
                              height: 1.0, 
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // --- РЕЙТИНГ И ВРЕМЯ ---
                  Row(
                    children: [
                      // Звезда
                      Image.asset(
                        'assets/images/icons/star.png',
                        width: 16,
                        height: 16,
                        color: const Color(0xFF333333),
                      ),
                      const SizedBox(width: 4),
                      // Оценка с запятой
                      Text(
                        "${food.rating.toString().replaceAll('.', ',')}", 
                        style: const TextStyle(
                          fontSize: 14, 
                          fontWeight: FontWeight.w700, 
                          color: Color(0xFF333333)
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Отзывы
                      Text(
                        "(${food.reviewsCount}+)",
                        style: const TextStyle(
                          fontSize: 14, 
                          fontWeight: FontWeight.w400, 
                          color: Color(0xFF828282) 
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Время
                      Text(
                        food.deliveryTime,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700, 
                          color: Color(0xFF333333)
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // --- КНОПКА КУПИТЬ ---
                  SizedBox(
                    width: double.infinity,
                    height: 48, 
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF2C94C), 
                        foregroundColor: const Color(0xFF333333),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), 
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Купить", 
                        style: TextStyle(
                          fontWeight: FontWeight.w700, 
                          fontSize: 16,
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}