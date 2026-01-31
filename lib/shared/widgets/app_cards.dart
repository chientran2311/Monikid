import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

/// Standard card with consistent styling
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final BorderRadius? borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.onTap,
    this.boxShadow,
    this.border,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? (isDark ? AppTheme.cardDark : AppTheme.cardLight),
        borderRadius: borderRadius ?? AppTheme.borderRadiusLG,
        border: border ?? Border.all(
          color: isDark ? AppTheme.gray700 : AppTheme.gray200,
          width: 1,
        ),
        boxShadow: boxShadow ?? AppTheme.shadowSM,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? AppTheme.borderRadiusLG,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppTheme.spacingMD),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Gradient card for wallet/balance display
class AppGradientCard extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? height;

  const AppGradientCard({
    super.key,
    required this.child,
    this.gradient = AppTheme.primaryGradient,
    this.padding,
    this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: AppTheme.borderRadiusXL,
        boxShadow: AppTheme.shadowPrimary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppTheme.borderRadiusXL,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppTheme.spacingLG),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Wallet card with balance display
class WalletCard extends StatelessWidget {
  final String title;
  final String balance;
  final String? subtitle;
  final bool isLocked;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final Widget? action;

  const WalletCard({
    super.key,
    required this.title,
    required this.balance,
    this.subtitle,
    this.isLocked = false,
    this.gradient,
    this.onTap,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppGradientCard(
      gradient: gradient ?? AppTheme.walletGradient,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: AppTheme.borderRadiusMD,
                    ),
                    child: Icon(
                      isLocked ? Icons.lock : Icons.account_balance_wallet,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSM),
                  Text(
                    title,
                    style: AppTheme.titleMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
              if (action != null) action!,
            ],
          ),
          const SizedBox(height: AppTheme.spacingMD),
          if (isLocked)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingSM,
                vertical: AppTheme.spacingXS,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: AppTheme.borderRadiusSM,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    'Ví đã bị khóa',
                    style: AppTheme.labelSmall.copyWith(color: Colors.white),
                  ),
                ],
              ),
            )
          else
            Text(
              balance,
              style: AppTheme.moneyLarge.copyWith(
                color: Colors.white,
              ),
            ),
          if (subtitle != null) ...[
            const SizedBox(height: AppTheme.spacingXS),
            Text(
              subtitle!,
              style: AppTheme.bodySmall.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Transaction item card
class TransactionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final bool isIncome;
  final DateTime date;
  final IconData? icon;
  final VoidCallback? onTap;

  const TransactionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isIncome,
    required this.date,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppTheme.spacingMD),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isIncome
                  ? AppTheme.accentGreenLight
                  : AppTheme.accentRedLight,
              borderRadius: AppTheme.borderRadiusMD,
            ),
            child: Icon(
              icon ?? (isIncome ? Icons.arrow_downward : Icons.arrow_upward),
              color: isIncome ? AppTheme.accentGreen : AppTheme.accentRed,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spacingMD),
          
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.titleSmall.copyWith(
                    color: AppTheme.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          
          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isIncome ? '+' : '-'}$amount',
                style: AppTheme.moneySmall.copyWith(
                  color: isIncome ? AppTheme.accentGreen : AppTheme.accentRed,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _formatDate(date),
                style: AppTheme.labelSmall.copyWith(
                  color: AppTheme.textTertiaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    
    if (dateOnly == today) {
      return 'Hôm nay';
    } else if (dateOnly == today.subtract(const Duration(days: 1))) {
      return 'Hôm qua';
    } else {
      return '${date.day}/${date.month}';
    }
  }
}

/// Child member card
class ChildCard extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final String balance;
  final bool isLocked;
  final VoidCallback? onTap;

  const ChildCard({
    super.key,
    required this.name,
    this.avatarUrl,
    required this.balance,
    this.isLocked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppTheme.childGradient,
              borderRadius: AppTheme.borderRadiusFull,
            ),
            child: avatarUrl != null
                ? ClipRRect(
                    borderRadius: AppTheme.borderRadiusFull,
                    child: Image.network(
                      avatarUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: AppTheme.titleLarge.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: AppTheme.spacingMD),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: AppTheme.titleMedium,
                    ),
                    if (isLocked) ...[
                      const SizedBox(width: AppTheme.spacingXS),
                      const Icon(
                        Icons.lock,
                        size: 14,
                        color: AppTheme.accentOrange,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Số dư: $balance',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          
          // Arrow
          const Icon(
            Icons.chevron_right,
            color: AppTheme.gray400,
          ),
        ],
      ),
    );
  }
}

/// Statistics card with number display
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? change;
  final bool isPositiveChange;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.change,
    this.isPositiveChange = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: AppTheme.borderRadiusSM,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              if (change != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isPositiveChange
                        ? AppTheme.accentGreenLight
                        : AppTheme.accentRedLight,
                    borderRadius: AppTheme.borderRadiusSM,
                  ),
                  child: Text(
                    change!,
                    style: AppTheme.labelSmall.copyWith(
                      color: isPositiveChange
                          ? AppTheme.accentGreen
                          : AppTheme.accentRed,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMD),
          Text(
            value,
            style: AppTheme.moneyMedium.copyWith(
              color: AppTheme.textPrimaryLight,
            ),
          ),
          const SizedBox(height: AppTheme.spacingXS),
          Text(
            title,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

/// Empty state card
class EmptyStateCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyStateCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.gray100,
                borderRadius: AppTheme.borderRadiusFull,
              ),
              child: Icon(
                icon,
                size: 40,
                color: AppTheme.gray400,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMD),
            Text(
              title,
              style: AppTheme.titleMedium.copyWith(
                color: AppTheme.textPrimaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingSM),
            Text(
              description,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppTheme.spacingMD),
              TextButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
