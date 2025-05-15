import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../resources/labels.dart';
import '../progress_indicator/progress_indicator.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T, BuildContext) dataBuilder;

  const AsyncValueWidget(
    this.asyncValue,
    this.dataBuilder,
  );

  @override
  Widget build(BuildContext context) {
    return _AsyncValuesWidget(
      [asyncValue],
      (values, context) => dataBuilder(values[0], context),
    );
  }
}

class AsyncValuesWidget2<T1, T2> extends StatelessWidget {
  final AsyncValue<T1> asyncValue1;
  final AsyncValue<T2> asyncValue2;
  final Widget Function(T1, T2, BuildContext) dataBuilder;

  const AsyncValuesWidget2(
    this.asyncValue1,
    this.asyncValue2,
    this.dataBuilder,
  );

  @override
  Widget build(BuildContext context) {
    return _AsyncValuesWidget(
      [asyncValue1, asyncValue2],
      (values, context) => dataBuilder(
        values[0],
        values[1],
        context,
      ),
    );
  }
}

class AsyncValuesWidget3<T1, T2, T3> extends StatelessWidget {
  final AsyncValue<T1> asyncValue1;
  final AsyncValue<T2> asyncValue2;
  final AsyncValue<T3> asyncValue3;
  final Widget Function(T1, T2, T3, BuildContext) dataBuilder;

  const AsyncValuesWidget3(
    this.asyncValue1,
    this.asyncValue2,
    this.asyncValue3,
    this.dataBuilder,
  );

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
    );
  }
}

class _AsyncValuesWidget extends StatelessWidget {
  final List<AsyncValue> asyncValues;
  final Widget Function(List, BuildContext) dataBuilder;

  const _AsyncValuesWidget(
    this.asyncValues,
    this.dataBuilder,
  );

  @override
  Widget build(BuildContext context) {
    // Check if any of the AsyncValue objects are still loading
    if (asyncValues.any((av) => av.isLoading)) {
      return const AppProgressIndicator();
    }

    final errorIndex = asyncValues.indexWhere((av) => av.hasError);
    if (errorIndex != -1) {
      return Center(child: Text(asyncValues[errorIndex].error.toString()));
    }

    final values = asyncValues.map((av) => av.value).toList();
    if (values.any((v) => v == null)) {
      return const Center(child: Text(Labels.noDataFound));
    }

    return dataBuilder(values, context);
  }
}

class AsyncValueProviderWidget<T> extends ConsumerWidget {
  final ProviderListenable<AsyncValue<T>> provider;
  final Widget Function(T, BuildContext, WidgetRef) dataBuilder;

  const AsyncValueProviderWidget(this.provider, this.dataBuilder);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider);
    return AsyncValueWidget<T>(
      asyncValue,
      (value, _) => dataBuilder(value, context, ref),
    );
  }
}

class AsyncValueProviderWidget2<T1, T2> extends ConsumerWidget {
  final ProviderListenable<AsyncValue<T1>> provider1;
  final ProviderListenable<AsyncValue<T2>> provider2;
  final Widget Function(T1, T2, BuildContext, WidgetRef) dataBuilder;

  const AsyncValueProviderWidget2(
    this.provider1,
    this.provider2,
    this.dataBuilder,
  );

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
    );
  }
}

class _AsyncValuesProviderWidget extends ConsumerWidget {
  final List<ProviderListenable<AsyncValue>> providers;
  final Widget Function(List, BuildContext, WidgetRef) dataBuilder;

  const _AsyncValuesProviderWidget(this.providers, this.dataBuilder);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValues = providers
        .map(
          (provider) => ref.watch(provider),
        )
        .toList();

    return _AsyncValuesWidget(
      asyncValues,
      (values, _) => dataBuilder(values, context, ref),
    );
  }
}
