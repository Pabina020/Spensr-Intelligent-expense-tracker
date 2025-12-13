
import 'package:flutter/material.dart';

class TransactionModel {
  final String? id;
  final String? title;
  final double? amount;
  final String? category;
  final bool? isIncome;
  final String? createdAt;

  TransactionModel({
    this.id,
    this.title,
    this.amount,
    this.category,
    this.isIncome,
    this.createdAt,
  });
}

class GetTransactionViewModel extends ChangeNotifier {
  final List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
  final List<String> fullDayNames = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  DateTime _currentWeekStart = _getStartOfWeek(DateTime.now());
  int? selectedDayIndex;

  DateTime get currentWeekStart => _currentWeekStart;
  DateTime get currentWeekEnd => _currentWeekStart.add(Duration(days: 6));

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  static DateTime _getStartOfWeek(DateTime date) {
    final day = date.weekday % 7;
    return DateTime(date.year, date.month, date.day - day);
  }

  void goToNextWeek() {
    final now = DateTime.now();
    final startOfToday = _getStartOfWeek(now);
    final nextWeek = _currentWeekStart.add(Duration(days: 7));

    if (!nextWeek.isAfter(startOfToday)) {
      _currentWeekStart = nextWeek;
      selectedDayIndex = null;
      getSyncedTransactions();
    }
  }

  void goToPreviousWeek() {
    _currentWeekStart = _currentWeekStart.subtract(Duration(days: 7));
    selectedDayIndex = null;
    getSyncedTransactions();
  }

  void setSelectedDay(int? index) {
    selectedDayIndex = index;
    notifyListeners();
  }

  String get formattedWeekRange {
    final start = currentWeekStart;
    final end = currentWeekEnd;
    final monthName = _monthName(start.month);
    return "${start.day}-${end.day} $monthName, ${start.year}";
  }

  String _monthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return months[month];
  }

  // Calculate max transaction amount for chart scaling
  double get _maxTransactionAmountThisWeek {
    if (_transactions.isEmpty) return 1.0;
    
    double maxAmount = 0;
    for (int i = 0; i < 7; i++) {
      final date = _currentWeekStart.add(Duration(days: i));
      double dayTotal = 0;
      
      for (var tx in _transactions) {
        final created = DateTime.tryParse(tx.createdAt ?? '');
        if (created != null &&
            created.year == date.year &&
            created.month == date.month &&
            created.day == date.day) {
          dayTotal += tx.amount ?? 0;
        }
      }
      
      if (dayTotal > maxAmount) maxAmount = dayTotal;
    }
    
    return maxAmount > 0 ? maxAmount : 1.0;
  }

  List<double> get expenseHeights {
    return List.generate(7, (index) {
      final date = _currentWeekStart.add(Duration(days: index));
      double dayExpenses = 0;
      
      for (var tx in _transactions) {
        final created = DateTime.tryParse(tx.createdAt ?? '');
        if (created != null &&
            created.year == date.year &&
            created.month == date.month &&
            created.day == date.day &&
            tx.isIncome == false) {
          dayExpenses += tx.amount ?? 0;
        }
      }
      
      const maxBarHeight = 100.0;
      final maxAmount = _maxTransactionAmountThisWeek;
      return maxAmount > 0 ? (dayExpenses / maxAmount) * maxBarHeight : 0;
    });
  }

  List<double> get incomeHeights {
    return List.generate(7, (index) {
      final date = _currentWeekStart.add(Duration(days: index));
      double dayIncome = 0;
      
      for (var tx in _transactions) {
        final created = DateTime.tryParse(tx.createdAt ?? '');
        if (created != null &&
            created.year == date.year &&
            created.month == date.month &&
            created.day == date.day &&
            tx.isIncome == true) {
          dayIncome += tx.amount ?? 0;
        }
      }
      
      const maxBarHeight = 100.0;
      final maxAmount = _maxTransactionAmountThisWeek;
      return maxAmount > 0 ? (dayIncome / maxAmount) * maxBarHeight : 0;
    });
  }

  Future<void> getSyncedTransactions() async {
    _isBusy = true;
    notifyListeners();
    
    try {
      await Future.delayed(Duration(seconds: 1)); // Simulate API call
      
      // Generate transactions for the current week
      _transactions = _generateSampleTransactions();
    } catch (e) {
      print('Error fetching transactions: $e');
      _transactions = [];
    } finally {
      _isBusy = false;
      notifyListeners();
    }
  }

  List<TransactionModel> _generateSampleTransactions() {
    final weekStart = _currentWeekStart;
    
    // Generate transactions for each day of the week
    List<TransactionModel> sampleTransactions = [];
    
    for (int i = 0; i < 7; i++) {
      final date = weekStart.add(Duration(days: i));
      
      // Add some income transactions
      if (i == 2 || i == 4) { // Tuesday and Thursday
        sampleTransactions.add(
          TransactionModel(
            id: 'inc_$i',
            title: i == 2 ? 'Work Salary' : 'Freelance Work',
            amount: i == 2 ? 1220.00 : 350.00,
            category: 'Salary',
            isIncome: true,
            createdAt: date.toIso8601String(),
          ),
        );
      }
      
      // Add some expense transactions
      if (i == 0 || i == 1 || i == 3 || i == 5 || i == 6) {
        List<Map<String, dynamic>> expenses = [];
        
        if (i == 0) expenses.add({'title': 'Educational Fees', 'amount': 298.89, 'category': 'Education'});
        if (i == 1) expenses.add({'title': 'Food', 'amount': 28.89, 'category': 'Food'});
        if (i == 1) expenses.add({'title': 'Restaurants', 'amount': 10.00, 'category': 'Food'});
        if (i == 3) expenses.add({'title': 'Grocery', 'amount': 45.67, 'category': 'Food'});
        if (i == 5) expenses.add({'title': 'Movie Tickets', 'amount': 25.00, 'category': 'Entertainment'});
        if (i == 6) expenses.add({'title': 'Weekend Trip', 'amount': 150.00, 'category': 'Travel'});
        
        for (var expense in expenses) {
          sampleTransactions.add(
            TransactionModel(
              id: 'exp_${i}_${expense['title']}',
              title: expense['title'],
              amount: expense['amount'],
              category: expense['category'],
              isIncome: false,
              createdAt: date.toIso8601String(),
            ),
          );
        }
      }
    }
    
    return sampleTransactions;
  }

  List<TransactionModel> get filteredTransactionsForSelectedDay {
    if (selectedDayIndex == null) return _transactions;

    final selectedDate = currentWeekStart.add(Duration(days: selectedDayIndex!));
    
    return _transactions.where((tx) {
      final created = DateTime.tryParse(tx.createdAt ?? '');
      return created != null &&
          created.year == selectedDate.year &&
          created.month == selectedDate.month &&
          created.day == selectedDate.day;
    }).toList();
  }

  double get totalExpense {
    final list = selectedDayIndex == null
        ? _transactions
        : filteredTransactionsForSelectedDay;
    
    double total = 0;
    for (var tx in list) {
      if (tx.isIncome == false) {
        total += tx.amount ?? 0;
      }
    }
    return total;
  }

  double get totalIncome {
    final list = selectedDayIndex == null
        ? _transactions
        : filteredTransactionsForSelectedDay;
    
    double total = 0;
    for (var tx in list) {
      if (tx.isIncome == true) {
        total += tx.amount ?? 0;
      }
    }
    return total;
  }

  void initialize() {
    getSyncedTransactions();
  }
}
