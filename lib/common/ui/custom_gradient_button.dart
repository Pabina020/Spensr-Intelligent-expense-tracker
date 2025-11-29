// import 'package:flutter/material.dart';
// import 'package:spendigo/common/ui/custom_loader.dart';
// import 'package:spendigo/theme/app_colors.dart';

// /// ----------------------------------------------------------
// /// PRIMARY GRADIENT BUTTON (Fintech + AI Glow)
// /// ----------------------------------------------------------
// class CustomGradientButton extends StatelessWidget {
//   final Function()? onPressed;
//   final double borderRadius;
//   final bool busy;
//   final String? buttonLabel;
//   final Color disabledColor;

//   const CustomGradientButton({
//     super.key,
//     this.onPressed,
//     this.borderRadius = 14.0,
//     this.busy = false,
//     required this.buttonLabel,
//     this.disabledColor = const Color(0xFF1A1D21),
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isEnabled = onPressed != null && !busy;

//     return InkWell(
//       onTap: isEnabled ? onPressed : null,
//       borderRadius: BorderRadius.circular(borderRadius),
//       splashColor: Colors.white.withOpacity(.05),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeOut,
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(borderRadius),
//           gradient: isEnabled
//               ? const LinearGradient(
//                   colors: [
//                     Color(0xFF6366F1), // Indigo
//                     Color(0xFF4F46E5),
//                     Color(0xFF0EA5E9), // Cyan glow
//                   ],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 )
//               : null,
//           color: isEnabled ? null : disabledColor,
//           boxShadow: isEnabled
//               ? [
//                   BoxShadow(
//                     color: const Color(0xFF6366F1).withOpacity(.35),
//                     blurRadius: 12,
//                     offset: const Offset(0, 4),
//                   )
//                 ]
//               : [],
//         ),
//         child: Center(
//           child: busy
//               ? CustomLoader.minimal()
//               : Text(
//                   buttonLabel ?? "",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 15,
//                     color: isEnabled
//                         ? Colors.white
//                         : Colors.white.withOpacity(.3),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

// /// ----------------------------------------------------------
// /// OUTLINED BUTTON (Clean, Minimal, Fintech Style)
// /// ----------------------------------------------------------
// class CustomOutlinedButton extends StatelessWidget {
//   final Function()? onPressed;
//   final double borderRadius;
//   final bool busy;
//   final String? buttonLabel;
//   final Color disabledColor;

//   const CustomOutlinedButton({
//     super.key,
//     this.onPressed,
//     this.borderRadius = 14.0,
//     this.busy = false,
//     required this.buttonLabel,
//     this.disabledColor = const Color(0xFF1A1D21),
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isEnabled = onPressed != null && !busy;

//     return InkWell(
//       onTap: isEnabled ? onPressed : null,
//       borderRadius: BorderRadius.circular(borderRadius),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(borderRadius),
//           color: Colors.transparent,
//           border: Border.all(
//             width: 1.4,
//             color: isEnabled
//                 ? const Color(0xFF6366F1)
//                 : Colors.white.withOpacity(.15),
//           ),
//         ),
//         child: Center(
//           child: busy
//               ? CustomLoader.minimal()
//               : Text(
//                   buttonLabel ?? "",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                     color: isEnabled
//                         ? AppColors.of(context).primaryText
//                         : Colors.white.withOpacity(.3),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

// /// ----------------------------------------------------------
// /// ICON GRADIENT BUTTON (For AI Action Buttons)
// /// ----------------------------------------------------------
// class CustomGradientIconButton extends StatelessWidget {
//   final Function()? onPressed;
//   final double borderRadius;
//   final bool busy;
//   final Widget icon;
//   final Color disabledColor;
//   final String? tooltip;

//   const CustomGradientIconButton({
//     super.key,
//     this.onPressed,
//     this.borderRadius = 16.0,
//     this.busy = false,
//     required this.icon,
//     this.disabledColor = const Color(0xFF1A1D21),
//     this.tooltip,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isEnabled = onPressed != null && !busy;

//     return Tooltip(
//       message: tooltip ?? '',
//       child: InkWell(
//         onTap: isEnabled ? onPressed : null,
//         borderRadius: BorderRadius.circular(borderRadius),
//         splashColor: Colors.white12,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(borderRadius),
//             gradient: isEnabled
//                 ? const LinearGradient(
//                     colors: [
//                       Color(0xFF6366F1),
//                       Color(0xFF4F46E5),
//                       Color(0xFF0EA5E9),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   )
//                 : null,
//             color: isEnabled ? null : disabledColor,
//             boxShadow: isEnabled
//                 ? [
//                     BoxShadow(
//                       color: const Color(0xFF6366F1).withOpacity(.25),
//                       blurRadius: 10,
//                       offset: const Offset(0, 3),
//                     )
//                   ]
//                 : [],
//           ),
//           child: busy
//               ? CustomLoader.minimal()
//               : icon,
//         ),
//       ),
//     );
//   }
// }
