
import 'package:flutter/material.dart';
import 'package:spensr/theme/app_colors.dart';

class SelectEmoji extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const SelectEmoji({
    Key? key,
    required this.controller,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);

  @override
  State<SelectEmoji> createState() => _SelectEmojiState();
}

class _SelectEmojiState extends State<SelectEmoji> {
  // Sample emoji list - you can customize this
  final List<String> emojis = [
    '😊', '💰', '🍕', '🚗', '🏠', '💼', '🎓', '🛒',
    '🍔', '☕', '✈️', '🎬', '🏥', '💳', '📱', '🎁',
    '🍎', '⚽', '🎮', '📚', '🎵', '🎨', '🏋️', '🚲',
    '🏖️', '🎯', '💎', '🌮', '🍣', '🍦', '🎂', '🍷',
  ];

  String? _selectedEmoji;

  @override
  void initState() {
    super.initState();
    _selectedEmoji = widget.controller.text.isNotEmpty ? widget.controller.text : null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Emoji',
          style: TextStyle(
            fontSize: 14,
            color: colors.disabledText,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        
        // Emoji display and selection area
        Container(
          decoration: BoxDecoration(
            color: colors.containerBG,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Selected emoji display
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _selectedEmoji != null
                      ? colors.primary.withOpacity(0.1)
                      : colors.containerBG2,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedEmoji != null
                        ? colors.primary
                        : colors.disabled,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    _selectedEmoji ?? '😊',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
              
              SizedBox(height: 16),
              
              // Emoji grid
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: emojis.length,
                itemBuilder: (context, index) {
                  final emoji = emojis[index];
                  final isSelected = _selectedEmoji == emoji;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedEmoji = emoji;
                        widget.controller.text = emoji;
                        if (widget.onChanged != null) {
                          widget.onChanged!(emoji);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colors.primary.withOpacity(0.2)
                            : colors.containerBG2,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? colors.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          emoji,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
