/// Application-wide constants
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  /// App Information
  static const String appName = 'OutfitGenie';
  static const String appVersion = '1.0.0';

  /// Storage Keys
  static const String userProfileKey = 'user_profile';
  static const String userPreferencesKey = 'user_preferences';
  static const String themeKey = 'theme_mode';
  static const String onboardingCompletedKey = 'onboarding_completed';

  /// Occasion Types
  static const List<String> occasionTypes = [
    'Casual',
    'Formal',
    'Business',
    'Party',
    'Sports',
    'Beach',
    'Date',
    'Wedding',
    'Interview',
    'Other',
  ];

  /// Style Types
  static const List<String> styleTypes = [
    'Classic',
    'Casual',
    'Sporty',
    'Elegant',
    'Bohemian',
    'Vintage',
    'Minimalist',
    'Streetwear',
    'Preppy',
    'Romantic',
  ];

  /// Weather Conditions
  static const List<String> weatherConditions = [
    'Sunny',
    'Cloudy',
    'Rainy',
    'Snowy',
    'Windy',
    'Hot',
    'Cold',
    'Mild',
  ];

  /// Color Categories
  static const List<String> colorCategories = [
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Orange',
    'Purple',
    'Pink',
    'Brown',
    'Black',
    'White',
    'Gray',
    'Beige',
    'Navy',
    'Maroon',
  ];

  /// Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  /// Cache Duration
  static const Duration cacheValidDuration = Duration(hours: 1);
  static const Duration weatherCacheDuration = Duration(minutes: 30);
}
