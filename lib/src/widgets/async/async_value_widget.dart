import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../resources/labels.dart';
import '../progress_indicator/progress_indicator.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T, BuildContext) dataBuilder;
  final bool? showProgressIndicator;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValueWidget(
    this.asyncValue,
    this.dataBuilder, {
    this.showProgressIndicator,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return _AsyncValuesWidget(
      [asyncValue],
      (values, context) => dataBuilder(values[0], context),
      showProgressIndicator: showProgressIndicator,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}

class AsyncValuesWidget2<T1, T2> extends StatelessWidget {
  final AsyncValue<T1> asyncValue1;
  final AsyncValue<T2> asyncValue2;
  final Widget Function(T1, T2, BuildContext) dataBuilder;
  final bool? showProgressIndicator;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValuesWidget2(
    this.asyncValue1,
    this.asyncValue2,
    this.dataBuilder, {
    this.showProgressIndicator,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return _AsyncValuesWidget(
      [asyncValue1, asyncValue2],
      (values, context) => dataBuilder(
        values[0],
        values[1],
        context,
      ),
      showProgressIndicator: showProgressIndicator,
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
  final bool? showProgressIndicator;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValuesWidget3(
    this.asyncValue1,
    this.asyncValue2,
    this.asyncValue3,
    this.dataBuilder, {
    this.showProgressIndicator,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return _AsyncValuesWidget(
      [asyncValue1, asyncValue2, asyncValue3],
      (values, context) => dataBuilder(
        values[0],
        values[1],
        values[2],
        context,
      ),
      showProgressIndicator: showProgressIndicator,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}

class _AsyncValuesWidget extends StatelessWidget {
  final List<AsyncValue> asyncValues;
  final Widget Function(List, BuildContext) dataBuilder;
  final bool? showProgressIndicator;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const _AsyncValuesWidget(
    this.asyncValues,
    this.dataBuilder, {
    this.showProgressIndicator,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context) {
    // Check if any of the AsyncValue objects are still loading
    if (asyncValues.any((av) => av.isLoading)) {
      return showProgressIndicator != false ? const AppProgressIndicator() : const SizedBox();
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
    if (values.any((v) => v == null)) {
      return showNoDataIndicator != false ? const Center(child: Text(Labels.noDataFound)) : const SizedBox();
    }

    return dataBuilder(values, context);
  }
}

class AsyncValueProviderWidget<T> extends ConsumerWidget {
  final ProviderListenable<AsyncValue<T>> provider;
  final Widget Function(T, BuildContext, WidgetRef) dataBuilder;
  final bool? showProgressIndicator;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValueProviderWidget(
    this.provider,
    this.dataBuilder, {
    this.showProgressIndicator,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider);
    return AsyncValueWidget<T>(
      asyncValue,
      (value, _) => dataBuilder(value, context, ref),
      showProgressIndicator: showProgressIndicator,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}

class AsyncValueProviderWidget2<T1, T2> extends ConsumerWidget {
  final ProviderListenable<AsyncValue<T1>> provider1;
  final ProviderListenable<AsyncValue<T2>> provider2;
  final Widget Function(T1, T2, BuildContext, WidgetRef) dataBuilder;
  final bool? showProgressIndicator;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValueProviderWidget2(
    this.provider1,
    this.provider2,
    this.dataBuilder, {
    this.showProgressIndicator,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _AsyncValuesProviderWidget(
      [provider1, provider2],
      (values, _, __) => dataBuilder(
        values[0],
        values[1],
        context,
        ref,
      ),
      showProgressIndicator: showProgressIndicator,
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
  final bool? showProgressIndicator;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const AsyncValueProviderWidget3(
    this.provider1,
    this.provider2,
    this.provider3,
    this.dataBuilder, {
    this.showProgressIndicator,
    this.showNoDataIndicator,
    this.showErrorIndicator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _AsyncValuesProviderWidget(
      [provider1, provider2, provider3],
      (values, _, __) => dataBuilder(
        values[0],
        values[1],
        values[2],
        context,
        ref,
      ),
      showProgressIndicator: showProgressIndicator,
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
  final bool showProgressIndicator;
  final bool showNoDataIndicator;
  final bool showErrorIndicator;

  const AsyncValueProviderWidget4(
    this.provider1,
    this.provider2,
    this.provider3,
    this.provider4,
    this.dataBuilder, {
    this.showProgressIndicator = true,
    this.showNoDataIndicator = true,
    this.showErrorIndicator = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _AsyncValuesProviderWidget(
      [provider1, provider2, provider3, provider4],
      (values, _, __) => dataBuilder(
        values[0],
        values[1],
        values[2],
        values[3],
        context,
        ref,
      ),
      showProgressIndicator: showProgressIndicator,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}

class _AsyncValuesProviderWidget extends ConsumerWidget {
  final List<ProviderListenable<AsyncValue>> providers;
  final Widget Function(List, BuildContext, WidgetRef) dataBuilder;
  final bool? showProgressIndicator;
  final bool? showNoDataIndicator;
  final bool? showErrorIndicator;

  const _AsyncValuesProviderWidget(
    this.providers,
    this.dataBuilder, {
    this.showProgressIndicator,
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
      asyncValues,
      (values, _) => dataBuilder(
        values,
        context,
        ref,
      ),
      showProgressIndicator: showProgressIndicator,
      showNoDataIndicator: showNoDataIndicator,
      showErrorIndicator: showErrorIndicator,
    );
  }
}
