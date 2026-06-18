import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/wallet/domain/entities/wallet_operations_entities.dart';
import 'package:eye_rex_us/features/wallet/domain/usecases/wallet_operations_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ── Points shop ──────────────────────────────────────────────────────────────

class PointsShopState extends Equatable {
  const PointsShopState({
    this.isLoading = false,
    this.products = const [],
    this.message,
    this.error,
  });

  final bool isLoading;
  final List<PointProduct> products;
  final String? message;
  final String? error;

  @override
  List<Object?> get props => [isLoading, products, message, error];
}

class PointsShopCubit extends Cubit<PointsShopState> {
  PointsShopCubit(this._useCases) : super(const PointsShopState());

  final WalletOperationsUseCases _useCases;

  Future<void> load() async {
    emit(const PointsShopState(isLoading: true));
    try {
      final products = await _useCases.getPointProducts();
      emit(PointsShopState(products: products));
    } catch (e) {
      emit(PointsShopState(error: e.toString()));
    }
  }

  Future<void> purchase(String productId, int currentPoints) async {
    emit(PointsShopState(products: state.products, isLoading: true));
    final result = await _useCases.purchaseWithPoints(
      productId: productId,
      currentPoints: currentPoints,
    );
    emit(PointsShopState(
      products: state.products,
      message: result.success ? result.message : null,
      error: result.success ? null : result.message,
    ));
  }
}

// ── Exchange coins ───────────────────────────────────────────────────────────

enum ExchangeCoinsSelection { pack100k, pack500k, customize }

class ExchangeCoinsState extends Equatable {
  const ExchangeCoinsState({
    this.selection = ExchangeCoinsSelection.customize,
    this.customMultiplier = 0,
    this.verificationCode = '',
    this.verificationInput = '',
    this.isSubmitting = false,
    this.message,
    this.error,
  });

  static const pack100kPoints = 100000;
  static const pack100kCoins = 92000;
  static const pack500kPoints = 500000;
  static const pack500kCoins = 475000;
  static const customUnitPoints = 100000;

  final ExchangeCoinsSelection selection;
  final int customMultiplier;
  final String verificationCode;
  final String verificationInput;
  final bool isSubmitting;
  final String? message;
  final String? error;

  int get pointsToSpend => switch (selection) {
        ExchangeCoinsSelection.pack100k => pack100kPoints,
        ExchangeCoinsSelection.pack500k => pack500kPoints,
        ExchangeCoinsSelection.customize => customMultiplier * customUnitPoints,
      };

  int get coinsToReceive => switch (selection) {
        ExchangeCoinsSelection.pack100k => pack100kCoins,
        ExchangeCoinsSelection.pack500k => pack500kCoins,
        ExchangeCoinsSelection.customize =>
          (customMultiplier * customUnitPoints * 0.92).round(),
      };

