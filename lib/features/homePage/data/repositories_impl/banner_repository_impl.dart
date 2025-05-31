import 'package:dartz/dartz.dart';
import 'package:zoodex_walk/core/error/failure.dart';
import 'package:zoodex_walk/features/homePage/domain/repositories/banner_repository.dart';
import '../../domain/entities/banner_item.dart';
import '../datasources/banner_remote_data_source.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource remote;
  BannerRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<BannerItem>>> getBanners() async {
    try {
      final models = await remote.fetchBanners();
      final items = models.map((m) => m.toEntity()).toList();
      return Right(items);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
