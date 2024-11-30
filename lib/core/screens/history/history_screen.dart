import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/detection/detection_bloc.dart';
import 'package:leafolyze/blocs/detection/detection_state.dart';
import 'package:leafolyze/blocs/history/history_bloc.dart';
import 'package:leafolyze/blocs/history/history_event.dart';
import 'package:leafolyze/blocs/history/history_state.dart';
import 'package:leafolyze/core/widgets/common/diagnosis_item.dart';


class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Mendengarkan perubahan dari DetectionBloc
        BlocListener<DetectionBloc, DetectionState>(
          listener: (context, state) {
            if (state is DetectionSuccess) {
              // Refresh data history ketika deteksi berhasil
              context.read<HistoryBloc>().add(RefreshDetections());
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Deteksi'),
          actions: [
            // Tombol refresh manual
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<HistoryBloc>().add(RefreshDetections());
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<HistoryBloc>().add(RefreshDetections());
          },
          child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryInitial) {
                context.read<HistoryBloc>().add(LoadDetections());
                return const Center(child: CircularProgressIndicator());
              }
              
              if (state is HistoryLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (state is HistoryLoaded) {
                if (state.detections.isEmpty) {
                  return const Center(
                    child: Text('Belum ada riwayat deteksi'),
                  );
                }
                
                return ListView.builder(
                  itemCount: state.detections.length,
                  itemBuilder: (context, index) {
                    final detection = state.detections[index];
                    return DiagnosisItem(
                      imagePath: detection.image?.path ?? '',
                      plantName: detection.title,
                      diseaseName: detection.diseases?.firstOrNull?.name ?? 'Tidak ada penyakit terdeteksi',
                    );
                  },
                );
              }
              
              if (state is HistoryError) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              }
              
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
