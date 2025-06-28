import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 8),
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
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
            Row(
              children: [
                const Text(
                  'امروز',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                  size: 30,
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
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: _isExpanded
          ? Column(
              children: [
                const SizedBox(height: 8),
                const Divider(),
                ...widget.children,
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

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
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: [
                Tab(child: Text('اطلاعات مجموعه', style: TextStyle(fontSize: 14))),
                Tab(child: Text('نظرات کاربران', style: TextStyle(fontSize: 14))),
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
                      //! Using the custom expansion tile for opening hours.
                      StyledExpansionTile(
                        children: [
                          _buildOpeningHoursRow('شنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow('یکشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow('دوشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow('سه‌شنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow('چهارشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow('پنجشنبه', '۱۱:۳۰ تا ۲۳:۰۰'),
                          _buildOpeningHoursRow('جمعه', 'تعطیل است', isClosed: true),
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
}

//! Helper: Builds the map placeholder.
Widget _buildMapSection() {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 250,
          color: Colors.grey[200],
          child: const Center(
            child: Icon(Icons.map_outlined, color: Colors.grey, size: 80),
          ),
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
      const Icon(Icons.location_on_outlined, color: Colors.grey, size: 28),
      const SizedBox(width: 8),
      const Expanded(
        child: Text(
          'بلوار جمهوری سه راه حمزه بلوار...',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const Text(
        'مسیریابی',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(width: 4),
      const Icon(Icons.directions, color: Colors.blue, size: 28),
    ],
  );
}

//! Helper: Builds a single opening hours row.
Widget _buildOpeningHoursRow(String day, String time, {bool isClosed = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
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
            : Text(
                time,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
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