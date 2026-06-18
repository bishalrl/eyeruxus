import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/features/host_money/presentation/bloc/host_money_feature_cubits.dart';
import 'package:eye_rex_us/features/host_money/presentation/theme/host_money_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddHostPage extends StatelessWidget {
  const AddHostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AddHostCubit>(),
      child: const _AddHostView(),
    );
  }
}

class _AddHostView extends StatefulWidget {
  const _AddHostView();

  @override
  State<_AddHostView> createState() => _AddHostViewState();
}

class _AddHostViewState extends State<_AddHostView> {
  final _idsController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _idsController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8A4E8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => AppRouter.pop(context),
        ),
        title: const Text('Invite more hosts', style: TextStyle(color: Colors.black)),
      ),
      body: BlocConsumer<AddHostCubit, InviteFormState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Icon(Icons.people, size: 80, color: Colors.white),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: HostMoneyTheme.cardDecoration.copyWith(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Invite friends to join my agency',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _idsController,
                        decoration: const InputDecoration(
                          labelText: 'Host ID(s)',
                          hintText: 'Enter IDs separated by comma',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _messageController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Invitation message (optional)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      if (state.error != null) ...[
                        const SizedBox(height: 8),
                        Text(state.error!, style: const TextStyle(color: Colors.red)),
                      ],
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: state.isSubmitting
                            ? null
                            : () => context.read<AddHostCubit>().submit(
                                  hostIdsText: _idsController.text,
                                  message: _messageController.text,
                                ),
                        child: state.isSubmitting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Send invitation'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class InviteAgentPage extends StatelessWidget {
  const InviteAgentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<InviteAgentCubit>(),
      child: const _InviteAgentView(),
    );
  }
}

class _InviteAgentView extends StatefulWidget {
  const _InviteAgentView();

  @override
  State<_InviteAgentView> createState() => _InviteAgentViewState();
}

class _InviteAgentViewState extends State<_InviteAgentView> {
  final _idController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HostMoneyTheme.background,
      appBar: AppBar(
        backgroundColor: HostMoneyTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => AppRouter.pop(context),
        ),
        title: const Text('Invite Agent', style: TextStyle(color: Colors.black)),
      ),
      body: BlocConsumer<InviteAgentCubit, InviteFormState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: HostMoneyTheme.cardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Invite a sub-agent to your agency'),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _idController,
                    decoration: const InputDecoration(
                      labelText: 'Agent ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _messageController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (state.error != null) ...[
                    const SizedBox(height: 8),
                    Text(state.error!, style: const TextStyle(color: Colors.red)),
                  ],
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: state.isSubmitting
                        ? null
                        : () => context.read<InviteAgentCubit>().submit(
                              agentId: _idController.text,
                              message: _messageController.text,
                            ),
                    child: state.isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Send invite'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
