import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/training_provider.dart';

class TrainingScreen extends HookConsumerWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trainingNotifierProvider);
    final notifier = ref.read(trainingNotifierProvider.notifier);
    final scrollController = useScrollController();
    final searchController = useTextEditingController();

    useEffect(() {
      notifier.loadTraining();
      return null;
    }, []);

    // useEffect(() {
      // void onScroll() {
      //   if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100 &&
      //       !state.isPaginating &&
      //       state.hasMore) {
      //     notifier.loadUsers();
      //   }
      // }

      // scrollController.addListener(onScroll);
      // return () => scrollController.removeListener(onScroll);
    // }, [scrollController, state.isPaginating, state.hasMore]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Training'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onSubmitted: (value) {
                  notifier.searchTraining(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search training...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      notifier.searchTraining('');
                    },
                  ),
                ),
              ),
            ),
            Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return _buildSkeletonList();
                  }

                  if (state.errorMessage != null && state.trainings.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${state.errorMessage}'),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => notifier.loadTraining(refresh: true),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state.trainings.isEmpty) {
                    return const Center(child: Text('No Training found.'));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await notifier.loadTraining(refresh: true);
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.trainings.length + (state.isPaginating ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.trainings.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final user = state.trainings[index];
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text('ID: ${user.id}'),
                        );
                      },
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => const ListTile(
        leading: CircleAvatar(backgroundColor: Colors.grey),
        title: SkeletonBox(height: 12, width: 150),
        subtitle: SkeletonBox(height: 10, width: 100),
      ),
    );
  }


}


class SkeletonBox extends StatelessWidget {
  final double height;
  final double width;

  const SkeletonBox({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

