import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/post/post_provider.dart';
import 'package:monikid/features/post/widgets/header_widget.dart';
import 'package:monikid/features/post/widgets/loading_widget.dart';
import 'package:monikid/features/post/widgets/post_list_item.dart';
// Import file provider của bạn

class PostsListScreen extends HookConsumerWidget {
  const PostsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Lắng nghe State
    final postState = ref.watch(postProviderProvider);
    final postNotifier = ref.read(postProviderProvider.notifier);

    // 2. Khởi tạo ScrollController bằng Hook
    final scrollController = useScrollController();

    // 3. useEffect: Gọi API lần đầu tiên khi Widget được build
    useEffect(() {
      // Dùng Future.microtask để tránh lỗi gọi state trong quá trình build
      Future.microtask(() => postNotifier.load_post(reset: true));
      return null;
    }, const []);

    // 4. useEffect: Lắng nghe sự kiện cuộn để Load More
    useEffect(() {
      void onScroll() {
        // Kiểm tra nếu cuộn xuống đáy và không đang loading
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent &&
            !postState.isLoadingMore &&
            !postState.isLoading) {
          // Gọi load more (reset = false)
          postNotifier.load_post(reset: false);
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController, postState.isLoadingMore, postState.isLoading]);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Sticky Header
            const HeaderWidget(),

            // Demo Button for Local Storage
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton.icon(
                onPressed: () => postNotifier.toggleMode(),
                icon: Icon(
                  postState.isLocalMode ? Icons.cloud_download : Icons.storage,
                  color: Colors.white,
                ),
                label: Text(
                  postState.isLocalMode
                      ? 'Mode: Local Storage (Click to switch to API)'
                      : 'Mode: API (Click to switch to Local)',
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: postState.isLocalMode
                      ? Colors.green
                      : AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            // 2. Body
            Expanded(
              child: postState.isLoading && postState.postList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    ) // Loading lần đầu
                  : postState.errorMessage != null && postState.postList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              postState.errorMessage!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: () async {
                        // Kéo để làm mới
                        if (postState.isLocalMode) {
                          await postNotifier.loadFromLocal();
                        } else {
                          await postNotifier.load_post(
                            reset: true,
                            isRefesh: true,
                          );
                        }
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        // +1 item cho Loading Indicator ở cuối
                        itemCount: postState.postList.length + 1,
                        itemBuilder: (context, index) {
                          // Item cuối cùng: Hiển thị loading nếu đang load more
                          if (index == postState.postList.length) {
                            return postState.isLoadingMore
                                ? const LoadingWidget()
                                : const SizedBox(height: 20); // Padding đáy
                          }

                          final item = postState.postList[index];

                          // Hiển thị Post Item từ dữ liệu thật
                          return PostListItem(
                            title: item.title ?? 'No Title',
                            body: item.body ?? 'No Content',
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ví dụ: Thêm bài viết mới
        },
        backgroundColor: AppColors.primary,
        elevation: 4,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
