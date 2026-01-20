class Agenda {
  final int id;
  final String judul;
  final String? keterangan;
  final bool isDone;
  final DateTime createdAt;
  final DateTime updatedAt;

  Agenda({
    required this.id,
    required this.judul,
    this.keterangan,
    required this.isDone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) {
    return Agenda(
      id: json['id'],
      judul: json['judul'],
      keterangan: json['keterangan'],
      isDone: json['is_done'] == 1 || json['is_done'] == true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'keterangan': keterangan,
      'is_done': isDone ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'judul': judul,
      'keterangan': keterangan,
      'is_done': isDone,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'judul': judul,
      'keterangan': keterangan,
      'is_done': isDone,
    };
  }
}

