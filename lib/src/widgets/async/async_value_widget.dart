import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../resources/labels.dart';

enum ProgressIndicatorType {
  none,
  circular,
  shimmer,
}

Widget _defaultLoadingBuilder(BuildContext context) => const SizedBox();

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T, BuildContext) dataBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValueWidget({
    required this.asyncValue,
    required this.dataBuilder,
    this.loadingBuilder,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return _AsyncValuesWidget(
      asyncValues: [asyncValue],
      dataBuilder: (values, context) => dataBuilder(values[0], context),
      loadingBuilder: loadingBuilder,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}

class AsyncValuesWidget2<T1, T2> extends StatelessWidget {
  final AsyncValue<T1> asyncValue1;
  final AsyncValue<T2> asyncValue2;
  final Widget Function(T1, T2, BuildContext) dataBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValuesWidget2({
    required this.asyncValue1,
    required this.asyncValue2,
    required this.dataBuilder,
    this.loadingBuilder,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return _AsyncValuesWidget(
      asyncValues: [asyncValue1, asyncValue2],
      dataBuilder: (values, context) => dataBuilder(
        values[0],
        values[1],
        context,
      ),
      loadingBuilder: loadingBuilder,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}

class AsyncValuesWidget3<T1, T2, T3> extends StatelessWidget {
  final AsyncValue<T1> asyncValue1;
  final AsyncValue<T2> asyncValue2;
  final AsyncValue<T3> asyncValue3;
  final Widget Function(T1, T2, T3, BuildContext) dataBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValuesWidget3({
    required this.asyncValue1,
    required this.asyncValue2,
    required this.asyncValue3,
    required this.dataBuilder,
    this.loadingBuilder,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return _AsyncValuesWidget(
      asyncValues: [asyncValue1, asyncValue2, asyncValue3],
      dataBuilder: (values, context) => dataBuilder(
        values[0],
        values[1],
        values[2],
        context,
      ),
      loadingBuilder: loadingBuilder,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}

class _AsyncValuesWidget extends StatelessWidget {
  final List<AsyncValue> asyncValues;
  final Widget Function(List, BuildContext) dataBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const _AsyncValuesWidget({
    required this.asyncValues,
    required this.dataBuilder,
    this.loadingBuilder,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context) {
    // Check if any of the AsyncValue objects are still loading
    if (asyncValues.any((av) => av.isLoading)) {
      return (loadingBuilder ?? _defaultLoadingBuilder)(context);
    }

    final errorIndex = asyncValues.indexWhere((av) => av.hasError);
    if (errorIndex != -1) {
      final error = asyncValues[errorIndex].error!;
      final stackTrace = asyncValues[errorIndex].stackTrace;

      FlutterError.reportError(FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'AsyncValuesWidget',
        context: ErrorDescription('while building async data widget'),
      ));

      return showErrorIndicator != false
          ? Center(child: Text(asyncValues[errorIndex].error.toString()))
          : const SizedBox();
    }

    final values = asyncValues.map((av) => av.value).toList();
    if (showNoDataIndicator == true && values.any((v) => v == null)) {
      return const Center(child: Text(Labels.noDataFound));
    }

    return dataBuilder(values, context);
  }
}

class AsyncValueProviderWidget<T> extends ConsumerWidget {
  final ProviderListenable<AsyncValue<T>> provider;
  final Widget Function(T, BuildContext, WidgetRef) dataBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValueProviderWidget({
    required this.provider,
    required this.dataBuilder,
    this.loadingBuilder,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider);
    return AsyncValueWidget<T>(
      asyncValue: asyncValue,
      dataBuilder: (value, _) => dataBuilder(value, context, ref),
      loadingBuilder: loadingBuilder,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}

class AsyncValueProviderWidget2<T1, T2> extends ConsumerWidget {
  final ProviderListenable<AsyncValue<T1>> provider1;
  final ProviderListenable<AsyncValue<T2>> provider2;
  final Widget Function(T1, T2, BuildContext, WidgetRef) dataBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValueProviderWidget2({
    required this.provider1,
    required this.provider2,
    required this.dataBuilder,
    this.loadingBuilder,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _AsyncValuesProviderWidget(
      providers: [provider1, provider2],
      dataBuilder: (values, _, __) => dataBuilder(
        values[0],
        values[1],
        context,
        ref,
      ),
      loadingBuilder: loadingBuilder,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}

class AsyncValueProviderWidget3<T1, T2, T3> extends ConsumerWidget {
  final ProviderListenable<AsyncValue<T1>> provider1;
  final ProviderListenable<AsyncValue<T2>> provider2;
  final ProviderListenable<AsyncValue<T3>> provider3;
  final Widget Function(T1, T2, T3, BuildContext, WidgetRef) dataBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValueProviderWidget3({
    required this.provider1,
    required this.provider2,
    required this.provider3,
    required this.dataBuilder,
    this.loadingBuilder,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _AsyncValuesProviderWidget(
      providers: [provider1, provider2, provider3],
      dataBuilder: (values, _, __) => dataBuilder(
        values[0],
        values[1],
        values[2],
        context,
        ref,
      ),
      loadingBuilder: loadingBuilder,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}

class AsyncValueProviderWidget4<T1, T2, T3, T4> extends ConsumerWidget {
  final ProviderListenable<AsyncValue<T1>> provider1;
  final ProviderListenable<AsyncValue<T2>> provider2;
  final ProviderListenable<AsyncValue<T3>> provider3;
  final ProviderListenable<AsyncValue<T4>> provider4;
  final Widget Function(T1, T2, T3, T4, BuildContext, WidgetRef) dataBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValueProviderWidget4({
    required this.provider1,
    required this.provider2,
    required this.provider3,
    required this.provider4,
    required this.dataBuilder,
    this.loadingBuilder,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _AsyncValuesProviderWidget(
      providers: [provider1, provider2, provider3, provider4],
      dataBuilder: (values, _, __) => dataBuilder(
        values[0],
        values[1],
        values[2],
        values[3],
        context,
        ref,
      ),
      loadingBuilder: loadingBuilder,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}

class _AsyncValuesProviderWidget extends ConsumerWidget {
  final List<ProviderListenable<AsyncValue>> providers;
  final Widget Function(List, BuildContext, WidgetRef) dataBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const _AsyncValuesProviderWidget({
    required this.providers,
    required this.dataBuilder,
    this.loadingBuilder,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValues = providers
        .map(
          (provider) => ref.watch(provider),
        )
        .toList();

    return _AsyncValuesWidget(
      asyncValues: asyncValues,
      dataBuilder: (values, _) => dataBuilder(
        values,
        context,
        ref,
      ),
      loadingBuilder: loadingBuilder,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}
