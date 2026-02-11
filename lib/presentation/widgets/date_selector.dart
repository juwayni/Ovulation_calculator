import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/period_provider.dart';

class DateSelector extends ConsumerWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final monthStart = DateTime(selectedDate.year, selectedDate.month, 1);
    final periodsAsync = ref.watch(periodsProvider);
    final periods = periodsAsync.value ?? [];

    return Column(
      children: [
        _buildMonthHeader(context),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 31,
            itemBuilder: (context, index) {
              final date = monthStart.add(Duration(days: index));
              if (date.month != monthStart.month) return const SizedBox();

              final isToday = DateUtils.isSameDay(date, now);
              final isSelected = DateUtils.isSameDay(date, selectedDate);

              // Check if date is in any period
              final isInPeriod = periods.any((p) {
                  if (p.endDate == null) {
                      return DateUtils.isSameDay(date, p.startDate) || date.isAfter(p.startDate);
                  }
                  return (date.isAfter(p.startDate) || DateUtils.isSameDay(date, p.startDate)) &&
                         (date.isBefore(p.endDate!) || DateUtils.isSameDay(date, p.endDate!));
              });

              return GestureDetector(
                onTap: () => onDateSelected(date),
                child: Container(
                  width: 55,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      if (isToday)
                        const Text('Today', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
                      else
                        const SizedBox(height: 15),
                      Text(
                        DateFormat('E').format(date).substring(0, 1),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? Colors.pink : Colors.transparent,
                          border: isInPeriod && !isSelected
                              ? Border.all(color: Colors.pink.withOpacity(0.5), width: 1.5)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMonthHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.chevron_left, color: Colors.grey),
        const SizedBox(width: 16),
        Text(
          DateFormat('MMMM yyyy').format(selectedDate),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.chevron_right, color: Colors.grey),
      ],
    );
  }
}
