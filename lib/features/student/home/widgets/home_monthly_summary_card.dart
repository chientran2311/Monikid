import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/features/student/home/widgets/summary_mini_card.dart';

class HomeMonthlySummaryCard extends StatelessWidget {
  const HomeMonthlySummaryCard({
    super.key,
    required this.title,
    required this.remainingAmount,
    required this.incomeLabel,
    required this.expenseLabel,
    required this.monthlyIncome,
    required this.monthlyExpense,
    required this.isLimitConfigured,
    this.emptyStateLabel,
  });

  final String title;
  final String remainingAmount;
  final String incomeLabel;
  final String expenseLabel;
  final double monthlyIncome;
  final double monthlyExpense;
  final bool isLimitConfigured;
  final String? emptyStateLabel;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final isCompact = cardWidth < 360.w;
        final minCardHeight = 220.h;
        final maxCardHeight = math.max(minCardHeight, screenSize.height * 0.34);
        final cardHeight = math.min(
          math.max(cardWidth * 0.72, minCardHeight),
          maxCardHeight,
        );
        final contentPadding = EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h);
        final bottomPanelHeight = isCompact ? cardHeight * 0.4 : cardHeight * 0.32;
        final contentBottomSpacing = bottomPanelHeight + 6.h;
        final summaryContent = isCompact
            ? Column(
                children: [
                  Expanded(
                    child: SummaryMiniCard(
                      title: incomeLabel,
                      amount: CurrencyFormatter.format(monthlyIncome),
                      icon: Icons.arrow_downward_rounded,
                      iconColor: const Color(0xFF3B82F6),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: const Divider(
                      height: 1,
                      color: Color(0xFFD7E3DB),
                    ),
                  ),
                  Expanded(
                    child: SummaryMiniCard(
                      title: expenseLabel,
                      amount: CurrencyFormatter.format(monthlyExpense),
                      icon: Icons.arrow_upward_rounded,
                      iconColor: const Color(0xFFEF4444),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: SummaryMiniCard(
                      title: incomeLabel,
                      amount: CurrencyFormatter.format(monthlyIncome),
                      icon: Icons.arrow_downward_rounded,
                      iconColor: const Color(0xFF3B82F6),
                    ),
                  ),
                  Container(
                    width: 1.w,
                    height: 58.h,
                    margin: EdgeInsets.symmetric(horizontal: 18.w),
                    color: const Color(0xFFD7E3DB),
                  ),
                  Expanded(
                    child: SummaryMiniCard(
                      title: expenseLabel,
                      amount: CurrencyFormatter.format(monthlyExpense),
                      icon: Icons.arrow_upward_rounded,
                      iconColor: const Color(0xFFEF4444),
                    ),
                  ),
                ],
              );

        return SizedBox(
          width: double.infinity,
          height: cardHeight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF195B34),
                  Color(0xFF14532D),
                  Color(0xFF0F4427),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x19000000),
                  blurRadius: 28.r,
                  offset: Offset(0, 14.h),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -36.w,
                  top: 32.h,
                  child: _CardDecorationCircle(size: 176.r, opacity: 0.06),
                ),
                Positioned(
                  left: -20.w,
                  bottom: 8.h,
                  child: _CardDecorationCircle(size: 90.r, opacity: 0.07),
                ),
                Positioned(
                  right: 26.w,
                  top: 26.h,
                  child: _CardDecorationDiamond(size: 12.r, opacity: 0.22),
                ),
                Positioned(
                  right: 56.w,
                  top: 22.h,
                  child: const _CardDecorationDot(opacity: 0.24),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: contentPadding.copyWith(bottom: contentBottomSpacing),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.r,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              isLimitConfigured
                                  ? remainingAmount
                                  : (emptyStateLabel ?? remainingAmount),
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isCompact ? 36.r : 48.r,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1.2,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20.w,
                  right: 20.w,
                  bottom: 18.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22.r),
                    child: Container(
                      height: bottomPanelHeight,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC).withValues(alpha: 0.86),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                      child: summaryContent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CardDecorationCircle extends StatelessWidget {
  const _CardDecorationCircle({
    required this.size,
    required this.opacity,
  });

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }
}

class _CardDecorationDiamond extends StatelessWidget {
  const _CardDecorationDiamond({
    required this.size,
    required this.opacity,
  });

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.78,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: opacity),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }
}

class _CardDecorationDot extends StatelessWidget {
  const _CardDecorationDot({required this.opacity});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.r,
      height: 8.r,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}
