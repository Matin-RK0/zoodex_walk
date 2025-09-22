import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoodex_walk/features/homePage/presentation/providers/banner_provider.dart';
import 'package:zoodex_walk/features/homePage/presentation/widgets/banner_slider.dart';
import 'package:zoodex_walk/features/homePage/presentation/widgets/custom_app_bar.dart';
import 'package:zoodex_walk/features/homePage/presentation/widgets/search_box.dart';
import 'package:zoodex_walk/features/homePage/presentation/widgets/slider.dart';
import 'package:zoodex_walk/shared/widgets/test.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BannerProvider _bannerVm;

  @override
  void initState() {
    super.initState();
    // دسترسی به Provider بعد از فریم اول
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bannerVm = context.read<BannerProvider>();
      _bannerVm.loadBanners();
    });
  }

  @override
  Widget build(BuildContext context) {
    // با watch تغییرات را رصد می‌کنیم
    final vm = context.watch<BannerProvider>();

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchBox(),
              if (vm.isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CircularProgressIndicator(),
                )
              else if (vm.error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(vm.error!, style: TextStyle(fontSize: 12)),
                )
              else
                BannerSlider(items: vm.banners),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CurvedCarousel()),
                  );
                },
                child: CustomGradientCardWithCircles(
                  title: 'زودکس پلاس',
                  subtitle: 'مدت زمان باقی‌مانده: 23 روز',
                  onBackPressed: () {},
                ),
              ),
              SizedBox(height: 16),
              AddressCard(),
            ],
          ),
        ),
      ),
    );
  }
}
