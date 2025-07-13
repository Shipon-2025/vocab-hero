import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Primary button widget with consistent styling and haptic feedback
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final bool enableHapticFeedback;
  final Widget? child;
  
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.enableHapticFeedback = true,
    this.child,
  });
  
  const PrimaryButton.icon({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.enableHapticFeedback = true,
    this.child,
  });
  
  const PrimaryButton.custom({
    super.key,
    required this.child,
    this.text = '',
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.enableHapticFeedback = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = !isEnabled || isLoading || onPressed == null;

    return SizedBox(
      width: width,
      height: height ?? 56,
      child: Container(
        decoration: BoxDecoration(
          gradient: isDisabled
              ? null
              : LinearGradient(
                  colors: [
                    backgroundColor ?? AppColors.primary,
                    (backgroundColor ?? AppColors.primary).withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          boxShadow: isDisabled ? null : [
            BoxShadow(
              color: (backgroundColor ?? AppColors.primary).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: (backgroundColor ?? AppColors.primary).withOpacity(0.1),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isDisabled ? null : _handlePress,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDisabled ? AppColors.border : Colors.transparent,
            foregroundColor: textColor ?? AppColors.textOnPrimary,
            disabledBackgroundColor: AppColors.border,
            disabledForegroundColor: AppColors.textTertiary,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(16),
            ),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          child: _buildButtonContent(),
        ),
      ),
    );
  }
  
  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            textColor ?? AppColors.textOnPrimary,
          ),
        ),
      );
    }
    
    if (child != null) {
      return child!;
    }
    
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTypography.buttonText.copyWith(
              color: textColor ?? AppColors.textOnPrimary,
            ),
          ),
        ],
      );
    }
    
    return Text(
      text,
      style: AppTypography.buttonText.copyWith(
        color: textColor ?? AppColors.textOnPrimary,
      ),
    );
  }
  
  void _handlePress() {
    if (enableHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    onPressed?.call();
  }
}

/// Secondary button with outline style
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final bool enableHapticFeedback;
  
  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.borderColor,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.enableHapticFeedback = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = !isEnabled || isLoading || onPressed == null;
    
    return SizedBox(
      width: width,
      height: height ?? 56,
      child: OutlinedButton(
        onPressed: isDisabled ? null : _handlePress,
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor ?? AppColors.primary,
          disabledForegroundColor: AppColors.textTertiary,
          side: BorderSide(
            color: isDisabled 
                ? AppColors.border 
                : (borderColor ?? AppColors.primary),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        child: _buildButtonContent(),
      ),
    );
  }
  
  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            textColor ?? AppColors.primary,
          ),
        ),
      );
    }
    
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTypography.buttonText.copyWith(
              color: textColor ?? AppColors.primary,
            ),
          ),
        ],
      );
    }
    
    return Text(
      text,
      style: AppTypography.buttonText.copyWith(
        color: textColor ?? AppColors.primary,
      ),
    );
  }
  
  void _handlePress() {
    if (enableHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    onPressed?.call();
  }
}