  ExchangeCoinsState copyWith({
    ExchangeCoinsSelection? selection,
    int? customMultiplier,
    String? verificationCode,
    String? verificationInput,
    bool? isSubmitting,
    String? Function()? message,
    String? Function()? error,
  }) {
    return ExchangeCoinsState(
      selection: selection ?? this.selection,
      customMultiplier: customMultiplier ?? this.customMultiplier,
      verificationCode: verificationCode ?? this.verificationCode,
      verificationInput: verificationInput ?? this.verificationInput,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      message: message != null ? message() : this.message,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [
        selection,
        customMultiplier,
        verificationCode,
        verificationInput,
        isSubmitting,
        message,
        error,
      ];
}

class ExchangeCoinsCubit extends Cubit<ExchangeCoinsState> {
  ExchangeCoinsCubit(this._useCases)
      : super(ExchangeCoinsState(verificationCode: _newCode()));

  final WalletOperationsUseCases _useCases;

  static String _newCode() {
    final n = DateTime.now().millisecondsSinceEpoch % 10000;
    return n.toString().padLeft(4, '0');
  }

  void selectPack(ExchangeCoinsSelection selection) {
    emit(state.copyWith(selection: selection, error: () => null));
  }

  void setCustomMultiplier(int value) {
    emit(state.copyWith(
      selection: ExchangeCoinsSelection.customize,
      customMultiplier: value < 0 ? 0 : value,
      error: () => null,
    ));
  }

  void setVerificationInput(String value) {
    emit(state.copyWith(verificationInput: value, error: () => null));
  }

  void refreshVerificationCode() {
    emit(state.copyWith(verificationCode: _newCode()));
  }

  Future<void> submit(int currentPoints) async {
    emit(state.copyWith(isSubmitting: true, error: () => null, message: () => null));
    final result = await _useCases.exchangePointsForCoins(
      pointsToSpend: state.pointsToSpend,
      currentPoints: currentPoints,
      verificationCode: state.verificationCode,
      verificationInput: state.verificationInput,
    );
    emit(state.copyWith(
      isSubmitting: false,
      message: () => result.success ? result.message : null,
      error: () => result.success ? null : result.message,
      verificationInput: result.success ? '' : state.verificationInput,
      verificationCode: result.success ? _newCode() : state.verificationCode,
    ));
  }
}

// ── Transfer ─────────────────────────────────────────────────────────────────

class TransferCoinsState extends Equatable {
  const TransferCoinsState({this.isSubmitting = false, this.message, this.error});

  final bool isSubmitting;
  final String? message;
  final String? error;

  @override
  List<Object?> get props => [isSubmitting, message, error];
}

class TransferCoinsCubit extends Cubit<TransferCoinsState> {
  TransferCoinsCubit(this._useCases) : super(const TransferCoinsState());

  final WalletOperationsUseCases _useCases;

  Future<void> transfer({
    required String recipientId,
    required int amount,
    required int currentCoins,
  }) async {
    emit(const TransferCoinsState(isSubmitting: true));
    final result = await _useCases.transferCoins(
      recipientId: recipientId,
      amount: amount,
      currentCoins: currentCoins,
    );
    emit(TransferCoinsState(
      message: result.success ? result.message : null,
      error: result.success ? null : result.message,
    ));
  }
}

// ── Bank details ─────────────────────────────────────────────────────────────

class BankDetailsState extends Equatable {
  const BankDetailsState({
    this.isLoading = false,
    this.isSaving = false,
    this.details = const BankAccountDetails(),
    this.message,
    this.error,
  });

  final bool isLoading;
  final bool isSaving;
  final BankAccountDetails details;
  final String? message;
  final String? error;

  @override
  List<Object?> get props => [isLoading, isSaving, details, message, error];
}

class BankDetailsCubit extends Cubit<BankDetailsState> {
  BankDetailsCubit(this._useCases) : super(const BankDetailsState());

  final WalletOperationsUseCases _useCases;

  Future<void> load() async {
    emit(const BankDetailsState(isLoading: true));
    final details = await _useCases.getBankDetails();
    emit(BankDetailsState(details: details));
  }

  Future<void> save(BankAccountDetails details) async {
    emit(BankDetailsState(details: state.details, isSaving: true));
    final result = await _useCases.saveBankDetails(details);
    if (result.success) {
      final saved = await _useCases.getBankDetails();
      emit(BankDetailsState(details: saved, message: result.message));
    } else {
      emit(BankDetailsState(details: state.details, error: result.message));
    }
  }
}

// ── Payment methods ──────────────────────────────────────────────────────────

class PaymentMethodsState extends Equatable {
  const PaymentMethodsState({
    this.isLoading = false,
    this.methods = const [],
    this.message,
    this.error,
  });

  final bool isLoading;
  final List<PaymentMethod> methods;
  final String? message;
  final String? error;

  @override
  List<Object?> get props => [isLoading, methods, message, error];
}

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit(this._useCases) : super(const PaymentMethodsState());

  final WalletOperationsUseCases _useCases;

  Future<void> load() async {
    emit(const PaymentMethodsState(isLoading: true));
    final methods = await _useCases.getPaymentMethods();
    emit(PaymentMethodsState(methods: methods));
  }

  Future<void> add(PaymentMethodType type, String label) async {
    final result = await _useCases.addPaymentMethod(type, label);
    await load();
    emit(PaymentMethodsState(
      methods: state.methods,
      message: result.success ? result.message : null,
      error: result.success ? null : result.message,
    ));
  }

  Future<void> setDefault(String id) async {
    await _useCases.setDefaultPaymentMethod(id);
    await load();
  }

  Future<void> remove(String id) async {
    await _useCases.removePaymentMethod(id);
    await load();
  }
}

// ── Invite ───────────────────────────────────────────────────────────────────

class InviteState extends Equatable {
  const InviteState({
    this.isLoading = false,
    this.profile,
    this.isSubmitting = false,
    this.message,
    this.error,
  });

