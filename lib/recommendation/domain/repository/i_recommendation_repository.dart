import 'package:coffy_shell/recommendation/domain/entity/recommendation.dart';

abstract class IRecommendationRepository {
  Future<List<Recommendation>> getRecommendations();
}
