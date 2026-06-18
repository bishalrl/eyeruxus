import 'package:eye_rex_us/core/constants/dev_session.dart';
import 'package:eye_rex_us/features/chat_room/presentation/bloc/chat_room_bloc.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_bloc.dart';
import 'package:eye_rex_us/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:eye_rex_us/features/store/presentation/bloc/store_bloc.dart';
import 'package:eye_rex_us/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:eye_rex_us/shared/widgets/feature_state_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Loads a chat room config via [ChatRoomBloc], then renders [child].
///
/// Expects a route-scoped [ChatRoomBloc] from [LiveSessionScope].
class ChatRoomBoundPage extends StatefulWidget {
  const ChatRoomBoundPage({
    super.key,
    required this.roomId,
    required this.child,
  });

  final String roomId;
  final Widget child;

  @override
  State<ChatRoomBoundPage> createState() => _ChatRoomBoundPageState();
}

class _ChatRoomBoundPageState extends State<ChatRoomBoundPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChatRoomBloc>().add(ChatRoomLoadRequested(widget.roomId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(
      builder: (context, state) {
        if (state is ChatRoomFailure) {
          return FeatureErrorView(message: state.message);
        }
        final ready =
            state is ChatRoomLoaded && state.config.id == widget.roomId;
        if (!ready) {
          return const FeatureLoadingView();
        }
        return widget.child;
      },
    );
  }
}

/// Loads store catalog for [category] via [StoreBloc], then renders [child].
class StoreBoundPage extends StatefulWidget {
  const StoreBoundPage({
    super.key,
    this.category,
    required this.child,
  });

  final String? category;
  final Widget child;

  @override
  State<StoreBoundPage> createState() => _StoreBoundPageState();
}

class _StoreBoundPageState extends State<StoreBoundPage> {
  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(StoreProductsRequested(category: widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state is StoreLoading || state is StoreInitial) {
          return const FeatureLoadingView();
        }
        if (state is StoreFailure) {
          return FeatureErrorView(message: state.message);
        }
        return widget.child;
      },
    );
  }
}

/// Loads app settings via [SettingsBloc], then renders [child].
class SettingsBoundPage extends StatefulWidget {
  const SettingsBoundPage({super.key, required this.child});

  final Widget child;

  @override
  State<SettingsBoundPage> createState() => _SettingsBoundPageState();
}

class _SettingsBoundPageState extends State<SettingsBoundPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(const SettingsLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading || state is SettingsInitial) {
          return const FeatureLoadingView();
        }
        if (state is SettingsFailure) {
          return FeatureErrorView(message: state.message);
        }
        return widget.child;
      },
    );
  }
}

/// Loads wallet balance via [WalletBloc], then renders [child].
class WalletBoundPage extends StatefulWidget {
  const WalletBoundPage({super.key, required this.child});

  final Widget child;

  @override
  State<WalletBoundPage> createState() => _WalletBoundPageState();
}

class _WalletBoundPageState extends State<WalletBoundPage> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(
          const WalletBalanceRequested(
            userId: DevSession.userId,
            accessToken: DevSession.accessToken,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is WalletLoading || state is WalletInitial) {
          return const FeatureLoadingView();
        }
        if (state is WalletFailure) {
          return FeatureErrorView(message: state.message);
        }
        return widget.child;
      },
    );
  }
}

/// Loads live rooms via [LiveBloc], then renders [child].
///
/// Expects a route-scoped [LiveBloc] from [LiveSessionScope].
class LiveBoundPage extends StatefulWidget {
  const LiveBoundPage({
    super.key,
    required this.scopeKey,
    this.sessionType,
    required this.child,
  });

  final String scopeKey;
  final String? sessionType;
  final Widget child;

  @override
  State<LiveBoundPage> createState() => _LiveBoundPageState();
}

class _LiveBoundPageState extends State<LiveBoundPage> {
  @override
  void initState() {
    super.initState();
    context.read<LiveBloc>().add(
          LiveRoomsRequested(
            accessToken: DevSession.accessToken,
            sessionType: widget.sessionType,
            scopeKey: widget.scopeKey,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveBloc, LiveState>(
      builder: (context, state) {
        if (state is LiveFailure) {
          return FeatureErrorView(message: state.message);
        }
        final ready =
            state is LiveLoaded && state.scopeKey == widget.scopeKey;
        if (!ready) {
          return const FeatureLoadingView();
        }
        return widget.child;
      },
    );
  }
}
