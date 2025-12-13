import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spensr/localization/localized_strings.dart';
import 'package:spensr/theme/app_colors.dart';

class TransactionTextField extends StatefulWidget {
  final String? hintText;
  final TextStyle? labelStyle;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? inputTextStyle;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool prefixEnabled;
  final bool suffixEnabled;
  final ValueChanged<bool>? onSignChanged;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final String? initialValue;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool initialSign;

  const TransactionTextField({
    super.key,
    this.hintText,
    this.labelStyle,
    this.labelText,
    this.hintStyle,
    this.inputTextStyle,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixEnabled = false,
    this.suffixEnabled = false,
    this.onSignChanged,
    this.focusNode,
    this.onChanged,
    this.initialValue,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.initialSign = false,
  });

  @override
  State<TransactionTextField> createState() => _TransactionTextFieldState();
}

class _TransactionTextFieldState extends State<TransactionTextField> {
  String _selectedCountryCode = 'NP';
  bool _isPositive = false;

  final List<Map<String, String>> _countries = [
    {
      LocalizedStrings.code: 'US',
      LocalizedStrings.name: 'United States',
      LocalizedStrings.currency: '\$',
    },
    {
      LocalizedStrings.code: 'IN',
      LocalizedStrings.name: 'India',
      LocalizedStrings.currency: '₹',
    },
    {
      LocalizedStrings.code: 'GB',
      LocalizedStrings.name: 'United Kingdom',
      LocalizedStrings.currency: '£',
    },
    {
      LocalizedStrings.code: 'JP',
      LocalizedStrings.name: 'Japan',
      LocalizedStrings.currency: '¥',
    },
    {
      LocalizedStrings.code: 'FR',
      LocalizedStrings.name: 'France',
      LocalizedStrings.currency: '€',
    },
    {
      LocalizedStrings.code: 'NP',
      LocalizedStrings.name: 'Nepal',
      LocalizedStrings.currency: 'Rs',
    },
  ];

  String getFlagEmoji(String countryCode) {
    return countryCode
        .toUpperCase()
        .codeUnits
        .map((c) => String.fromCharCode(0x1F1E6 + c - 65))
        .join();
  }

  String get selectedCurrency {
    return _countries.firstWhere(
          (c) => c[LocalizedStrings.code] == _selectedCountryCode,
        )[LocalizedStrings.currency] ??
        '';
  }

  String text = "";

  @override
  void initState() {
    super.initState();
    text = widget.initialValue ?? widget.controller?.text ?? "";
    _isPositive = widget.initialSign;
  }

  @override
  Widget build(BuildContext context) {
    final inputColor = _isPositive ? Colors.lightGreen : Colors.redAccent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            widget.labelText ?? "",
            style: TextStyle(
              color: AppColors.of(context).primaryText,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          onChanged: (value) {
            widget.onChanged?.call(value);
            setState(() {
              text = value;
            });
          },
          onFieldSubmitted: widget.onFieldSubmitted,
          cursorColor: AppColors.of(context).primaryText,
          cursorHeight: 30,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          style:
              widget.inputTextStyle?.copyWith(
                color: widget.suffixEnabled ? inputColor : Colors.white,
              ) ??
              TextStyle(
                color: widget.suffixEnabled ? inputColor : Colors.white,
                fontSize: widget.suffixEnabled ? 30 : 20,
                fontWeight: FontWeight.bold,
              ),

          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ??
                titleLargeB(
                  context,
                )?.copyWith(color: AppColors.of(context).transactionPage),
            prefixIcon: widget.prefixEnabled ? _buildCountryPrefix() : null,

            suffixIcon: widget.suffixEnabled ? _buildToggleSuffix() : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountryPrefix() {
    return InkWell(
      onTap: _showCountryPicker,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedCurrency,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView(
          children:
              _countries.map((country) {
                return ListTile(
                  leading: Text(
                    getFlagEmoji(country[LocalizedStrings.code]!),
                    style: const TextStyle(fontSize: 30),
                  ),
                  title: Text(country[LocalizedStrings.name]!),
                  trailing: Text(
                    country[LocalizedStrings.currency]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    setState(
                      () =>
                          _selectedCountryCode =
                              country[LocalizedStrings.code]!,
                    );
                    Navigator.pop(context);
                  },
                );
              }).toList(),
        );
      },
    );
  }

  Widget _buildToggleSuffix() {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(
            icon: Icons.remove,
            isSelected: !_isPositive,
            activeColor: Colors.redAccent,
            onTap: () {
              setState(() => _isPositive = false);
              widget.onSignChanged?.call(false);
            },
          ),
          _buildToggleButton(
            icon: Icons.add,
            isSelected: _isPositive,
            activeColor: Colors.lightGreen,
            onTap: () {
              setState(() => _isPositive = true);
              widget.onSignChanged?.call(true);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required IconData icon,
    required bool isSelected,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? activeColor : Colors.white.withValues(alpha: 0.1),
        ),
        child: Icon(icon, size: 20, color: Colors.white),
      ),
    );
  }
  
  titleLargeB(BuildContext context) {}
}
