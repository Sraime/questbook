import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../design_system/components/qb_badge.dart';
import '../../design_system/components/qb_button.dart';
import '../../design_system/components/qb_card.dart';
import '../../design_system/components/qb_dialog.dart';
import '../../design_system/components/qb_input.dart';
import '../../design_system/components/qb_page_background.dart';
import '../../design_system/tokens/colors.dart';
import '../../design_system/tokens/spacing.dart';
import '../../design_system/tokens/typography.dart';
import 'providers/table_list_provider.dart';

/// Screen 1g — Mes tables. The mockup doesn't include a table-detail
/// screen, so tapping an existing table is a no-op for this pass.
class TablesScreen extends ConsumerWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tablesAsync = ref.watch(tableListProvider);

    return QBPageBackground(
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 24, 18, 90),
          children: [
            Text(
              'Mes tables',
              style: QBType.game().copyWith(
                fontWeight: QBType.weightBold,
                fontSize: 22,
                color: QBColors.ink900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tes campagnes en cours, tous univers confondus.',
              style: QBType.body().copyWith(
                fontSize: QBType.sm,
                color: QBColors.textMuted,
              ),
            ),
            const SizedBox(height: QBSpace.s5),
            tablesAsync.when(
              data: (tables) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (tables.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Aucune table pour l’instant. Propose un créneau, '
                        'on verra qui peut venir.',
                        style: QBType.body().copyWith(
                          fontSize: QBType.base,
                          color: QBColors.textMuted,
                        ),
                      ),
                    )
                  else
                    for (final table in tables) ...[
                      QBCard(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    table.title,
                                    style: QBType.game().copyWith(
                                      fontWeight: QBType.weightSemibold,
                                      fontSize: 15,
                                      color: QBColors.ink900,
                                    ),
                                  ),
                                ),
                                QBBadge(label: table.universeLabel, tone: QBTone.info),
                              ],
                            ),
                            const SizedBox(height: QBSpace.s2),
                            Text(
                              table.nextSession == null
                                  ? 'Aucune session prévue'
                                  : 'Prochaine session · ${_formatSession(table.nextSession!)}',
                              style: QBType.body().copyWith(
                                fontSize: QBType.xs,
                                color: QBColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: QBSpace.s3),
                    ],
                  GestureDetector(
                    onTap: () => _NewTableDialog.show(context, ref),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        border: Border.all(color: QBColors.borderStrong, width: 3),
                        borderRadius: BorderRadius.circular(QBRadius.lg),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '+ Nouvelle table',
                        style: QBType.game().copyWith(
                          fontWeight: QBType.weightSemibold,
                          fontSize: 15,
                          color: QBColors.leather700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text('Erreur : $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatSession(DateTime date) {
    const weekdays = ['Lun.', 'Mar.', 'Mer.', 'Jeu.', 'Ven.', 'Sam.', 'Dim.'];
    const months = [
      'janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin',
      'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.',
    ];
    final weekday = weekdays[date.weekday - 1];
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$weekday ${date.day} ${months[date.month - 1]}, ${hour}h${minute == '00' ? '' : minute}';
  }
}

class _NewTableDialog {
  static Future<void> show(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final universeController = TextEditingController();
    return showQBDialog(
      context: context,
      title: 'Nouvelle table',
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          QBInput(label: 'Nom de la table', controller: titleController),
          const SizedBox(height: QBSpace.s3),
          QBInput(label: 'Univers', controller: universeController, placeholder: 'Cthulhu…'),
          const SizedBox(height: QBSpace.s4),
          QBButton(
            label: 'Créer la table',
            variant: QBButtonVariant.primary,
            expand: true,
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isEmpty) return;
              ref.read(tableRepositoryProvider).create(
                    title: title,
                    universeLabel: universeController.text.trim().isEmpty
                        ? 'Autre'
                        : universeController.text.trim(),
                  );
              Navigator.of(context).maybePop();
            },
          ),
        ],
      ),
    );
  }
}
