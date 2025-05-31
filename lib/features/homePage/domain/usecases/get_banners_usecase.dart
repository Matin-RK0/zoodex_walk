import 'package:dartz/dartz.dart';
import 'package:zoodex_walk/core/error/failure.dart';
import 'package:zoodex_walk/features/homePage/domain/repositories/banner_repository.dart';
import '../entities/banner_item.dart';

class GetBannersUseCase {
  final BannerRepository repository;
  GetBannersUseCase(this.repository);

  Future<Either<Failure, List<BannerItem>>> call() {
    return repository.getBanners();
  }
}
