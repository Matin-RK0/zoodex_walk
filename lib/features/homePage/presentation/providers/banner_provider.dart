import 'package:flutter/material.dart';
import 'package:zoodex_walk/core/error/failure.dart';
import '../../domain/entities/banner_item.dart';
import '../../domain/usecases/get_banners_usecase.dart';

class BannerProvider extends ChangeNotifier {
  final GetBannersUseCase getBanners;
  List<BannerItem> banners = [];
  bool isLoading = false;
  String? error;

  BannerProvider(this.getBanners);

  Future<void> loadBanners() async {
    isLoading = true; notifyListeners();
    final result = await getBanners();
    result.fold(
      (Failure f) => error = 'خطا در دریافت بنرها',
      (List<BannerItem> data) => banners = data,
    );
    isLoading = false; notifyListeners();
  }
}
