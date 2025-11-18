import 'package:flutter/foundation.dart';

/// Simple logger utility
class Logger {
  static void log(String message, {String? tag}) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String();
      final logTag = tag != null ? '[$tag]' : '';
      print('[$timestamp]$logTag $message');
    }
  }

  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String();
      final logTag = tag != null ? '[$tag]' : '';
      print('[$timestamp]$logTag ERROR: $message');
      if (error != null) {
        print('Error: $error');
      }
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
    }
  }

  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String();
      final logTag = tag != null ? '[$tag]' : '';
      print('[$timestamp]$logTag WARNING: $message');
    }
  }

  static void info(String message, {String? tag}) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String();
      final logTag = tag != null ? '[$tag]' : '';
      print('[$timestamp]$logTag INFO: $message');
    }
  }

  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String();
      final logTag = tag != null ? '[$tag]' : '';
      print('[$timestamp]$logTag DEBUG: $message');
    }
  }
}
