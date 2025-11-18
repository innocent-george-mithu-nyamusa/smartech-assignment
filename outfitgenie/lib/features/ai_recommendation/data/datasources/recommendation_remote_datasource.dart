import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/outfit_recommendation_model.dart';
import '../models/recommendation_request_model.dart';

/// Recommendation remote data source interface
abstract class RecommendationRemoteDataSource {
  /// Get recommendations from backend
  Future<List<OutfitRecommendationModel>> getRecommendations(
    RecommendationRequestModel request,
  );

  /// Get recommendations by occasion
  Future<List<OutfitRecommendationModel>> getRecommendationsByOccasion({
    required String occasion,
    String? style,
    List<String>? colors,
  });
}

/// Recommendation remote data source implementation
class RecommendationRemoteDataSourceImpl implements RecommendationRemoteDataSource {
  final Dio dio;

  RecommendationRemoteDataSourceImpl(this.dio);

  @override
  Future<List<OutfitRecommendationModel>> getRecommendations(
    RecommendationRequestModel request,
  ) async {
    try {
      final response = await dio.post(
        '${ApiConstants.backendBaseUrl}${ApiConstants.recommendationsEndpoint}',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': ApiConstants.contentType,
            'Accept': ApiConstants.accept,
          },
          sendTimeout: ApiConstants.sendTimeout,
          receiveTimeout: ApiConstants.receiveTimeout,
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['success'] == true && data['recommendations'] != null) {
          final recommendations = (data['recommendations'] as List)
              .map((json) => OutfitRecommendationModel.fromJson(json))
              .toList();
          return recommendations;
        } else {
          throw ServerException(
            data['message'] ?? 'Failed to get recommendations',
          );
        }
      } else {
        throw ServerException(
          'Server returned ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException('No internet connection');
      } else {
        throw ServerException(
          'Failed to get recommendations: ${e.message}',
          e.response?.statusCode.toString(),
        );
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<OutfitRecommendationModel>> getRecommendationsByOccasion({
    required String occasion,
    String? style,
    List<String>? colors,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'occasion': occasion,
        if (style != null) 'style': style,
        if (colors != null) 'colors': colors,
      };

      final response = await dio.post(
        '${ApiConstants.backendBaseUrl}${ApiConstants.recommendByOccasionEndpoint}',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Content-Type': ApiConstants.contentType,
            'Accept': ApiConstants.accept,
          },
          sendTimeout: ApiConstants.sendTimeout,
          receiveTimeout: ApiConstants.receiveTimeout,
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['recommendations'] != null) {
          final recommendations = (data['recommendations'] as List)
              .map((json) => OutfitRecommendationModel.fromJson(json))
              .toList();
          return recommendations;
        } else {
          return [];
        }
      } else {
        throw ServerException(
          'Server returned ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const NetworkException('Connection timeout');
      } else {
        throw ServerException(
          'Failed to get recommendations: ${e.message}',
          e.response?.statusCode.toString(),
        );
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}
