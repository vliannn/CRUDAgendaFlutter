import 'package:flutter/foundation.dart';
import '../models/agenda.dart';
import '../services/api_service.dart';

class AgendaProvider with ChangeNotifier {
  List<Agenda> _agendas = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Agenda> get agendas => _agendas;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch all agendas
  Future<void> fetchAgendas() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _agendas = await ApiService.getAllAgendas();
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create agenda
  Future<bool> createAgenda(Agenda agenda) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final newAgenda = await ApiService.createAgenda(agenda);
      _agendas.add(newAgenda);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update agenda
  Future<bool> updateAgenda(Agenda agenda) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final updatedAgenda = await ApiService.updateAgenda(agenda);
      final index = _agendas.indexWhere((a) => a.id == agenda.id);
      if (index != -1) {
        _agendas[index] = updatedAgenda;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete agenda
  Future<bool> deleteAgenda(int id) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await ApiService.deleteAgenda(id);
      _agendas.removeWhere((a) => a.id == id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }
}

