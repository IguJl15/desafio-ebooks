import 'package:desafio_ebook/src/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/ebook_cubit/ebook_cubit.dart';
import '../../cubits/ebook_cubit/ebook_state.dart';

class DownloadStatus extends StatelessWidget {
  const DownloadStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EbookCubit, EbookState>(
      builder: (context, state) {
        final padding = state.map(
          (_) => const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          downloading: (_) => const EdgeInsets.all(4),
        );
        return Container(
          padding: padding,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: context.themeData.colorScheme.surfaceVariant.withOpacity(0.75),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: AnimatedSize(
            alignment: Alignment.centerLeft,
            duration: const Duration(milliseconds: 200),
            child: Container(
              child: state.map(
                (value) => value.isDownloaded
                    ? const DownloadStatusHint(icon: Icon(Icons.download_done), label: "Salvo")
                    : const DownloadStatusHint(icon: Icon(Icons.download)),
                downloading: (_) => const _DownloadProgress(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DownloadStatusHint extends StatelessWidget {
  final Widget icon;
  final String? label;

  const DownloadStatusHint({super.key, required this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [icon, if (label != null) Text(label!)],
    );
  }
}

class DownloadNowHint extends StatelessWidget {
  const DownloadNowHint({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.download);
  }
}

class _DownloadProgress extends StatelessWidget {
  const _DownloadProgress();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EbookCubit, EbookState, double?>(
      selector: (state) => state.mapOrNull(
        null,
        downloading: (downloading) => downloading.progress,
      ),
      builder: (context, progress) {
        return SizedBox(
          width: 24,
          height: 24,
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
