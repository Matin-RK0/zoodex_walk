import 'package:flutter/material.dart';

class CustomGradientCardWithCircles extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBackPressed;

  const CustomGradientCardWithCircles({
    super.key,
    this.title = 'زودکس پلاس',
    this.subtitle = 'مدت زمان باقی‌مانده: 23 روز',
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xFFF8B401)),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFF8B401)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned(
                top: 25,
                right: -300,
                child: Container(
                  width: 780,
                  height: 780,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.20),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 55,
                right: -260,
                child: Container(
                  width: 680,
                  height: 680,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.20),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 85,
                right: -220,
                child: Container(
                  width: 580,
                  height: 580,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.20),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: onBackPressed,
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.grey.shade600,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
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

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: const Color(0xfff8f9fa),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min, //! Fit height to content
              crossAxisAlignment:
                  CrossAxisAlignment.start, //! Align content right
              children: [
                Row(
                  children: [
                    // wrap both parts inside a Flexible so they share available width
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // the repeated “شرکت”
                          Flexible(
                            child: Text(
                              'شرکت' * 8,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis, //! truncate long text
                            ),
                          ),
                          const SizedBox(width: 2),
                          // the suffix
                          const Text(
                            '(کرمان)',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color(0xff767680),
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    GestureDetector(
                      onTap: () {}, //! Edit action
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Color(0xff767680),
                      ),
                    ),
                    const SizedBox(width: 14),
                    GestureDetector(
                      onTap: () {}, //! Delete action
                      child: const Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: Color(0xff767680),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'میدان قرنی، ساختمان پدر، طبقه ۵، واحد ۵۰۱ شرکت زودکس',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          height: 1.5, //! Line height for readability
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      //! allow text to use available space
                      child: Text(
                        'فریبا قطبی تیم فنی' * 8,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff767680),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1, //! limit to single line
                        overflow: TextOverflow.ellipsis, //! truncate with “…”
                      ),
                    ),
                    const SizedBox(width: 32), //! small gap
                    Text(
                      '۰۹۳۸۳۸۸۲۸۳۲',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff767680),
                        letterSpacing:
                            0.5, //! Slight spacing for phone readability
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
