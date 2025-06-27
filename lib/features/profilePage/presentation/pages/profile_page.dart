import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('توضیحات', style: TextStyle(fontSize: 20)),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.chevron_left_rounded, size: 40),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
            bottom: const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.blue,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  child: Text('اطلاعات مجموعه', style: TextStyle(fontSize: 14)),
                ),
                Tab(
                  child: Text('نظرات کاربران', style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12, right: 10),
                          child: Text(
                            'اطلاعات مجموعه',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    _buildMapSection(),
                    const SizedBox(height: 16),
                    _buildAddressSection(),
                    const SizedBox(height: 16),
                    _buildOpeningHoursSection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              const Center(
                child: Text(
                  'بخش نظرات کاربران',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildMapSection() {
  return Stack(
    children: [
      Container(
        height: 300,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.map_outlined, color: Colors.grey, size: 80),
        ),
      ),
      Positioned(
        top: 16,
        left: 16,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () {},
              ),
              Container(width: 30, height: 1, color: Colors.grey[300]),
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 16,
        right: 16,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.location_pin, color: Colors.black54),
            onPressed: () {},
          ),
        ),
      ),
    ],
  );
}

Widget _buildAddressSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(Icons.location_pin, color: Colors.grey, size: 28),
        const Expanded(
          flex: 4,
          child: Text(
            'بلوار جمهوری سه راه حمزه بلوار',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Spacer(),
        const Text(
          'مسیریابی',
          style: TextStyle(color: Colors.blue, fontSize: 14),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.directions, color: Colors.blue, size: 28),
      ],
    ),
  );
}

Widget _buildOpeningHoursSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: TextDirection.rtl,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.green.shade800,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'باز است',
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_up, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          // لیست روزها و ساعات
          _buildOpeningHoursRow('شنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
          _buildOpeningHoursRow('یکشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
          _buildOpeningHoursRow('دوشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
          _buildOpeningHoursRow('سه‌شنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
          _buildOpeningHoursRow('چهارشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
          _buildOpeningHoursRow('پنجشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
          _buildOpeningHoursRow('جمعه', 'تعطیل است', isClosed: true),
        ],
      ),
    ),
  );
}

Widget _buildOpeningHoursRow(String day, String time, {bool isClosed = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isClosed
            ? Text(
              time,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
            )
            : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        Text(
          day,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
