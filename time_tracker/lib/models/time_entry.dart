class TimeEntry {
  final String id;          // Unique identifier
  final String projectId;  // ID of the project this entry relates to
  final String notes;      // Notes about the time entry
  final double totalTime;   // Total time spent
  final DateTime date;      // Date of the entry

  TimeEntry({
    required this.id,
    required this.projectId,
    required this.notes,
    required this.totalTime,
    required this.date,
  });

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      projectId: json['projectId'],
      notes: json['notes'],
      totalTime: json['totalTime'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'notes': notes,
      'totalTime': totalTime,
      'date': date.toIso8601String(),
    };
  }
}
