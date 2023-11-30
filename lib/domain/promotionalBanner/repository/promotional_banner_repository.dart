import 'package:sign_in_bloc/infrastructure/presentation/homePage/widgets/promotional_banner.dart';

abstract class PromotionalBannerRepository {
  Future<PromotionalBanner> getPromotionalBanner();
}
