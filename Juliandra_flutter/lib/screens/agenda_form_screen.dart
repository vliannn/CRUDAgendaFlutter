import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/agenda_provider.dart';
import '../models/agenda.dart';

class AgendaFormScreen extends StatefulWidget {
  final Agenda? agenda;

  const AgendaFormScreen({super.key, this.agenda});

  @override
  State<AgendaFormScreen> createState() => _AgendaFormScreenState();
}

class _AgendaFormScreenState extends State<AgendaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _keteranganController = TextEditingController();
  bool _isDone = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.agenda != null) {
      _judulController.text = widget.agenda!.judul;
      _keteranganController.text = widget.agenda!.keterangan ?? '';
      _isDone = widget.agenda!.isDone;
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  Future<void> _saveAgenda() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);

      final agenda = Agenda(
        id: widget.agenda?.id ?? 0,
        judul: _judulController.text.trim(),
        keterangan: _keteranganController.text.trim().isEmpty
            ? null
            : _keteranganController.text.trim(),
        isDone: _isDone,
        createdAt: widget.agenda?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final provider = Provider.of<AgendaProvider>(context, listen: false);
      bool success;

      if (widget.agenda != null) {
        success = await provider.updateAgenda(agenda);
      } else {
        success = await provider.createAgenda(agenda);
      }

      setState(() => _isSaving = false);

      if (success && mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.agenda != null
                  ? 'Agenda berhasil diperbarui'
                  : 'Agenda berhasil ditambahkan',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.agenda != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Agenda' : 'Tambah Agenda'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul Agenda *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul agenda wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _keteranganController,
                decoration: const InputDecoration(
                  labelText: 'Keterangan',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        _isDone ? Icons.check_circle : Icons.pending,
                        color: _isDone ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Status:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      Switch(
                        value: _isDone,
                        onChanged: (value) {
                          setState(() {
                            _isDone = value;
                          });
                        },
                        thumbColor: WidgetStateProperty.all(Colors.green),
                        trackColor: WidgetStateProperty.all(Colors.green.withValues(alpha: 0.5)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveAgenda,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: _isSaving
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          isEditing ? 'Perbarui Agenda' : 'Tambah Agenda',
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

