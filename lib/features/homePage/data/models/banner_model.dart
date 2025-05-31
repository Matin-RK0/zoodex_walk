import '../../domain/entities/banner_item.dart';

class BannerModel {
  final int id;
  final String title;
  final String alt;
  final String url;
  final String imagePath;

  BannerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        alt = json['alt'],
        url = json['url'],
        imagePath = json['image_path'];

  BannerItem toEntity() {
    return BannerItem(
      id: id,
      title: title,
      alt: alt,
      url: url,
      imagePath: imagePath,
    );
  }
}
