import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_simple/features/home/presentation/widgets/slider_item_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeSliderWdiget extends ConsumerWidget {
  const HomeSliderWdiget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderState = ref.watch(homeSliderNotifierProvider);
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      fit: StackFit.passthrough,
      children: [
        sliderState.when(
            data: (state) {

              return state.sliders.isEmpty
                  ? SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Center(child: Text('No data found')))
                  : CarouselSlider.builder(
                  itemCount: state.sliders.length,
                  itemBuilder: (context, index, realIndex) {
                    final slide = state.sliders[index];
                    return SliderItemWidget(slide: slide);
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    height: 180,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      ref.read(homeSliderNotifierProvider.notifier).setCurrentSlide(index);
                    },
                  )
              );
            },
          error: (error, stack) => Center(child: Text('Error: $error')),
          loading: () => const HomeSliderLoaderWidget(),
        ),


      ],
    );
  }
}


class HomeSliderLoaderWidget extends StatelessWidget {
  const HomeSliderLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.asset('assets/img/loading.gif', fit: BoxFit.cover),
      ),
    );
  }
}