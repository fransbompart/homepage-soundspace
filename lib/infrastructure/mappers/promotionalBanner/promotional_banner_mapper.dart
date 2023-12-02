import '../../../domain/promotional_banner/promotional_banner.dart';

class PromotionalBannerMapper {
  static PromotionalBanner fromJson(Map<String, dynamic> json) {
    return PromotionalBanner(imgPath: json['referencia_imagen']);
  }

  static Map<String, dynamic> toJson(PromotionalBanner promotionalBanner) {
    return {
      'referencia_imagen': promotionalBanner.imgPath,
    };
  }
}
