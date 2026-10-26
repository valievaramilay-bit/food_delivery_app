import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../widgets/food_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int cartCount = 0; 
  int selectedCategoryIndex = 0; 
  
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  List<FoodItem> get filteredFoods {
    List<FoodItem> categoryFiltered;
    if (selectedCategoryIndex == 0) {
      categoryFiltered = dummyFoods; 
    } else if (selectedCategoryIndex == 1) {
      categoryFiltered = [dummyFoods[0]]; 
    } else if (selectedCategoryIndex == 2) {
      categoryFiltered = [dummyFoods[1]]; 
    } else if (selectedCategoryIndex == 3) {
      categoryFiltered = [dummyFoods[3]]; 
    } else {
      categoryFiltered = dummyFoods;
    }

    if (_searchQuery.isEmpty) {
      return categoryFiltered;
    }

    return categoryFiltered.where((food) => 
      food.name.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  @override
  void dispose() {
    _searchController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      
      // --- БОКОВОЕ МЕНЮ ---
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFF8F8F8), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60), 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 22.5, 
                      backgroundImage: AssetImage('assets/images/icons/avatar.png'),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Juanita Nguyen", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF333333)), overflow: TextOverflow.ellipsis),
                          SizedBox(height: 2),
                          Text("somemail@mail.com", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Color(0xFF828282)), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/icons/out.png', width: 24, height: 24),
                  ],
                ),
              ),
              const SizedBox(height: 40), 
              _buildMenuItem(title: "Все меню", onTap: () {}),
                            _buildMenuItem(
                title: "Заказы", 
                trailing: const Padding(
                  padding: EdgeInsets.only(right: 8.0), // <-- Отступ справа (чем больше цифра, тем левее сдвинется "6")
                  child: Text(
                    "6", 
                    style: TextStyle(fontSize: 14, color: Color(0xFF828282))
                  ),
                ),
                onTap: () {},
              ),
              _buildMenuItem(
                title: "Корзина", 
                trailing: Container(
                  width: 24, height: 24, alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Color(0xFFF2C94C), shape: BoxShape.circle),
                  child: Text("$cartCount", style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      
            body: Center( // <-- Добавили Center
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600), // <-- Максимальная ширина (для телефона/планшета)
          child: CustomScrollView(
            slivers: [
          // --- ШАПКА ---
          SliverAppBar(
            backgroundColor: Colors.white, pinned: true, elevation: 0,
            centerTitle: false, titleSpacing: 10, leadingWidth: 60, 
            leading: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: IconButton(
                  icon: const Icon(Icons.menu, color: Color(0xFF333333), size: 28, weight: 200), 
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("Челябинск", style: TextStyle(color: Color(0xFF333333), fontSize: 16, fontWeight: FontWeight.w400)),
                SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, color: Color(0xFF333333), size: 20),
              ],
            ),
                        actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Stack(
                    clipBehavior: Clip.none, // Позволяет кружку выходить за границы иконки
                    children: [
                      // Сама иконка корзины
                      Image.asset(
                        'assets/images/icons/cart.png', 
                        width: 28, // Чуть увеличили размер для красоты
                        height: 28,
                      ),
                      
                      // Желтый кружок со счетчиком (появляется только если товары есть)
                      if (cartCount > 0)
                        Positioned(
                          right: -6, // Сдвигаем вправо
                          top: -6,   // Сдвигаем вверх
                          child: Container(
                            padding: const EdgeInsets.all(4), // Размер кружка
                            decoration: const BoxDecoration(
                              color: Color(0xFFF2C94C), // Желтый цвет
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 18, // Минимальная ширина, чтобы 1 не была слишком маленькой
                              minHeight: 18,
                            ),
                            child: Center(
                              child: Text(
                                '$cartCount',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // --- БЛОК ПОИСКА (уезжает при скролле) ---
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 47.0, right: 47.0, top: 20.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Голоден?", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Color(0xFF333333), letterSpacing: 0)),
                  const SizedBox(height: 24), 
                  
                  Container(
                    height: 50, 
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        Image.asset('assets/images/icons/search.png', width: 24, height: 24),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: "Поиск по меню",
                              hintStyle: TextStyle(color: Color(0xFFBDBDBD), fontSize: 16, fontWeight: FontWeight.w400), 
                              border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- БЛОК КАТЕГОРИЙ (прилипает к верху) ---
          SliverPersistentHeader(
            pinned: true, 
            delegate: _CategoriesHeaderDelegate(
              selectedIndex: selectedCategoryIndex,
              onCategoryTap: (index) {
                setState(() {
                  selectedCategoryIndex = index;
                });
              },
            ),
          ),

          // --- СПИСОК КАРТОЧЕК ---
                    // --- СПИСОК КАРТОЧЕК ---
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final food = filteredFoods[index];
                return FoodCard(
                  food: food,
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailScreen(food: food)),
                    );
                    
                    if (result != null) {
                      setState(() {
                        cartCount += result as int; 
                      });
                    }
                  },
                );
              },
              childCount: filteredFoods.length,
            ), // Закрывает SliverChildBuilderDelegate
                    ), // Закрывает SliverList
        ], // Закрывает slivers: [
      ), // Закрывает CustomScrollView
      ), // Закрывает ConstrainedBox
      ), // Закрывает Center
    );
  }

  // --- ВСПОМОГАТЕЛЬНЫЙ МЕТОД ДЛЯ МЕНЮ ---
  Widget _buildMenuItem({required String title, Widget? trailing, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 45, 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Color(0xFF333333)))),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }
} // <--- ЗДЕСЬ ЗАКАНЧИВАЕТСЯ КЛАСС _HomeScreenState

// --- НОВЫЙ КЛАСС ДЛЯ ПРИЛИПАЮЩИХ КАТЕГОРИЙ (он должен быть ВНЕ класса _HomeScreenState) ---
class _CategoriesHeaderDelegate extends SliverPersistentHeaderDelegate {
  final int selectedIndex;
  final Function(int) onCategoryTap;

  _CategoriesHeaderDelegate({required this.selectedIndex, required this.onCategoryTap});

  @override
  double get minExtent => 90.0; 
  @override
  double get maxExtent => 90.0; 

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, 
      padding: const EdgeInsets.symmetric(horizontal: 47.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCategoryItem('assets/images/icons/all.png', "Все", selectedIndex == 0, () => onCategoryTap(0)),
          _buildCategoryItem('assets/images/icons/pizza.png', "Пицца", selectedIndex == 1, () => onCategoryTap(1)),
          _buildCategoryItem('assets/images/icons/kebab.png', "Кебаб", selectedIndex == 2, () => onCategoryTap(2)),
          _buildCategoryItem('assets/images/icons/burger.png', "Бургер", selectedIndex == 3, () => onCategoryTap(3)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String imagePath, String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath, width: 32, height: 32,
            color: isSelected ? const Color(0xFF333333) : const Color(0xFF828282),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400, 
              color: isSelected ? const Color(0xFF333333) : const Color(0xFF828282),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _CategoriesHeaderDelegate oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}