import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/models/order.dart';
import 'package:kabir_admin_panel/core/models/item.dart';
import 'package:kabir_admin_panel/core/models/appUser.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';

class DashboardProvider extends ChangeNotifier {
  final DatabaseServices _databaseServices = DatabaseServices();

  // Loading states
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // Data lists
  List<OrderModel> _orders = [];
  List<Item> _items = [];
  List<AppUser> _users = [];

  List<OrderModel> get orders => _orders;
  List<Item> get items => _items;
  List<AppUser> get users => _users;

  // Dashboard Statistics
  Map<String, dynamic> _dashboardStats = {
    'totalSales': 0.0,
    'totalOrders': 0,
    'totalCustomers': 0,
    'totalItems': 0,
    'pendingOrders': 0,
    'processingOrders': 0,
    'deliveredOrders': 0,
    'canceledOrders': 0,
    'outForDeliveryOrders': 0,
    'returnedOrders': 0,
    'rejectedOrders': 0,
    'avgSalesPerDay': 0.0,
    'featuredItems': <Item>[],
    'popularItems': <Item>[],
    'topCustomers': <AppUser>[],
  };

  Map<String, dynamic> get dashboardStats => _dashboardStats;

  // Sales data for graphs
  List<SalesData> _salesData = [];
  List<SalesData> get salesData => _salesData;

  // Customer stats for hourly chart
  List<CustomerData> _customerData = [];
  List<CustomerData> get customerData => _customerData;

  // Order summary for pie chart
  List<OrderSummaryData> _orderSummaryData = [];
  List<OrderSummaryData> get orderSummaryData => _orderSummaryData;

  DashboardProvider() {
    initializeDashboard();
  }

  Future<void> initializeDashboard() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Start listening to real-time data
      _listenToOrders();
      _listenToItems();

      // Load initial data
      await _loadDashboardData();
    } catch (e) {
      print('Error initializing dashboard: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _listenToOrders() {
    _databaseServices.getOrdersStream().listen((orders) {
      _orders = orders;
      _calculateOrderStats();
      _generateSalesData();
      _generateOrderSummaryData();
      _generateCustomerData();
      notifyListeners();
    });
  }

  void _listenToItems() {
    _databaseServices.getItemsStream().listen((items) {
      _items = items;
      _calculateItemStats();
      notifyListeners();
    });
  }

  Future<void> _loadDashboardData() async {
    // Additional data loading if needed
    // This can be expanded based on your requirements
  }

  void _calculateOrderStats() {
    if (_orders.isEmpty) return;

    _dashboardStats['totalOrders'] = _orders.length;
    _dashboardStats['totalSales'] =
        _orders.fold<double>(0, (sum, order) => sum + (order.total ?? 0));

    // Calculate average sales per day
    if (_orders.isNotEmpty) {
      final now = DateTime.now();
      final firstOrderDate = _orders
          .map((o) => o.createdAt)
          .where((date) => date != null)
          .reduce((a, b) => a!.isBefore(b!) ? a : b);
      if (firstOrderDate != null) {
        final daysDiff = now.difference(firstOrderDate).inDays + 1;
        _dashboardStats['avgSalesPerDay'] =
            _dashboardStats['totalSales'] / daysDiff;
      }
    }

    // Count orders by status
    _dashboardStats['pendingOrders'] =
        _orders.where((o) => o.status == pendingOrderString).length;
    _dashboardStats['processingOrders'] =
        _orders.where((o) => o.status == processingOrderString).length;
    _dashboardStats['deliveredOrders'] =
        _orders.where((o) => o.status == deliveredOrderString).length;
    _dashboardStats['canceledOrders'] =
        _orders.where((o) => o.status == canceledOrderString).length;
    _dashboardStats['outForDeliveryOrders'] =
        _orders.where((o) => o.status == outForDeliveryOrderString).length;
    _dashboardStats['returnedOrders'] =
        _orders.where((o) => o.status == returnedOrderString).length;
    _dashboardStats['rejectedOrders'] =
        _orders.where((o) => o.status == rejectedOrderString).length;

    // Get unique customers
    final uniqueCustomers =
        _orders.map((o) => o.userId).where((id) => id != null).toSet();
    _dashboardStats['totalCustomers'] = uniqueCustomers.length;
  }

  void _calculateItemStats() {
    if (_items.isEmpty) return;

    _dashboardStats['totalItems'] = _items.length;
    _dashboardStats['featuredItems'] =
        _items.where((item) => item.isFeatured == true).take(5).toList();

    // Calculate popular items based on order frequency
    Map<String, int> itemOrderCount = {};
    for (var order in _orders) {
      if (order.items != null) {
        for (var orderItem in order.items!) {
          if (orderItem.item?.id != null) {
            itemOrderCount[orderItem.item!.id!] =
                (itemOrderCount[orderItem.item!.id!] ?? 0) + orderItem.quantity;
          }
        }
      }
    }

    var sortedItems =
        _items.where((item) => itemOrderCount.containsKey(item.id)).toList();
    sortedItems.sort((a, b) =>
        (itemOrderCount[b.id] ?? 0).compareTo(itemOrderCount[a.id] ?? 0));
    _dashboardStats['popularItems'] = sortedItems.take(5).toList();
  }

  void _generateSalesData() {
    _salesData.clear();
    final now = DateTime.now();

    // Generate sales data for last 31 days
    for (int i = 30; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dayOrders = _orders
          .where((order) =>
              order.createdAt != null &&
              order.createdAt!.year == date.year &&
              order.createdAt!.month == date.month &&
              order.createdAt!.day == date.day)
          .toList();

      final dailySales =
          dayOrders.fold<double>(0, (sum, order) => sum + (order.total ?? 0));
      _salesData.add(SalesData('${date.day}', dailySales));
    }
  }

  void _generateCustomerData() {
    _customerData.clear();

    // Generate customer activity data for 24 hours
    for (int hour = 0; hour < 24; hour++) {
      final hourOrders = _orders
          .where((order) =>
              order.createdAt != null && order.createdAt!.hour == hour)
          .length;

      _customerData.add(CustomerData(
          '${hour.toString().padLeft(2, '0')}:00', hourOrders.toDouble()));
    }
  }

  void _generateOrderSummaryData() {
    _orderSummaryData.clear();

    if (_orders.isEmpty) return;

    final totalOrders = _orders.length.toDouble();
    final delivered = _orders.where((o) => o.status == 'delivered').length;
    final returned = _orders.where((o) => o.status == 'returned').length;
    final canceled = _orders.where((o) => o.status == 'canceled').length;
    final rejected = _orders.where((o) => o.status == 'rejected').length;

    _orderSummaryData
        .add(OrderSummaryData('Delivered', (delivered / totalOrders * 100)));
    _orderSummaryData
        .add(OrderSummaryData('Returned', (returned / totalOrders * 100)));
    _orderSummaryData
        .add(OrderSummaryData('Canceled', (canceled / totalOrders * 100)));
    _orderSummaryData
        .add(OrderSummaryData('Rejected', (rejected / totalOrders * 100)));
  }

  Future<void> refreshData() async {
    await initializeDashboard();
  }
}

// Data models for charts
class SalesData {
  final String date;
  final double sales;

  SalesData(this.date, this.sales);
}

class CustomerData {
  final String hour;
  final double count;

  CustomerData(this.hour, this.count);
}

class OrderSummaryData {
  final String status;
  final double percentage;

  OrderSummaryData(this.status, this.percentage);
}
