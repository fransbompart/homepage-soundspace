import '../promotional_banner.dart';
import '../../../commons/result.dart';

abstract class PromotionalBannerRepository {
  Future<Result<PromotionalBanner>> getPromotionalBanner();
}
