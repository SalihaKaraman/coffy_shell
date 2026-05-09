import 'package:flutter/material.dart';
import 'package:coffy_shell/recommendation/presentation/mvvm/recommendation_view_model.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  late final RecommendationViewModel recommendationViewModel;

  @override
  void initState() {
    super.initState();
    recommendationViewModel = RecommendationViewModel();
    recommendationViewModel.fetchRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: recommendationViewModel,
      builder: (context, child) {
        if (recommendationViewModel.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: recommendationViewModel.recommendations.length,
          itemBuilder: (context, index) {
            final recommendation = recommendationViewModel.recommendations[index];
            return ListTile(title: Text(recommendation.answer ?? ''));
          },
        );
      },
    );
  }
}
