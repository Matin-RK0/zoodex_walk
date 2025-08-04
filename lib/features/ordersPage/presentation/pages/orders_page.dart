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
              child: const Icon(
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
                color: const Color(0xffefeef0),
                indent: 16,
                endIndent: 16,
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
                      color: const Color(0xfff6f6f6),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffffeed7),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                              child: Text(
                                'شش ماه',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'مدت زمان باقی مانده:',
                            style: TextStyle(
                              color: Color(0xff46464f),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Row(
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
                  const SizedBox(height: 16),
                  const Text(
                    'سود شما',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ProfitCard(
                    price: '240,000 تومان',
                    title: 'ارسال رایگان',
                    icon: Icon(
                      Icons.delivery_dining_rounded,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ProfitCard(
                    price: '37,000 تومان',
                    title: 'تخفیف مجموعه‌ها',
                    icon: Icon(
                      Icons.percent_rounded,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ProfitCard(
                    price: '60,000 تومان',
                    title: 'کش بک',
                    icon: Icon(
                      Icons.money_off_csred_rounded,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  //! Navigate to the subscription history page on tap.
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
                        border: Border.all(color: const Color(0xfff1f0f2), width: 1),
                      ),
                      child: const Row(
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

//! A reusable card widget to display different types of profit.
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
        border: Border.all(color: const Color(0xfff1f0f2), width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffeff1f8),
                ),
                child: icon,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                price,
                style: const TextStyle(
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

class PlusHistory extends StatefulWidget {
  const PlusHistory({super.key});

  @override
  State<PlusHistory> createState() => _PlusHistoryState();
}

class _PlusHistoryState extends State<PlusHistory> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    //! Always dispose of the controller to prevent memory leaks.
    _scrollController.dispose();
    super.dispose();
  }

  //! This function programmatically scrolls the content to the top.
  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'تاریخچه',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: GestureDetector(
            child: const Icon(
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
              color: const Color(0xffefeef0),
              indent: 16,
              endIndent: 16,
            ),
          ),
        ),
        body: SingleChildScrollView(
          //! The ScrollController is attached to the parent scrollable widget.
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListView.builder(
                  //! --- Important settings for nested ListView ---
                  //! 1. shrinkWrap allows the ListView to size itself to its content.
                  shrinkWrap: true,
                  //! 2. This physics prevents the ListView from being scrollable itself,
                  //!    avoiding conflicts with the parent SingleChildScrollView.
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return const PlusHistoryCard();
                  },
                ),
                const SizedBox(height: 16),
                //! This button triggers the scroll-to-top action.
                IconButton(
                  onPressed: _scrollToTop,
                  icon: const Icon(
                    Icons.arrow_upward_rounded,
                    size: 36,
                    color: Color(0xff767880),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//! A card to display a single item in the subscription history.
class PlusHistoryCard extends StatelessWidget {
  const PlusHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xfff1f0f2), width: 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'شش ماه',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'فعال',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const HistoryInfoRow(title: 'تاریخ شروع:', value: '1404/03/12'),
            const SizedBox(height: 14),
            const HistoryInfoRow(title: 'پایان اعتبار:', value: '1404/09/08'),
            const SizedBox(height: 14),
            const HistoryInfoRow(title: 'هزینه اعتبار:', value: '59,000 تومان'),
            const SizedBox(height: 20),
            const HistoryInfoRow(title: 'وضعیت پرداخت:', value: 'تایید شده'),
          ],
        ),
      ),
    );
  }
}

//! A reusable row for displaying key-value information with conditional text color.
class HistoryInfoRow extends StatelessWidget {
  final String title;
  final String value;
  const HistoryInfoRow({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: const TextStyle(color: Color(0xff767680), fontSize: 14)),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            //! Dynamically change color based on the payment status text.
            color:
                value == 'تایید شده'
                    ? Colors.green
                    : (value == 'لغو شده' ? Colors.red : Colors.black),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}