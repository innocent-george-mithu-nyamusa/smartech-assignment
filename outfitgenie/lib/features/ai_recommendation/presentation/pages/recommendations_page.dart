import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../domain/entities/recommendation_request.dart';
import '../bloc/recommendation_bloc.dart';
import '../bloc/recommendation_event.dart';
import '../bloc/recommendation_state.dart';
import '../widgets/outfit_card.dart';

/// Recommendations page
class RecommendationsPage extends StatelessWidget {
  final RecommendationRequest? request;

  const RecommendationsPage({
    super.key,
    this.request,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RecommendationBloc>()
        ..add(request != null
            ? GetRecommendations(request!)
            : const GetRecommendationsByOccasion(occasion: 'casual')),
      child: const _RecommendationsView(),
    );
  }
}

class _RecommendationsView extends StatefulWidget {
  const _RecommendationsView();

  @override
  State<_RecommendationsView> createState() => _RecommendationsViewState();
}

class _RecommendationsViewState extends State<_RecommendationsView> {
  String _selectedOccasion = 'casual';
  final List<String> _occasions = [
    'casual',
    'formal',
    'business',
    'party',
    'sports',
    'outdoor',
    'date',
    'wedding',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outfit Recommendations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              context.read<RecommendationBloc>().add(const LoadFavorites());
            },
            tooltip: 'View Favorites',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildOccasionSelector(),
          Expanded(
            child: BlocConsumer<RecommendationBloc, RecommendationState>(
              listener: (context, state) {
                if (state is RecommendationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        label: 'Retry',
                        textColor: Colors.white,
                        onPressed: () {
                          context.read<RecommendationBloc>().add(
                                GetRecommendationsByOccasion(
                                  occasion: _selectedOccasion,
                                ),
                              );
                        },
                      ),
                    ),
                  );
                } else if (state is FavoriteSaved) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to favorites!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (state is FavoriteRemoved) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Removed from favorites'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is RecommendationLoading) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Getting outfit recommendations...'),
                      ],
                    ),
                  );
                } else if (state is RecommendationsLoaded) {
                  return _buildRecommendationsList(context, state);
                } else if (state is FavoritesLoaded) {
                  return _buildFavoritesList(context, state);
                } else if (state is RecommendationsEmpty) {
                  return _buildEmptyState(context);
                } else if (state is RecommendationError) {
                  return _buildErrorState(context, state.message);
                }
                return _buildInitialState(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOccasionSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Occasion',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _occasions.length,
              itemBuilder: (context, index) {
                final occasion = _occasions[index];
                final isSelected = occasion == _selectedOccasion;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      occasion.substring(0, 1).toUpperCase() +
                          occasion.substring(1),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedOccasion = occasion;
                        });
                        context.read<RecommendationBloc>().add(
                              GetRecommendationsByOccasion(
                                occasion: occasion,
                              ),
                            );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsList(
    BuildContext context,
    RecommendationsLoaded state,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<RecommendationBloc>().add(
              GetRecommendationsByOccasion(occasion: _selectedOccasion),
            );
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.recommendations.length,
        itemBuilder: (context, index) {
          final recommendation = state.recommendations[index];
          return OutfitCard(
            recommendation: recommendation,
            onFavorite: () {
              context
                  .read<RecommendationBloc>()
                  .add(SaveFavorite(recommendation.id));
            },
          );
        },
      ),
    );
  }

  Widget _buildFavoritesList(BuildContext context, FavoritesLoaded state) {
    if (state.favorites.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No favorites yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Start favoriting outfits!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<RecommendationBloc>().add(
                      GetRecommendationsByOccasion(
                        occasion: _selectedOccasion,
                      ),
                    );
              },
              child: const Text('Browse Outfits'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.favorites.length,
      itemBuilder: (context, index) {
        final recommendation = state.favorites[index];
        return OutfitCard(
          recommendation: recommendation,
          isFavorite: true,
          onFavorite: () {
            context
                .read<RecommendationBloc>()
                .add(RemoveFavorite(recommendation.id));
          },
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No recommendations found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Try selecting a different occasion',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<RecommendationBloc>().add(
                      GetRecommendationsByOccasion(
                        occasion: _selectedOccasion,
                      ),
                    );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.checkroom,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Ready to find your perfect outfit?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Select an occasion above to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
