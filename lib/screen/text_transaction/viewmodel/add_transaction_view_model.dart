
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

// Define the missing services and helper classes
class TransactionSyncService {
  Future<void> addTransaction({
    required String title,
    required double amount,
    required String category,
    required bool isIncome,
  }) async {
    print('Transaction added: $title, $amount, $category, $isIncome');
    await Future.delayed(Duration(seconds: 1)); // Simulate API call
    // TODO: Implement actual transaction saving
  }
}

// Simple Category model
class Category {
  final int id;
  final String? title;
  final String? emoji;
  
  Category({
    required this.id,
    this.title,
    this.emoji,
  });
}

class AddTransactionViewModel extends BaseViewModel {
  final TransactionSyncService _transactionSyncService = TransactionSyncService();

  final FocusNode titleFocusNode = FocusNode();
  final FocusNode amountFocusNode = FocusNode();

  bool isIncome = false;

  final transactionTitle = TextEditingController();
  final transactionAmount = TextEditingController();

  String _selectedCategory = "";
  String get selectedCategory => _selectedCategory;

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  bool get canAddTransaction =>
      transactionTitle.text.isNotEmpty &&
      transactionAmount.text.isNotEmpty &&
      selectedCategory.isNotEmpty;

  Future<void> fetchCategories() async {
    setBusy(true);

    try {
      // Simulate API delay
      await Future.delayed(Duration(milliseconds: 500));
      
      // Sample categories - replace with your actual data source
      _categories = [
        Category(id: 1, title: 'Food', emoji: '🍕'),
        Category(id: 2, title: 'Transport', emoji: '🚗'),
        Category(id: 3, title: 'Shopping', emoji: '🛍️'),
        Category(id: 4, title: 'Entertainment', emoji: '🎬'),
        Category(id: 5, title: 'Education', emoji: '📚'),
        Category(id: 6, title: 'Healthcare', emoji: '🏥'),
        Category(id: 7, title: 'Salary', emoji: '💰'),
        Category(id: 8, title: 'Investment', emoji: '📈'),
        Category(id: 9, title: 'Rent', emoji: '🏠'),
        Category(id: 10, title: 'Utilities', emoji: '💡'),
        Category(id: 11, title: 'Travel', emoji: '✈️'),
        Category(id: 12, title: 'Other', emoji: '📁'),
      ];
      
      // Sort by id
      _categories.sort((a, b) => b.id.compareTo(a.id));

    } catch (e) {
      print('Error fetching categories: $e');
      // Fallback categories
      _categories = [
        Category(id: 1, title: 'Food', emoji: '🍕'),
        Category(id: 2, title: 'Transport', emoji: '🚗'),
        Category(id: 3, title: 'Shopping', emoji: '🛍️'),
        Category(id: 4, title: 'Entertainment', emoji: '🎬'),
      ];
    }

    setBusy(false);
    notifyListeners();
  }

  Future<void> onSaveTransactionPressed() async {
    return runBusyFuture(_onSaveTransactionPressed());
  }

  Future<void> _onSaveTransactionPressed() async {
    final title = transactionTitle.text.trim();
    final amountText = transactionAmount.text.trim();
    final amount = double.tryParse(amountText);
    
    if (amount == null) {
      // You could show an error message here
      print('Invalid amount: $amountText');
      return;
    }

    await _transactionSyncService.addTransaction(
      title: title,
      amount: amount,
      category: selectedCategory,
      isIncome: isIncome,
    );

    // Clear form after successful save
    transactionTitle.clear();
    transactionAmount.clear();
    _selectedCategory = "";
    
    notifyListeners();
    
    // Return success
    return;
  }

  void showAllCategories(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAllCategoriesBottomSheet(context),
    );
  }

  Widget _buildAllCategoriesBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'All Categories',
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _categories.map((category) {
              return ChoiceChip(
                label: Text(category.title ?? 'Unnamed'),
                selected: selectedCategory == category.title,
                onSelected: (_) {
                  selectCategory(category.title ?? '');
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void addNewCategories(BuildContext context) async {
    FocusScope.of(context).unfocus();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAddCategoryBottomSheet(context),
    );

    await fetchCategories();
  }

  Widget _buildAddCategoryBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add New Category',
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 16),
          // Simple form for adding category
          TextField(
            decoration: InputDecoration(
              hintText: 'Category name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement category creation
              Navigator.pop(context);
            },
            child: Text('Add Category'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void onLoginPressed() {
    // TODO: Implement login navigation
    print('Login pressed');
  }

  void onSignChange(bool value) {
    isIncome = value;
    notifyListeners();
  }

  @override
  void dispose() {
    titleFocusNode.dispose();
    amountFocusNode.dispose();
    transactionTitle.dispose();
    transactionAmount.dispose();
    super.dispose();
  }
}
