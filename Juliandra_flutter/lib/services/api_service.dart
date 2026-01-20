import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/agenda.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api';

  // Helper function to convert any type to bool
  // Handles String "true"/"false", bool, int 0/1, etc.
  static bool _toBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value == 1 || value == true;
    if (value is String) {
      return value.toLowerCase() == 'true' || value == '1';
    }
    return false;
  }

  // Get all agendas
  static Future<List<Agenda>> getAllAgendas() async {
    final response = await http.get(Uri.parse('$baseUrl/agenda'));
    
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      
      // Handle case where response might be a List directly (no wrapper)
      if (jsonResponse is List) {
        return jsonResponse.map((item) => Agenda.fromJson(item)).toList();
      }
      
      // Handle case where response might be wrapped with success field
      if (jsonResponse is Map<String, dynamic>) {
        // Check if 'success' field exists and handle different types
        if (jsonResponse.containsKey('success')) {
          bool success = _toBool(jsonResponse['success']);
          if (success && jsonResponse['data'] != null) {
            List<dynamic> data = jsonResponse['data'];
            return data.map((item) => Agenda.fromJson(item)).toList();
          }
          throw Exception(jsonResponse['message'] ?? 'Failed to load agendas');
        }
        
        // If no 'success' field but has 'data' field, assume success
        if (jsonResponse.containsKey('data')) {
          List<dynamic> data = jsonResponse['data'];
          return data.map((item) => Agenda.fromJson(item)).toList();
        }
      }
      
      throw Exception('Invalid response format');
    } else {
      throw Exception('Failed to load agendas: ${response.statusCode}');
    }
  }

  // Get single agenda
  static Future<Agenda> getAgenda(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/agenda/$id'));
    
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      
      // Handle case where response might be wrapped with success field
      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('success')) {
        bool success = _toBool(jsonResponse['success']);
        if (success && jsonResponse['data'] != null) {
          return Agenda.fromJson(jsonResponse['data']);
        }
        throw Exception(jsonResponse['message'] ?? 'Failed to load agenda');
      }
      
      // If response is the agenda object directly (no wrapper)
      if (jsonResponse is Map<String, dynamic>) {
        return Agenda.fromJson(jsonResponse);
      }
      
      throw Exception('Invalid response format');
    } else if (response.statusCode == 404) {
      final jsonResponse = json.decode(response.body);
      throw Exception(jsonResponse['message'] ?? 'Agenda not found');
    } else {
      throw Exception('Failed to load agenda: ${response.statusCode}');
    }
  }

  // Create agenda
  static Future<Agenda> createAgenda(Agenda agenda) async {
    final response = await http.post(
      Uri.parse('$baseUrl/agenda'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(agenda.toCreateJson()),
    );
    
    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      
      // Handle case where response might be wrapped with success field
      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('success')) {
        bool success = _toBool(jsonResponse['success']);
        if (success && jsonResponse['data'] != null) {
          return Agenda.fromJson(jsonResponse['data']);
        }
        throw Exception(jsonResponse['message'] ?? 'Failed to create agenda');
      }
      
      // If response is the agenda object directly (no wrapper)
      if (jsonResponse is Map<String, dynamic>) {
        return Agenda.fromJson(jsonResponse);
      }
      
      throw Exception('Invalid response format');
    } else if (response.statusCode == 400) {
      final jsonResponse = json.decode(response.body);
      String errorMessage = jsonResponse['message'] ?? 'Validation failed';
      if (jsonResponse['errors'] != null) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        errorMessage += ': ${errors.values.join(', ')}';
      }
      throw Exception(errorMessage);
    } else {
      throw Exception('Failed to create agenda: ${response.statusCode}');
    }
  }

  // Update agenda
  static Future<Agenda> updateAgenda(Agenda agenda) async {
    final response = await http.put(
      Uri.parse('$baseUrl/agenda/${agenda.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(agenda.toUpdateJson()),
    );
    
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      
      // Handle case where response might be wrapped with success field
      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('success')) {
        bool success = _toBool(jsonResponse['success']);
        if (success && jsonResponse['data'] != null) {
          return Agenda.fromJson(jsonResponse['data']);
        }
        throw Exception(jsonResponse['message'] ?? 'Failed to update agenda');
      }
      
      // If response is the agenda object directly (no wrapper)
      if (jsonResponse is Map<String, dynamic>) {
        return Agenda.fromJson(jsonResponse);
      }
      
      throw Exception('Invalid response format');
    } else if (response.statusCode == 400) {
      final jsonResponse = json.decode(response.body);
      String errorMessage = jsonResponse['message'] ?? 'Validation failed';
      if (jsonResponse['errors'] != null) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        errorMessage += ': ${errors.values.join(', ')}';
      }
      throw Exception(errorMessage);
    } else {
      throw Exception('Failed to update agenda: ${response.statusCode}');
    }
  }

  // Delete agenda
  static Future<String> deleteAgenda(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/agenda/$id'));
    
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      
      // Handle case where response might be wrapped with success field
      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('success')) {
        bool success = _toBool(jsonResponse['success']);
        if (success) {
          return jsonResponse['message'] ?? jsonResponse['data'] ?? 'Agenda deleted';
        }
        throw Exception(jsonResponse['message'] ?? 'Failed to delete agenda');
      }
      
      // If response is a simple message object (no wrapper)
      if (jsonResponse is Map<String, dynamic>) {
        return jsonResponse['message'] ?? jsonResponse['data'] ?? 'Agenda deleted';
      }
      
      // If response is just a string
      if (jsonResponse is String) {
        return jsonResponse;
      }
      
      return 'Agenda deleted';
    } else {
      throw Exception('Failed to delete agenda: ${response.statusCode}');
    }
  }
}

