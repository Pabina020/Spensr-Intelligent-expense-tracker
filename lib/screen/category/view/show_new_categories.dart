// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// @RoutePage()
// class ShowCategoriesScreen extends StatelessWidget {
//   const ShowCategoriesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder.reactive(
//       viewModelBuilder: () => AddCategoryViewModel(),
//       onViewModelReady: (model) => model.fetchCategories(),
//       builder: (context, model, child) {
//         return CustomKeyboardHide(
//           child: Padding(
//             padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)), color: AppColors.of(context).tileBG),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       mHSpan,
//                       Container(height: 4, width: widthFactor(context) * 0.15, decoration: BoxDecoration(color: AppColors.of(context).secondaryGrey, borderRadius: BorderRadius.circular(4))),
//                       lHSpan,
//                       CustomSearchBar(onSubmitted: (_) {
//                         FocusScope.of(context).unfocus();
//                       }),
//                       xlHSpan,
//                       Container(
//                         height: heightFactor(context) * 0.4,
//                         child: GridView.count(
//                           crossAxisCount: 3,
//                           childAspectRatio: 0.9,
//                           children: model.categories.map((category) {
//                             return Column(
//                               children: [
//                                 Container(
//                                   height: 70,
//                                   width: 70,
//                                   decoration: BoxDecoration(color: AppColors.of(context).secondaryBG, shape: BoxShape.circle),
//                                   child: Center(child: Text(category.emoji ?? '', textScaler: TextScaler.linear(2))),
//                                 ),
//                                 sHSpan,
//                                 Text(category.title ?? '', style: TextStyle(fontSize: 15, color: AppColors.of(context).primaryText, fontWeight: FontWeight.w500)),
//                               ],
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
