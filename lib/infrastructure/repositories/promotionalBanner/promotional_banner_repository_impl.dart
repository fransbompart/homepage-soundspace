import '../../../domain/promotional_banner/promotional_banner.dart';
import '../../../domain/promotional_banner/repository/promotional_banner_repository.dart';
import '../../../infrastructure/mappers/promotional_banner_mapper.dart';
import '../../../infrastructure/services/network_manager.dart';
import '../../../result.dart';

class PromotionalBannerImpl extends PromotionalBannerRepository {
  final NetworkManager networkManager = NetworkManager(
      apiPath:
          'https://soundspace-api-production.up.railway.app/api/'); //mejorar esto

  @override
  Future<Result<PromotionalBanner>> getPromotionalBanner() async {
    final result = await networkManager.getRequest('publicidad');
    if (result.hasValue()) {
      return Result(
          value: PromotionalBannerMapper.fromJson(result.value.data['data']),
          error: null);
    } else {
      return Result(value: null, error: Error());
    }
  }
}
