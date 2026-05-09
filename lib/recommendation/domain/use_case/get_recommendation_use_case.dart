import 'package:coffy_shell/recommendation/data/repository/recommendation_repository.dart';
import 'package:coffy_shell/recommendation/domain/entity/recommendation.dart';

class GetRecommendationUseCase {
  final _recommendationRepository = RecommendationRepository();

  Future<List<Recommendation>> call() async {
    return await _recommendationRepository.getRecommendations();
  }
}
