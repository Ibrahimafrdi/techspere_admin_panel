import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabir_admin_panel/core/constants/collection_identifiers.dart';
import 'package:kabir_admin_panel/core/models/addon.dart';
import 'package:kabir_admin_panel/core/models/appUser.dart';
import 'package:kabir_admin_panel/core/models/category.dart';
import 'package:kabir_admin_panel/core/models/item.dart';
import 'package:kabir_admin_panel/core/models/order.dart';
import 'package:kabir_admin_panel/core/models/rider.dart';
import 'package:kabir_admin_panel/core/models/shipping.dart';

class DatabaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUser(AppUser user) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      print('Error creating user: $e');
      // You might want to rethrow the error or handle it in a specific way
      throw Exception('Failed to create user');
    }
  }

  Future<AppUser?> getUser(String id) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(id)
          .get();
      if (snapshot.data() != null) {
        AppUser appUser = AppUser.fromJson(snapshot.data()!);
        return appUser;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Stream<AppUser> getUserStream(String userId) {
    try {
      return firestore
          .collection(usersCollection)
          .doc(userId)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          return AppUser.fromJson(snapshot.data() as Map<String, dynamic>);
        } else {
          throw Exception('User not found');
        }
      });
    } catch (e) {
      print('Error getting user: $e');
      // You might want to return an empty stream or rethrow the exception
      return Stream.error(Exception('Failed to get user'));
    }
  }

  Future<void> updateUser(AppUser user) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(user.id)
          .update(user.toJson());
    } catch (e) {
      print('Error updating user: $e');
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String userId) async {
    await firestore.collection(usersCollection).doc(userId).delete();
  }

  Future<OrderModel> getOrder(String orderId) async {
    DocumentSnapshot orderSnapshot =
        await firestore.collection(ordersCollection).doc(orderId).get();
    return OrderModel.fromJson(
        orderSnapshot.data() as Map<String, dynamic>, orderSnapshot.id);
  }

  Future<void> updateOrder(OrderModel order) async {
    await firestore
        .collection(ordersCollection)
        .doc(order.id)
        .update(order.toJson());
  }

  Future<void> deleteOrder(String orderId) async {
    await firestore.collection(ordersCollection).doc(orderId).delete();
  }

  Stream<List<OrderModel>> getOrdersStream() {
    return firestore.collection(ordersCollection).snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) =>
                OrderModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  Stream<List<OrderModel>> getOrdersByUserId(String userId) {
    return firestore
        .collection(ordersCollection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                OrderModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  Stream<List<Item>> getItemsStream() {
    return firestore.collection(itemsCollection).snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) =>
                Item.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  Future<void> addItem(Item item) async {
    await firestore.collection(itemsCollection).doc(item.id).set(
          item.toJson(),
        );
  }

  Future<void> deleteItem(String id) async {
    await firestore.collection(itemsCollection).doc(id).delete();
  }

  Stream<List<Category>> getCategoriesStream() {
    try {
      return firestore.collection(categoriesCollection).snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Category.fromJson(
                    doc.data() as Map<String, dynamic>,
                    doc.id,
                  ),
                )
                .toList(),
          );
    } catch (e) {
      print('Error getting categories: ');
      return Stream.empty();
    }
  }

  Future<void> addCategory(Category category) async {
    await firestore
        .collection(categoriesCollection)
        .doc(category.id)
        .set(category.toJson());
  }

  Future<void> deleteCategory(String id) async {
    await firestore.collection(categoriesCollection).doc(id).delete();
  }

  Future<void> addAddon(Addon addon) async {
    await firestore
        .collection(addonsCollection)
        .doc(addon.id)
        .set(addon.toJson());
  }

  Future<void> deleteAddon(String id) async {
    await firestore.collection(addonsCollection).doc(id).delete();
  }

  Stream<List<Addon>> getAddonsStream() {
    try {
      return firestore.collection(addonsCollection).snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Addon.fromJson(
                    doc.data() as Map<String, dynamic>,
                    doc.id,
                  ),
                )
                .toList(),
          );
    } catch (e) {
      print('Error getting categories: ');
      return Stream.empty();
    }
  }

  Future<List<Rider>> getRiders() async {
    try {
      final snapshot = await firestore.collection('riders').get();
      return snapshot.docs
          .map((doc) => Rider.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error getting riders: $e');
      return [];
    }
  }

  Future<void> addRider(Rider rider) async {
    try {
      await firestore.collection('riders').doc(rider.id).set(rider.toMap());
    } catch (e) {
      print('Error adding rider: $e');
    }
  }

  Future<void> updateRider(Rider rider) async {
    try {
      await firestore.collection('riders').doc(rider.id).update(rider.toMap());
    } catch (e) {
      print('Error updating rider: $e');
    }
  }

  Future<void> deleteRider(String id) async {
    try {
      await firestore.collection('riders').doc(id).delete();
    } catch (e) {
      print('Error deleting rider: $e');
    }
  }

  Stream<List<Rider>> getRidersStream() {
    try {
      return firestore.collection('riders').snapshots().map((snapshot) =>
          snapshot.docs
              .map((doc) => Rider.fromMap(doc.data(), doc.id))
              .toList());
    } catch (e) {
      print('Error getting riders stream: $e');
      return Stream.empty();
    }
  }

  Stream<List<Shipping>> getShippingsStream() {
    try {
      return firestore.collection(shippingsCollection).snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Shipping.fromJson(
                    doc.data() as Map<String, dynamic>,
                    doc.id,
                  ),
                )
                .toList(),
          );
    } catch (e) {
      print('Error getting shipping areas: $e');
      return Stream.empty();
    }
  }

  Future<void> addShipping(Shipping shipping) async {
    await firestore
        .collection(shippingsCollection)
        .doc(shipping.id)
        .set(shipping.toJson());
  }

  Future<void> deleteShipping(String id) async {
    await firestore.collection(shippingsCollection).doc(id).delete();
  }
  
}
