import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'زودکس پلاس',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            leading: GestureDetector(
              child: Icon(
                Icons.chevron_left_rounded,
                size: 40,
                color: Color(0xff5F6266),
              ),
              onTap: () {
                if (Navigator.canPop(context)) Navigator.pop(context);
              },
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(8.0),
              child: Divider(
                height: 1.0,
                thickness: 2.0,
                color: Color(0xffefeef0),
                indent: 16,
                endIndent: 16, // می‌توانید رنگ را تغییر دهید
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      color: Color(0xfff6f6f6),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4), // تغییر موقعیت سایه
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffffeed7),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                              child: Text(
                                'شش ماه',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 32),
                          Text(
                            'مدت زمان باقی مانده:',
                            style: TextStyle(
                              color: Color(0xff46464f),
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '117',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 28,
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 14),
                                  Text(
                                    'روز',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'سود شما',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  ProfitCard(
                    price: '240,000 تومان',
                    title: 'ارسال رایگان',
                    icon: Icon(
                      Icons.delivery_dining_rounded,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  SizedBox(height: 16),
                  ProfitCard(
                    price: '37,000 تومان',
                    title: 'تخفیف مجموعه‌ها',
                    icon: Icon(
                      Icons.percent_rounded,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  SizedBox(height: 16),
                  ProfitCard(
                    price: '60,000 تومان',
                    title: 'کش بک',
                    icon: Icon(
                      Icons.money_off_csred_rounded,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlusHistory(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Color(0xfff1f0f2), width: 1),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'تاریخچه اشتراک‌های شما',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0xff767880),
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfitCard extends StatelessWidget {
  final String price;
  final Widget icon;
  final String title;
  const ProfitCard({
    super.key,
    required this.price,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xfff1f0f2), width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffeff1f8),
                ),
                child: icon,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Text(
                price,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff767880),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlusHistory extends StatelessWidget {
  const PlusHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'تاریخچه',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: GestureDetector(
            child: Icon(
              Icons.chevron_left_rounded,
              size: 40,
              color: Color(0xff5F6266),
            ),
            onTap: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(8.0),
            child: Divider(
              height: 1.0,
              thickness: 2.0,
              color: Color(0xffefeef0),
              indent: 16,
              endIndent: 16, // می‌توانید رنگ را تغییر دهید
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xfff1f0f2), width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'شش ماه',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'فعال',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    HistoryInfoRow(title: 'تاریخ شروع:',value: '1404/03/12'),
                    SizedBox(height: 14,),
                    HistoryInfoRow(title: 'پایان اعتبار:',value: '1404/09/08'),
                    SizedBox(height: 14,),
                    HistoryInfoRow(title: 'هزینه اعتبار:',value: '59,000 تومان'),
                    SizedBox(height: 20,),
                    HistoryInfoRow(title: 'وضعیت پرداخت:',value: 'تایید شده'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryInfoRow extends StatelessWidget {
  final String title;
  final String value;
  const HistoryInfoRow({
    super.key, required this.value, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: Color(0xff767680), fontSize: 14),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ],
    );
  }
}
