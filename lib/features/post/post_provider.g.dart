// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostProvider)
const postProviderProvider = PostProviderProvider._();

final class PostProviderProvider
    extends $NotifierProvider<PostProvider, PostProviderState> {
  const PostProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postProviderHash();

  @$internal
  @override
  PostProvider create() => PostProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostProviderState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostProviderState>(value),
    );
  }
}

String _$postProviderHash() => r'1d2657440988c80c875f2dce6c26d1c14145ee20';

abstract class _$PostProvider extends $Notifier<PostProviderState> {
  PostProviderState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PostProviderState, PostProviderState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostProviderState, PostProviderState>,
              PostProviderState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
