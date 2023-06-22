import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../repositories/list_repository.dart';

class ListController extends GetxController {
  static ListController get to => Get.find<ListController>();
  late final ListRepository repository;
  final RxInt page = 0.obs;
  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> selectedItems =
      <Map<String, dynamic>>[].obs;
  final RxBool canLoadMore = true.obs;
  final RxString selectedCategory = 'all'.obs;
  final RxString keyword = ''.obs;
  final List<String> categories = [
    'All',
    'Food',
    'Drink',
  ];
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    super.onInit();
    repository = ListRepository();
    await getListOfData();
  }

  void onRefresh() async {
    page(0);
    canLoadMore(true);
    final result = await getListOfData();
    if (result) {
      refreshController.refreshCompleted();
    } else {
      refreshController.refreshFailed();
    }
  }

  List<Map<String, dynamic>> get filteredList => items
      .where((element) =>
          element['name']
              .toString()
              .toLowerCase()
              .contains(keyword.value.toLowerCase()) &&
          (selectedCategory.value == 'all' ||
              element['category'] == selectedCategory.value))
      .toList();

  Future<bool> getListOfData() async {
    try {
      final result = repository.getListOfData(
        offset: page.value * 5,
      );
      if (result['previous'] == null) {
        items.clear();
      }

      if (result['next'] == null) {
        canLoadMore(false);
        refreshController.loadNoData();
      }

      items.addAll(result['data']);
      page.value++;
      refreshController.loadComplete();
      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      refreshController.loadFailed();
      return false;
    }
  }

  Future<void> deleteItem(Map<String, dynamic> item) async {
    try {
      repository.deleteItem(item['id_menu']);
      items.remove(item);
      selectedItems.remove(item);
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}