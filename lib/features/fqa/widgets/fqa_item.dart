import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/models/entities/fqa/fqa_model.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class FQAItem extends HookWidget {
  const FQAItem({
    required this.item,
    required this.isExpanded,
    required this.onTap,
    this.animationDelay = Duration.zero,
    super.key,
  });

  final FQAModel item;
  final bool isExpanded;
  final VoidCallback onTap;
  final Duration animationDelay;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useEffect(() {
      if (isExpanded) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      return null;
    }, [isExpanded]);

    final rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 15 * (1 - value)),
            child: child,
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isExpanded
                ? AppTheme.primary
                : (isDark ? AppTheme.borderDark : AppTheme.borderLight),
          ),
          boxShadow: isExpanded
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Header
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20.r),
              child: Padding(
                padding: EdgeInsets.all(18.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.question,
                        style: context.typo.body.medium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    RotationTransition(
                      turns: rotationAnimation,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.sp,
                        color: isExpanded
                            ? AppTheme.primary
                            : (isDark ? AppTheme.textMuted : AppTheme.textGrey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Answer Content (with animation)
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 20.h),
                child: Text(
                  item.answer,
                  style: context.typo.body.small.copyWith(
                    color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
