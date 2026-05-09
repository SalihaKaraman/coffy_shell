import 'package:coffy_shell/recommendation/domain/entity/recommendation.dart';

class RecommendationModel {
  final String? answer;

  RecommendationModel({this.answer});

  Recommendation toEntity() {
    return Recommendation(answer: answer);
  }
}
