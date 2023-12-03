import '../../cubits/ebook_cubit/ebook_cubit.dart';
import '../../cubits/ebook_cubit/ebook_state.dart';
import '../../../../../shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadStatus extends StatelessWidget {
  const DownloadStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EbookCubit, EbookState>(
      builder: (context, state) {
        return state.map(
          (value) => value.isDownloaded ? Icon(Icons.download_done) : Icon(Icons.download),
          downloading: (_) => const _DownloadProgress(),
        );
      },
    );
  }
}

class DownloadIcon extends StatelessWidget {
  const DownloadIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _DownloadProgress extends StatelessWidget {
  const _DownloadProgress();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EbookCubit, EbookState, double>(
      selector: (state) => state.map(
        (_) => 0.0,
        downloading: (downloading) => downloading.progress,
      ),
      builder: (context, progress) {
        return Container(
          width: 32,
          height: 32,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: context.themeData.colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: CircularProgressIndicator.adaptive(
            value: progress,
            strokeWidth: 4,
            strokeCap: StrokeCap.round,
            strokeAlign: -1,
          ),
        );
      },
    );
  }
}
