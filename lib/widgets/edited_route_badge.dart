import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditedRouteBadge extends StatelessWidget {
  final String text;

  const EditedRouteBadge({super.key, this.text = 'Edited by User'});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.edit_note_rounded, size: 18, color: scheme.primary),

          const SizedBox(width: 7),

          Text(
            text,
            style: GoogleFonts.quicksand(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: scheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
