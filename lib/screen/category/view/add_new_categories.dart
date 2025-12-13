
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spensr/common/ui/custom_gradient_button.dart';
import 'package:spensr/common/ui/custom_keyboard_hide.dart';
import 'package:spensr/common/ui/custom_outlined_button.dart' hide CustomOutlinedButton;
import 'package:spensr/common/ui/custom_text_button.dart';
import 'package:spensr/common/ui/custom_ui_helper.dart';
import 'package:spensr/localization/localized_strings.dart';
import 'package:spensr/screen/category/components/add_category.dart';
import 'package:spensr/screen/category/components/select_emoij.dart';

import 'package:spensr/screen/text_transaction/components/transacation_text_field.dart';
import 'package:spensr/theme/app_colors.dart';
import 'package:stacked/stacked.dart';

class AddCategoryViewModel extends BaseViewModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController emojiController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode emojiFocusNode = FocusNode();

  bool _canAddCategory = false;

  bool get canAddCategory => _canAddCategory;

  void updateCanAddCategory() {
    _canAddCategory = titleController.text.isNotEmpty && emojiController.text.isNotEmpty;
    notifyListeners();
  }

  Function()? get onCancelPressed => () {
        print("Cancel pressed");
      };

  Function()? get onSaveCategoryPressed => () {
        print("Save pressed with title: ${titleController.text} and emoji: ${emojiController.text}");
      };

  VoidCallback get onLoginPressed => () {
        print("Login pressed");
      };
}

@RoutePage()
class AddNewCategories extends StatelessWidget {
  const AddNewCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddCategoryViewModel(),
      builder: (context, model, child) {
        return Material(
          child: CustomKeyboardHide(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              constraints: BoxConstraints(
                maxHeight: heightFactor(context, factor: 0.9),
              ),
              decoration: BoxDecoration(
                color: AppColors.of(context).tileBG,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                padding: lPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 4,
                      width: widthFactor(context) * 0.15,
                      decoration: BoxDecoration(
                        color: AppColors.of(context).secondaryGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    xlHSpan,
                    Text(
                      LocalizedStrings.addCategory,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.of(context).secondaryGrey,
                      ),
                    ),
                    xlHSpan,
                    TransactionTextField(
                      labelText: LocalizedStrings.title,
                      hintText: LocalizedStrings.enterTitleHere,
                      focusNode: model.titleFocusNode,
                      controller: model.titleController,
                      onChanged: (_) => model.updateCanAddCategory(),
                      autofocus: true,
                      textCapitalization: TextCapitalization.words,
                    ),
                    lHSpan,
                    SelectEmoji(
                      controller: model.emojiController,
                      focusNode: model.emojiFocusNode,
                      onChanged: (_) => model.updateCanAddCategory(),
                    ),
                    mHSpan,
                    if (!UserDataService().isLoggedIn)
                      Container(
                        padding: mPadding,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.of(context).primaryText,
                            width: 0.25,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${LocalizedStrings.signInToSyncYourData}\n${LocalizedStrings.categoriesAreSavedLocally}",
                              ),
                            ),
                            xsWSpan,
                            CustomTextButton(
                              onPressed: model.onLoginPressed,
                              child: Text(LocalizedStrings.login),
                            ),
                          ],
                        ),
                      ),
                    mHSpan,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomOutlinedButton(
                            disabledColor: AppColors.of(context).secondaryBG,
                            borderRadius: 30,
                            onPressed: model.onCancelPressed,
                            buttonLabel: LocalizedStrings.cancel,
                          ),
                          mWSpan,
                          CustomGradientButton(
                            disabledColor: AppColors.of(context).secondaryBG,
                            borderRadius: 30,
                            onPressed:
                                model.canAddCategory
                                    ? model.onSaveCategoryPressed
                                    : null,
                            buttonLabel: LocalizedStrings.save,
                            busy: model.isBusy,
                          ),
                        ],
                      ),
                    ),
                    sHSpan,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class UserDataService {
  bool get isLoggedIn {
    // Add actual login logic (e.g., Firebase or Shared Preferences)
    return false; // Placeholder logic
  }
}

double heightFactor(BuildContext context, {double factor = 1.0}) {
  return MediaQuery.of(context).size.height * factor;
}

double widthFactor(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

const EdgeInsets lPadding = EdgeInsets.all(10.0);
const SizedBox xlHSpan = SizedBox(height: 20.0);
const SizedBox lHSpan = SizedBox(height: 16.0);
const SizedBox mHSpan = SizedBox(height: 12.0);
const EdgeInsets mPadding = EdgeInsets.all(8.0);
const SizedBox xsWSpan = SizedBox(width: 6.0);
const SizedBox mWSpan = SizedBox(width: 10.0);
const SizedBox sHSpan = SizedBox(height: 12.0);