  final bool isLoading;
  final InviteProfile? profile;
  final bool isSubmitting;
  final String? message;
  final String? error;

  @override
  List<Object?> get props => [isLoading, profile, isSubmitting, message, error];
}

class InviteCubit extends Cubit<InviteState> {
  InviteCubit(this._useCases) : super(const InviteState());

  final WalletOperationsUseCases _useCases;

  Future<void> load() async {
    emit(const InviteState(isLoading: true));
    final profile = await _useCases.getInviteProfile();
    emit(InviteState(profile: profile));
  }

  Future<void> sendInvite(String friendId) async {
    emit(InviteState(profile: state.profile, isSubmitting: true));
    final result = await _useCases.sendIdInvite(friendId);
    emit(InviteState(
      profile: state.profile,
      message: result.success ? result.message : null,
      error: result.success ? null : result.message,
    ));
  }
}

// ── Friends ──────────────────────────────────────────────────────────────────

class FriendsState extends Equatable {
  const FriendsState({
    this.tab = FriendsTab.friends,
    this.isLoading = false,
    this.friends = const [],
  });

  final FriendsTab tab;
  final bool isLoading;
  final List<InviteFriend> friends;

  @override
  List<Object?> get props => [tab, isLoading, friends];
}

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit(this._useCases) : super(const FriendsState());

  final WalletOperationsUseCases _useCases;

  Future<void> load({FriendsTab? tab}) async {
    final t = tab ?? state.tab;
    emit(FriendsState(tab: t, isLoading: true));
    final friends = await _useCases.getFriends(t);
    emit(FriendsState(tab: t, friends: friends));
  }
}

// ── My Agency ────────────────────────────────────────────────────────────────

class MyAgencyState extends Equatable {
  const MyAgencyState({
    this.isLoading = false,
    this.dashboard,
    this.isSelecting = false,
    this.message,
    this.error,
  });

  final bool isLoading;
  final AgencyDashboard? dashboard;
  final bool isSelecting;
  final String? message;
  final String? error;

  @override
  List<Object?> get props => [isLoading, dashboard, isSelecting, message, error];
}

class MyAgencyCubit extends Cubit<MyAgencyState> {
  MyAgencyCubit(this._useCases) : super(const MyAgencyState());

  final WalletOperationsUseCases _useCases;

  Future<void> load() async {
    emit(const MyAgencyState(isLoading: true));
    final dashboard = await _useCases.getAgencyDashboard();
    emit(MyAgencyState(dashboard: dashboard));
  }

  Future<void> selectMethod(int methodId) async {
    emit(MyAgencyState(dashboard: state.dashboard, isSelecting: true));
    final result = await _useCases.selectAgencyMethod(methodId);
    final dashboard = await _useCases.getAgencyDashboard();
    emit(MyAgencyState(
      dashboard: dashboard,
      message: result.message,
    ));
  }
}
