import 'package:flutter/material.dart';
import '../theme.dart';

/// Small pill shown at the top of every screen with the running star count.
class StarBar extends StatelessWidget {
  final int stars;
  final String label;
  const StarBar({super.key, required this.stars, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [BoxShadow(color: Color(0x14000000), offset: Offset(0, 2))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: AppColors.sun, size: 18),
          const SizedBox(width: 6),
          Text('$stars', style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

/// One badge tile on the Rewards screen. Greyed out until [unlocked].
class BadgeTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool unlocked;
  const BadgeTile({super.key, required this.icon, required this.label, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: unlocked ? 1 : 0.35,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x14000000), offset: Offset(0, 2))],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: AppColors.grape),
            const SizedBox(height: 6),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

/// Simple language toggle used in the AppBar of every screen.
class LanguageToggle extends StatelessWidget {
  final bool isHindi;
  final ValueChanged<bool> onChanged;
  const LanguageToggle({super.key, required this.isHindi, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grape, width: 2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _langButton('EN', !isHindi, () => onChanged(false)),
          _langButton('हिं', isHindi, () => onChanged(true)),
        ],
      ),
    );
  }

  Widget _langButton(String label, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.grape : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(label,
            style: TextStyle(
                color: active ? Colors.white : AppColors.grape,
                fontWeight: FontWeight.w700,
                fontSize: 13)),
      ),
    );
  }
}
