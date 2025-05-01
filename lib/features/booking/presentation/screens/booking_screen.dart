import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/available_time.dart';
import '../providers/booking_provider.dart';

class BookingScreen extends ConsumerWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);

    final timesAsync = selectedDate != null
        ? ref.watch(availableTimesProvider(selectedDate))
        : AsyncValue.data([]);

    return Scaffold(
      appBar: AppBar(title: Text('Pilih Jadwal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tanggal
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 30)),
                );
                if (date != null) {
                  ref.read(selectedDateProvider.notifier).state = date;
                }
              },
              child: Text(selectedDate != null
                  ? 'Tanggal: ${selectedDate.toLocal()}'.split(' ')[0]
                  : 'Pilih Tanggal'),
            ),

            const SizedBox(height: 20),

            // Jam
            timesAsync.when(
              data: (times) => DropdownButton<AvailableTime>(
                hint: const Text('Pilih Jam'),
                value: selectedTime,
                items: times
                    .map(
                      (t) => DropdownMenuItem<AvailableTime>(
                    value: t,
                    child: Text('${t.start} - ${t.end}'),
                  ),
                )
                    .toList(),
                onChanged: (value) =>
                ref.read(selectedTimeProvider.notifier).state = value,
              ),
              loading: () => CircularProgressIndicator(),
              error: (e, _) => Text('Gagal memuat jam'),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: selectedDate != null && selectedTime != null
                  ? () async {
                final repo = ref.read(bookingRepositoryProvider);
                await repo.submitSchedule(selectedDate, selectedTime!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Jadwal berhasil dikirim')),
                );
              }
                  : null,
              child: const Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }
}
