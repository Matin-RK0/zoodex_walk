// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'dart:math' as math;

class StoreMenuMorePage extends StatefulWidget {
  const StoreMenuMorePage({super.key});

  @override
  State<StoreMenuMorePage> createState() => _StoreMenuMorePageState();
}

class _StoreMenuMorePageState extends State<StoreMenuMorePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

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
                if (Navigator.canPop(context)) Navigator.pop(context);
              },
            ),
            bottom: const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              indicatorColor: Color(0xff3a4ba8),
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
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
              SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'اطلاعات مجموعه',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildMapSection(), //! Display map
                      const SizedBox(height: 16),
                      _buildAddressSection(), //! Display address and navigation button
                      const SizedBox(height: 8),
                      const Divider(color: Color(0xffE9EBF5), thickness: 1),
                      const SizedBox(height: 16),
                      StyledExpansionTile(
                        todayKey: 'سه‌شنبه', //! Specify which day is today
                        isOpen: true,
                        openingHours: {
                          'شنبه': '۱۱:۳۰ تا ۲۳:۰۰',
                          'یکشنبه': '۱۱:۳۰ تا ۲۳:۰۰',
                          'دوشنبه': '۱۱:۳۰ تا ۲۳:۰۰',
                          'سه‌شنبه': '۱۱:۳۰ تا ۲۳:۰۰',
                          'چهارشنبه': '۱۱:۳۰ تا ۲۳:۰۰',
                          'پنجشنبه': '۱۱:۳۰ تا ۲۳:۰۰',
                          'جمعه': 'تعطیل است',
                        },
                        onExpansionChanged: (isExpanded) {
                          if (isExpanded) {
                            // اگر ویجت باز شد، به پایین اسکرول کن
                            _scrollToBottom();
                          }
                        },
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 16),
                  RatingsSummaryCard(
                    //! User rating summary
                    averageRating: 4.5,
                    reviewCount: 120,
                    ratingPercentages: [0.15, 0.35, 0.80, 0.90, 0.75],
                  ),
                  SizedBox(height: 20),
                  UserReviewCard(
                    //! Example user review card
                    userName: 'سلطانی',
                    rating: 3.5,
                    date: '۱۴۰۳/۰۳/۰۸',
                    reviewText:
                        'به جز کوبیده مرغ که پر از ادویه و سفت بود بقیه خوش طعم و عالی بودن',
                    tags: ['چلو قالبی ایرانی', 'دیس کباب', 'دنبه'],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            child: Icon(Icons.map_outlined, size: 80, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 28,
          color: Color(0xff5F6266),
        ),
        const SizedBox(width: 8),
        Expanded(
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
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff5F6266),
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.north_west, size: 36, color: Color(0xff5F6266)),
      ],
    );
  }
}

class StyledExpansionTile extends StatefulWidget {
  /// All opening hours data
  final Map<String, String> openingHours;
  final bool initiallyExpanded;
  final String todayKey; //! Key for today's day
  final bool isOpen;
  final Function(bool isExpanded)? onExpansionChanged;

  const StyledExpansionTile({
    super.key,
    required this.openingHours,
    this.initiallyExpanded = false,
    required this.todayKey,
    required this.isOpen,
    this.onExpansionChanged,
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

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    widget.onExpansionChanged?.call(_isExpanded);
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
        children: [
          _buildHeader(), //! Tappable header
          _buildContent(), //! Expandable animated content
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return GestureDetector(
      onTap: _toggleExpansion, //! Toggle state
      child: Container(
        color: Colors.transparent,
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
                  const Icon(Icons.access_time, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    widget.isOpen ? 'باز است' : 'بسته است',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              _isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              size: 40,
              color: const Color(0xff5F6266),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: Column(
        children: [
          // When collapsed, show only today's row with highlight
          if (!_isExpanded)
            _buildRow(
              widget.todayKey,
              widget.openingHours[widget.todayKey]!,
              highlight: true,
            ),
          // When expanded, show all days
          if (_isExpanded)
            ...widget.openingHours.entries.map((e) {
              final isToday = e.key == widget.todayKey;
              return _buildRow(e.key, e.value, highlight: isToday);
            }),
          if (_isExpanded) const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Builds a single row with working hours, highlighted if [highlight] is true
  Widget _buildRow(String day, String time, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: TextStyle(
              color:
                  highlight
                      ? Color(0xff3a4ba8)
                      : Colors.black, //! Day text color
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 34,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1, color: Color(0xffE3E6F3)),
              color:
                  highlight
                      ? const Color(0xffF5F6FB) //! Different background color
                      : Colors.white,
            ),
            child: Center(
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff767680), //! Different text color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingsSummaryCard extends StatelessWidget {
  final double averageRating;
  final int reviewCount;
  final List<double> ratingPercentages;

  const RatingsSummaryCard({
    super.key,
    required this.averageRating,
    required this.reviewCount,
    required this.ratingPercentages,
  }) : assert(ratingPercentages.length == 5);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xffe3e6f3)),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildSummary(),
                ), //! Rating summary section
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: _buildBars(),
                ), //! Rating percentage bars
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '/5',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w700,
              ),
              textDirection: TextDirection.ltr,
            ),
            Text(
              ' $averageRating',
              style: const TextStyle(
                fontSize: 24,
                color: Color(0xFF3a4ba8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '$reviewCount نظر طبق عملکرد سه ماهه اخیر مجموعه',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        _buildStars(averageRating), //! Star rating display
        SizedBox(height: 26),
      ],
    );
  }

  Widget _buildBars() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (i) {
        int star = i + 1;
        return Row(
          children: [
            Text(
              '.$star',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(width: 6),
            const Icon(Icons.star, size: 20, color: Colors.amber),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFe8e9e9),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: ratingPercentages[i],
                    minHeight: 8,
                    backgroundColor: Colors.white,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF3a4ba8)),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStars(double rating) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        IconData icon;
        if (rating >= i + 1) {
          icon = Icons.star;
        } else if (rating > i)
          icon = Icons.star_half;
        else
          icon = Icons.star_border;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: Icon(icon, size: 24, color: Colors.amber),
        );
      }),
    );
  }
}

class UserReviewCard extends StatelessWidget {
  final String userName;
  final double rating;
  final String date;
  final String reviewText;
  final List<String> tags;

  const UserReviewCard({
    super.key,
    required this.userName,
    required this.rating,
    required this.date,
    required this.reviewText,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(), //! Review card header
          const SizedBox(height: 16),
          Text(
            reviewText,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ), //! Review text
          const SizedBox(height: 16),
          _buildTags(), //! Tag layout
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(2, 2, 6, 2),
              decoration: BoxDecoration(
                color: const Color(0xffeff1f8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.star_rounded, size: 24, color: Colors.amber),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              userName,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          date,
          style: const TextStyle(fontSize: 17, color: Color(0xff767680)),
        ), //! Review date
      ],
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children:
          tags.map((label) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE3E6F3)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff767680),
                ),
              ),
            );
          }).toList(),
    );
  }
}
