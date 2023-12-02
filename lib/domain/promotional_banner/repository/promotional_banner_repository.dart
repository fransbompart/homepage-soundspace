import '../promotional_banner.dart';
import '../../../result.dart';

abstract class PromotionalBannerRepository {
  Future<Result<PromotionalBanner>> getPromotionalBanner();
}
