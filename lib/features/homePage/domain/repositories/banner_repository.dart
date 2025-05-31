import 'package:dartz/dartz.dart';
import 'package:zoodex_walk/core/error/failure.dart';
import '../entities/banner_item.dart';

/// قراردادی برای دریافت لیست بنرها
abstract class BannerRepository {
  /// فراخوانی API برای گرفتن بنرها
  /// در صورت موفقیت، لیستی از [BannerItem] را بر می‌گرداند،
  /// در غیر این صورت یک [Failure] با دلیل خطا.
  Future<Either<Failure, List<BannerItem>>> getBanners();
}
