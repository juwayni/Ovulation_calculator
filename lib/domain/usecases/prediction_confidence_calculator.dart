import '../../data/models/period_model.dart';

class PredictionConfidenceCalculator {
  double calculateConfidence(List<PeriodModel> periods) {
    if (periods.length < 2) return 0.5; // Baseline confidence
    if (periods.length < 3) return 0.7;

    // Sort periods
    final sorted = List<PeriodModel>.from(periods)
      ..sort((a, b) => a.startDate.compareTo(b.startDate));

    List<int> cycleLengths = [];
    for (int i = 0; i < sorted.length - 1; i++) {
      cycleLengths.add(
        sorted[i + 1].startDate.difference(sorted[i].startDate).inDays,
      );
    }

    if (cycleLengths.isEmpty) return 0.5;

    // Calculate mean
    double mean = cycleLengths.reduce((a, b) => a + b) / cycleLengths.length;

    // Calculate variance
    double variance =
        cycleLengths
            .map((l) => (l - mean) * (l - mean))
            .reduce((a, b) => a + b) /
        cycleLengths.length;
    double stdDev = variance > 0
        ? (variance * 1).abs()
        : 0; // Simplified stdDev for this example or just use variance

    // Higher variance = lower confidence
    // If stdDev is 0, confidence is high. If stdDev is 7 days, confidence is low.
    double confidence = 1.0 - (stdDev / 50.0); // Simple linear decrease

    // Adjust based on number of cycles recorded
    double dataWeight = (periods.length / 6.0).clamp(0.0, 1.0);

    confidence = (confidence * 0.7) + (dataWeight * 0.3);

    return confidence.clamp(0.1, 0.99);
  }
}
