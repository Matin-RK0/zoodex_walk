import 'package:flutter/material.dart';

//! Main page displaying details in a TabBarView.
class StoreMenuMorePage extends StatefulWidget {
  const StoreMenuMorePage({super.key});

  @override
  State<StoreMenuMorePage> createState() => _StoreMenuMorePageState();
}

class _StoreMenuMorePageState extends State<StoreMenuMorePage> {
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
            title: const Text(
              'توضیحات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left_rounded,
                size: 40,
                color: Color(0xff5F6266),
              ),
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
                  child: Text(
                    'اطلاعات مجموعه',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                Tab(
                  child: Text(
                    'نظرات کاربران',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              //! Tab 1: Info Page Content.
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'اطلاعات مجموعه',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildMapSection(),
                      const SizedBox(height: 16),
                      _buildAddressSection(),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xffE9EBF5), thickness: 1),
                      const SizedBox(height: 16),
                      //! Using the custom expansion tile for opening hours.
                      StyledExpansionTile(
                        headerDay: 'امروز',
                        headerTime: '۱۱:۳۰ تا ۲۳:۰۰',
                        isOpen: true,
                        children: const [
                          OpeningHoursRow(day: 'شنبه', time: '۱۱:۳۰ تا ۲۳:۰۰'),
                          OpeningHoursRow(
                            day: 'یکشنبه',
                            time: '۱۱:۳۰ تا ۲۳:۰۰',
                          ),
                          OpeningHoursRow(
                            day: 'دوشنبه',
                            time: '۱۱:۳۰ تا ۲۳:۰۰',
                          ),
                          OpeningHoursRow(
                            day: 'سه‌شنبه',
                            time: '۱۱:۳۰ تا ۲۳:۰۰',
                          ),
                          OpeningHoursRow(
                            day: 'چهارشنبه',
                            time: '۱۱:۳۰ تا ۲۳:۰۰',
                          ),
                          OpeningHoursRow(
                            day: 'پنجشنبه',
                            time: '۱۱:۳۰ تا ۲۳:۰۰',
                          ),
                          OpeningHoursRow(
                            day: 'جمعه',
                            time: 'تعطیل است',
                            isClosed: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              //! Tab 2: Comments Page Content.
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

  //! Helper: Builds the map placeholder.
  Widget _buildMapSection() {
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(Icons.map_outlined, color: Colors.grey, size: 80),
          ),
        ),
      ],
    );
  }

  //! Helper: Builds the address row.
  Widget _buildAddressSection() {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: Color(0xff5F6266),
          size: 28,
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Text(
            'بلوار جمهوری سه راه حمزه بلوار...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 30),
        const Text(
          'مسیریابی',
          style: TextStyle(
            color: Color(0xff5F6266),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.north_west, color: Color(0xff5F6266), size: 36),
      ],
    );
  }
}

//! A custom expandable tile with a specific design.
class StyledExpansionTile extends StatefulWidget {
  final List<Widget> children;
  final bool initiallyExpanded;
  final String headerDay;
  final String headerTime;
  final bool isOpen;

  const StyledExpansionTile({
    super.key,
    required this.children,
    this.initiallyExpanded = false,
    required this.headerDay,
    required this.headerTime,
    required this.isOpen,
  });

  @override
  State<StyledExpansionTile> createState() => _StyledExpansionTileState();
}

class _StyledExpansionTileState extends State<StyledExpansionTile>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildTappableHeader(), _buildConditionalContent()],
      ),
    );
  }

  //! Builds the always-visible, tappable part of the header.
  Widget _buildTappableHeader() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        color: Colors.transparent, // Makes the whole area tappable
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
              decoration: BoxDecoration(
                color:
                    widget.isOpen
                        ? Colors.green.shade100.withOpacity(0.7)
                        : Colors.red.shade100.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: Colors.black, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    widget.isOpen ? 'باز است' : 'بسته است',
                    style: TextStyle(
                      color: Colors.black, // رنگ متن بر اساس وضعیت
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              _isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: const Color(0xff5F6266),
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

  //! Builds the content that switches between "Today" and the children list.
  Widget _buildConditionalContent() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ), // No horizontal padding needed here
        child: Column(
          children: [
            // اگر بسته است، فقط اطلاعات امروز را با رنگ آبی نشان بده
            if (!_isExpanded)
              OpeningHoursRow(
                day: widget.headerDay,
                time: widget.headerTime,
                dayColor: Color(0xff3A4BA8), // <--- تغییر کلیدی اینجاست
              ),

            // اگر باز است، فقط لیست فرزندان را نشان بده
            if (_isExpanded) Column(children: [...widget.children]),

            // اگر بسته است، فاصله‌ای در پایین ایجاد نکن
            if (_isExpanded) const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

//! A reusable widget to display a single row of opening hours.
class OpeningHoursRow extends StatelessWidget {
  final String day;
  final String time;
  final bool isClosed;
  final Color? dayColor; // پارامتر جدید برای رنگ روز

  const OpeningHoursRow({
    super.key,
    required this.day,
    required this.time,
    this.isClosed = false,
    this.dayColor, // اضافه شدن به سازنده
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: TextStyle(
              // اگر رنگی پاس داده شده بود از آن استفاده کن، در غیر این صورت از رنگ پیش‌فرض
              color: dayColor ?? Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          isClosed
              ? Center(
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              )
              : Container(
                height: 34,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: const Color(0xffE3E6F3)),
                  color: const Color(0xfff5f6fb),
                ),
                child: Center(
                  child: Text(
                    time,
                    style: const TextStyle(
                      color: Color(0xff767680),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
