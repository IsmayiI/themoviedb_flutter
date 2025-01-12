String formatDuration(int totalMinutes) {
  final hours = totalMinutes ~/ 60; // Целое количество часов
  final minutes = totalMinutes % 60; // Оставшиеся минуты
  return '${hours}h ${minutes}m';
}
