import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/data_providers/orders_provider.dart';
import 'package:kabir_admin_panel/core/data_providers/riders_provider.dart';
import 'package:kabir_admin_panel/core/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  OrderDetailsScreen({super.key, required this.orderId});

  late OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Consumer2<OrdersProvider, RidersProvider>(
        builder: (context, ordersProvider, ridersProvider, child) {
      order = ordersProvider.orders.firstWhere(
        (order) => order.id == orderId,
        orElse: () => OrderModel(),
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Order ID: #${order.id}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(width: 12),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(order.status ?? 'Pending',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 16, color: Colors.grey.shade600),
                        SizedBox(width: 8),
                        Text(
                            '${order.createdAt?.hour}:${order.createdAt?.minute} ${order.createdAt?.day}-${order.createdAt?.month}-${order.createdAt?.year}',
                            style: TextStyle(color: Colors.grey.shade600)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Payment Type: Cash On Delivery',
                        style: TextStyle(color: Colors.grey.shade600)),
                    SizedBox(height: 8),
                    Text('Order Type: Delivery',
                        style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
                // Right side buttons
                Row(
                  children: [
                    PopupMenuButton<String>(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Text(order.status ?? 'Pending'),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: pendingOrderString,
                          child: Text(pendingOrderString),
                        ),
                        PopupMenuItem(
                          value: processingOrderString,
                          child: Text(processingOrderString),
                        ),
                        PopupMenuItem(
                          value: outForDeliveryOrderString,
                          child: Text(outForDeliveryOrderString),
                        ),
                        PopupMenuItem(
                          value: deliveredOrderString,
                          child: Text(deliveredOrderString),
                        ),
                        PopupMenuItem(
                          value: returnedOrderString,
                          child: Text(returnedOrderString),
                        ),
                      ],
                      onSelected: (String status) async {
                        try {
                          await FirebaseFirestore.instance
                              .collection('orders')
                              .doc(order.id)
                              .update({'status': status});

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Order status updated successfully')));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Failed to update order status')));
                        }
                      },
                    ),
                    SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.print),
                      label: Text('Print Invoice'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 4),

          // Main content
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side - Order details
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(height: 16),
                        // Order items
                        ...order.items?.map((item) => OrderItemTile(
                                  image: 'assets/food_placeholder.jpg',
                                  title: item.item?.title ?? '',
                                  subtitle: 'Quantity: ${item.quantity}',
                                  quantity: item.quantity.toString(),
                                  price: '\$${item.totalPrice}',
                                )) ??
                            [],
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 24),
                // Right side - Summary and delivery info
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    // height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              _buildSummaryRow(
                                  'Subtotal', '\$${order.subtotal}'),
                              _buildSummaryRow(
                                  'Discount', '\$${order.discount}'),
                              _buildSummaryRow('Delivery Charge',
                                  '\$${order.deliveryCharges}',
                                  valueColor: Colors.green),
                              //  Divider(height: 32),
                              _buildSummaryRow('Total', '\$${order.total}',
                                  isBold: true),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text('Delivery Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  )),
                              //SizedBox(height: 16),
                              _buildDeliveryInfo(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSummaryRow(String label, String value,
      {Color? valueColor, bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: isBold ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 20,
              child: Text('WS'),
            ),
            SizedBox(width: 12),
            Text(order.userName ?? 'Customer',
                style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.phone_outlined, size: 20, color: Colors.grey),
            SizedBox(width: 8),
            Text(order.userPhone ?? ''),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 20, color: Colors.grey),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.deliveryAddress?.address ?? ''),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class OrderItemTile extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String quantity;
  final String price;

  const OrderItemTile({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(quantity,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  )),
            ),
          ),
          SizedBox(width: 16),
          Text(price, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
