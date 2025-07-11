import 'package:flutter/material.dart';

//! Main page displaying details in a TabBarView.
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
                      Divider(color: Color(0xffE9EBF5), thickness: 1),
                      //! Using the custom expansion tile for opening hours.
                      StyledExpansionTile(
                        children: [
                          _buildOpeningHoursRow('شنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow('یکشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow('دوشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow('سه‌شنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow('چهارشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow('پنجشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow(
                            'جمعه',
                            'تعطیل است',
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
          color: Colors.grey[200],
          child: const Center(
            child: Icon(Icons.map_outlined, color: Colors.grey, size: 80),
          ),
        ),
        // ... Other Positioned widgets for map buttons would go here ...
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
        SizedBox(width: 30),
        const Text(
          'مسیریابی',
          style: TextStyle(
            color: Color(0xff5F6266),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.north_west, color: Color(0xff5F6266), size: 28),
      ],
    );
  }

  //! Helper: Builds a single opening hours row.
  Widget _buildOpeningHoursRow(
    String day,
    String time, {
    bool isClosed = false,
  }) {
    return Column(
      children: [
        SizedBox(height: 12),
        Row(children: [Text(day, style: TextStyle(color: Colors.black))]),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: Color(0xffE3E6F3)),
                  color: const Color(0xfff5f6fb),
                ),
                child: Center(
                  child: Text(time, style: TextStyle(color: Color(0xff767680))),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ------------------- Custom Widgets -------------------

//! A custom expandable tile with a specific design.
class StyledExpansionTile extends StatefulWidget {
  final List<Widget> children;
  final bool initiallyExpanded;

  const StyledExpansionTile({
    super.key,
    required this.children,
    this.initiallyExpanded = false,
  });

  @override
  State<StyledExpansionTile> createState() => _StyledExpansionTileState();
}

class _StyledExpansionTileState extends State<StyledExpansionTile>
    with SingleTickerProviderStateMixin {
  //! Manages the expanded/collapsed state.
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildHeader(), _buildExpandableContent()],
      ),
    );
  }

  //! Builds the tile's header.
  Widget _buildHeader() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        color: Colors.transparent, // Makes the whole area tappable
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.black, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        'باز است',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Color(0xff5F6266),
                  size: 30,
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text('امروز', style: TextStyle(color: Color(0xff3A4BA8))),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: Color(0xffE3E6F3)),
                      color: const Color(0xfff5f6fb),
                    ),
                    child: Center(
                      child: Text(
                        '۱۱:۳۰ تا ۲۳:۰۰',
                        style: TextStyle(color: Color(0xff767680)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //! Builds the expandable content with animation.
  Widget _buildExpandableContent() {
    //! Animates the expansion and collapse.
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCirc,
      child:
          _isExpanded
              ? Column(
                children: [const SizedBox(height: 0), ...widget.children],
              )
              : const SizedBox.shrink(),
    );
  }
}
