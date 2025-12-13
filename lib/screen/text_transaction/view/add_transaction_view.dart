import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spensr/theme/app_colors.dart';
import 'package:spensr/screen/text_transaction/viewmodel/add_transaction_view_model.dart';
import 'package:spensr/screen/text_transaction/viewmodel/get_transaction_view_model.dart';


class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetTransactionViewModel()..initialize()),
        ChangeNotifierProvider(create: (_) => AddTransactionViewModel()..fetchCategories()),
      ],
      child: Consumer2<GetTransactionViewModel, AddTransactionViewModel>(
        builder: (context, getViewModel, addViewModel, child) {
          final colors = AppColors.of(context);
          
          return Scaffold(
            backgroundColor: colors.backgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Transactions'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.add, color: colors.primaryText),
                  onPressed: () => _showAddTransactionModal(context, addViewModel, getViewModel),
                ),
              ],
            ),
            body: getViewModel.isBusy
                ? Center(child: CircularProgressIndicator(color: colors.primary))
                : _buildContent(getViewModel, colors),
            floatingActionButton: FloatingActionButton(
              backgroundColor: colors.primary,
              child: Icon(Icons.add, color: Colors.white),
              onPressed: () => _showAddTransactionModal(context, addViewModel, getViewModel),
            ),
          );
        },
      ),
    );
  }

  void _showAddTransactionModal(
    BuildContext context, 
    AddTransactionViewModel addViewModel, 
    GetTransactionViewModel getViewModel
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAddTransactionSheet(context, addViewModel, getViewModel),
    );
  }

  Widget _buildAddTransactionSheet(
    BuildContext context, 
    AddTransactionViewModel addViewModel, 
    GetTransactionViewModel getViewModel
  ) {
    final colors = AppColors.of(context);
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          color: colors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Transaction',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: colors.primaryText,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: colors.primaryText),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                
                SizedBox(height: 16),
                
                // Title Input
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.containerBG,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.disabledText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: addViewModel.transactionTitle,
                        focusNode: addViewModel.titleFocusNode,
                        style: TextStyle(
                          color: colors.primaryText,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter transaction title',
                          hintStyle: TextStyle(color: colors.disabledText),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Amount Input with Income/Expense Toggle
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.containerBG,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.disabledText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          // Income/Expense Toggle
                          Container(
                            decoration: BoxDecoration(
                              color: colors.containerBG2,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Expense Button
                                GestureDetector(
                                  onTap: () => addViewModel.onSignChange(false),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: !addViewModel.isIncome ? colors.primary : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Expense',
                                      style: TextStyle(
                                        color: !addViewModel.isIncome ? Colors.white : colors.disabledText,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                
                                // Income Button
                                GestureDetector(
                                  onTap: () => addViewModel.onSignChange(true),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: addViewModel.isIncome ? colors.primary : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Income',
                                      style: TextStyle(
                                        color: addViewModel.isIncome ? Colors.white : colors.disabledText,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          SizedBox(width: 16),
                          
                          // Amount Input Field
                          Expanded(
                            child: TextField(
                              controller: addViewModel.transactionAmount,
                              focusNode: addViewModel.amountFocusNode,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              style: TextStyle(
                                color: addViewModel.isIncome ? Colors.green : Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                hintText: '0.00',
                                hintStyle: TextStyle(color: colors.disabledText),
                                border: InputBorder.none,
                                prefixText: '\$ ',
                                prefixStyle: TextStyle(
                                  color: addViewModel.isIncome ? Colors.green : Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Categories Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colors.primaryText,
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Categories Grid
                    addViewModel.isBusy
                        ? Center(child: CircularProgressIndicator(color: colors.primary))
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: addViewModel.categories.map((category) {
                                final isSelected = addViewModel.selectedCategory == category.title;
                                
                                return GestureDetector(
                                  onTap: () => addViewModel.selectCategory(category.title ?? ''),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 12),
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isSelected ? colors.primary : colors.containerBG,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected ? colors.primary : colors.containerBG2,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          category.emoji ?? '📁',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          category.title ?? 'Unnamed',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: isSelected ? Colors.white : colors.primaryText,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                  ],
                ),
                
                SizedBox(height: 32),
                
                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: addViewModel.canAddTransaction
                        ? () async {
                            await addViewModel.onSaveTransactionPressed();
                            Navigator.pop(context);
                            await getViewModel.getSyncedTransactions();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Transaction added successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      disabledBackgroundColor: colors.disabled,
                    ),
                    child: addViewModel.isBusy
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Save Transaction',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(GetTransactionViewModel viewModel, AppColors colors) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Week Navigation
          _buildWeekNavigation(viewModel, colors),
          
          SizedBox(height: 16),
          
          // Expense and Income Summary
          _buildSummaryCards(viewModel, colors),
          
          SizedBox(height: 20),
          
          // Weekly Chart
          _buildWeeklyChart(viewModel, colors),
          
          SizedBox(height: 20),
          
          // Day selector label
          _buildDayLabel(viewModel, colors),
          
          SizedBox(height: 16),
          
          // Transaction List
          Expanded(
            child: _buildTransactionList(viewModel, colors),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekNavigation(GetTransactionViewModel viewModel, AppColors colors) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.containerBG,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, size: 20, color: colors.primaryText),
            onPressed: viewModel.goToPreviousWeek,
          ),
          Text(
            viewModel.formattedWeekRange,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colors.primaryText,
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_rounded, size: 20, color: colors.primaryText),
            onPressed: viewModel.goToNextWeek,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(GetTransactionViewModel viewModel, AppColors colors) {
    return Row(
      children: [
        // Expense Card
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.containerBG,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Expense",
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.disabledText,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "-\$${viewModel.totalExpense.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12),
        // Income Card
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.containerBG,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Income",
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.disabledText,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "+\$${viewModel.totalIncome.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyChart(GetTransactionViewModel viewModel, AppColors colors) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.containerBG,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Day labels (S M T W T F S)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: viewModel.days.map((day) {
              final index = viewModel.days.indexOf(day);
              final isSelected = viewModel.selectedDayIndex == index;
              
              return GestureDetector(
                onTap: () => viewModel.setSelectedDay(isSelected ? null : index),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? colors.primary.withOpacity(0.2) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? colors.primary : colors.primaryText,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: 16),
          
          // Chart bars
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final isSelected = viewModel.selectedDayIndex == index;
                final expenseHeight = viewModel.expenseHeights[index];
                final incomeHeight = viewModel.incomeHeights[index];
                
                return GestureDetector(
                  onTap: () => viewModel.setSelectedDay(isSelected ? null : index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Income bar (green)
                      if (incomeHeight > 0)
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: incomeHeight,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(isSelected ? 0.8 : 0.6),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 4),
                        ),
                      
                      // Expense bar (red)
                      if (expenseHeight > 0)
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: expenseHeight,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(isSelected ? 0.8 : 0.6),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayLabel(GetTransactionViewModel viewModel, AppColors colors) {
    final dayLabel = viewModel.selectedDayIndex != null
        ? viewModel.fullDayNames[viewModel.selectedDayIndex!]
        : "All Days";
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        dayLabel,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colors.primaryText,
        ),
      ),
    );
  }

  Widget _buildTransactionList(GetTransactionViewModel viewModel, AppColors colors) {
    final transactions = viewModel.selectedDayIndex != null
        ? viewModel.filteredTransactionsForSelectedDay
        : viewModel.transactions;
    
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 60, color: colors.disabledText),
            SizedBox(height: 16),
            Text(
              "No transactions found",
              style: TextStyle(
                fontSize: 16,
                color: colors.disabledText,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Tap the + button to add your first transaction",
              style: TextStyle(
                fontSize: 14,
                color: colors.disabledText.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final isIncome = transaction.isIncome == true;
        
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.containerBG,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isIncome 
                    ? Colors.green.withOpacity(0.15)
                    : Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isIncome ? Colors.green : Colors.red,
                ),
              ),
              
              SizedBox(width: 16),
              
              // Transaction details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title ?? "Untitled",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: colors.primaryText,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      transaction.category ?? "Uncategorized",
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.disabledText,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Amount
              Text(
                "${isIncome ? '+' : '-'}\$${transaction.amount?.toStringAsFixed(2) ?? '0.00'}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isIncome ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
