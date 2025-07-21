import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [ProductScreen()],
            ),
          ),
        ),
      ),
    );
  }
}

// مرحله ۱: تبدیل به StatefulWidget برای مدیریت وضعیت
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // مرحله ۲: تعریف یک متغیر برای کنترل نمایش آیتم تعداد
  bool _isFirstProductAdded = false;

  // تابعی برای تغییر وضعیت و نمایش آیتم تعداد
  void _addProduct() {
    setState(() {
      _isFirstProductAdded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 0,
        color: const Color(0xfff5f6fb),
        child: Column(
          children: [
            // مرحله ۴: پاس دادن تابع به دکمه افزودن
            ProductAddItem(
              title: 'یک نفره',
              onPressed: _addProduct,
            ),
            // اگر محصول اول اضافه شده بود، ویجت تعداد را نمایش بده
            if (_isFirstProductAdded)
              const Column(
                children: [
                  SizedBox(height: 10),
                  ProductQuantityItem(),
                ],
              ),
            const SizedBox(height: 16),
            // برای آیتم‌های دیگر یک تابع خالی پاس می‌دهیم
            ProductAddItem(
              title: 'دو نفره',
              onPressed: () {
                // منطق افزودن محصول دو نفره
              },
            ),
            const SizedBox(height: 16),
            ProductAddItem(
              title: 'سه نفره',
              onPressed: () {
                // منطق افزودن محصول سه نفره
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// ویجت برای نمایش آیتم اضافه شده به سبد خرید با قابلیت تغییر تعداد
class ProductQuantityItem extends StatefulWidget {
  const ProductQuantityItem({super.key});

  @override
  State<ProductQuantityItem> createState() => _ProductQuantityItemState();
}

class _ProductQuantityItemState extends State<ProductQuantityItem> {
  int _quantity = 1; // مقدار اولیه تعداد را می‌توان ۱ در نظر گرفت

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
      // اگر بخواهید با رسیدن به صفر، این ویجت حذف شود،
      // باید از یک callback برای اطلاع به ویجت والد استفاده کنید.
      // فعلا طبق درخواست، فقط تا ۱ کم می‌شود.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xffe6e8f5)),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // بخش اطلاعات محصول
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'پیتزا مارگاریتا / یک نفره',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'سس کچاپ/ بدون ادویه',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '۱,۳۲۵,۰۰۰ تومان',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
            // بخش کنترلر تعداد
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, color: Color(0xff00105B)),
                    onPressed: _increment,
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove, color: Color(0xff00105B)),
                    onPressed: _decrement,
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

/// ویجت برای نمایش آیتم‌های قابل افزودن به سبد خرید
class ProductAddItem extends StatelessWidget {
  final String title;
  // مرحله ۳: تعریف پارامتر onPressed
  final VoidCallback onPressed;

  const ProductAddItem({
    super.key,
    required this.title,
    required this.onPressed, // اضافه کردن به کانستراکتور
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // بخش اطلاعات و قیمت
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Text(
                    '۱,۳۲۵,۰۰۰ تومان',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                  SizedBox(width: 8),
                  // ویجت تخفیف
                  _DiscountWidget(),
                  SizedBox(width: 8),
                  // قیمت اصلی با خط خوردگی
                  Text(
                    '۵۷۵,۰۰۰',
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // دکمه افزودن
          OutlinedButton.icon(
            // استفاده از onPressed پاس داده شده
            onPressed: onPressed,
            icon: const Icon(Icons.add),
            label: const Text('افزودن'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xff00105B),
              side: const BorderSide(color: Color(0xff00105B)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          )
        ],
      ),
    );
  }
}

// یک ویجت کوچک برای خوانایی بهتر
class _DiscountWidget extends StatelessWidget {
  const _DiscountWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        '٪۵۸',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}