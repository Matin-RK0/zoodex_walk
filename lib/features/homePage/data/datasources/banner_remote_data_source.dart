import 'package:dio/dio.dart';
import '../models/banner_model.dart';

abstract class BannerRemoteDataSource {
  Future<List<BannerModel>> fetchBanners();
}

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  final Dio client;
  BannerRemoteDataSourceImpl(this.client);

  @override
  Future<List<BannerModel>> fetchBanners() async {
    final response = await client.get('/pages/kerman/index?with=balance');
    final jsonMap = response.data as Map<String, dynamic>;
    final list = jsonMap['first_slider'] as List<dynamic>;
    return list
        .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
