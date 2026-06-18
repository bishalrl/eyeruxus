import 'package:equatable/equatable.dart';

enum PaymentMethodType { bankTransfer, upi, paypal }

class PointProduct extends Equatable {
  const PointProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.pointsCost,
    required this.iconEmoji,
  });

  final String id;
  final String name;
  final String description;
  final int pointsCost;
  final String iconEmoji;

  @override
  List<Object?> get props => [id];
}

class PaymentMethod extends Equatable {
  const PaymentMethod({
    required this.id,
    required this.label,
    required this.subtitle,
    required this.type,
    required this.isDefault,
  });

  final String id;
  final String label;
  final String subtitle;
  final PaymentMethodType type;
  final bool isDefault;

  @override
  List<Object?> get props => [id, isDefault];
}

class BankAccountDetails extends Equatable {
  const BankAccountDetails({
    this.accountHolder,
    this.accountNumber,
    this.ifscCode,
    this.bankName,
    this.isConnected = false,
  });

  final String? accountHolder;
  final String? accountNumber;
  final String? ifscCode;
  final String? bankName;
  final bool isConnected;

  BankAccountDetails copyWith({
    String? accountHolder,
    String? accountNumber,
    String? ifscCode,
    String? bankName,
    bool? isConnected,
  }) {
    return BankAccountDetails(
      accountHolder: accountHolder ?? this.accountHolder,
      accountNumber: accountNumber ?? this.accountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      bankName: bankName ?? this.bankName,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object?> get props => [accountNumber, isConnected];
}

class WalletActionResult extends Equatable {
  const WalletActionResult({required this.success, required this.message});

  final bool success;
  final String message;

  @override
  List<Object?> get props => [success, message];
}

class InviteFriend extends Equatable {
  const InviteFriend({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.isOnline,
    this.mutualFriends = 0,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;
  final int mutualFriends;

  @override
  List<Object?> get props => [id];
}

class InviteProfile extends Equatable {
  const InviteProfile({
    required this.inviteCode,
    required this.inviteLink,
    required this.rewardPerInvite,
    required this.totalInvited,
    required this.totalEarned,
  });

  final String inviteCode;
  final String inviteLink;
  final int rewardPerInvite;
  final int totalInvited;
  final int totalEarned;

  @override
  List<Object?> get props => [inviteCode, totalInvited];
}

enum FriendsTab { friends, following, followers, visitors }

class AgencyMethod extends Equatable {
  const AgencyMethod({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.steps,
    required this.highlight,
  });

  final int id;
  final String title;
  final String subtitle;
  final List<String> steps;
  final bool highlight;

  @override
  List<Object?> get props => [id];
}

class AgencyDashboard extends Equatable {
  const AgencyDashboard({
    required this.agencyName,
    required this.hostCount,
    required this.agentCount,
    required this.monthlyEarnings,
    required this.methods,
  });

  final String agencyName;
  final int hostCount;
  final int agentCount;
  final int monthlyEarnings;
  final List<AgencyMethod> methods;

  @override
  List<Object?> get props => [agencyName, hostCount];
}
