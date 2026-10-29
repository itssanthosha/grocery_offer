import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../data/auth_repository.dart';
import 'auth_ui.dart';

const _dialCode = '+968';
const _phoneLength = 8; // Omani mobile numbers

class PhoneSignInScreen extends ConsumerStatefulWidget {
  const PhoneSignInScreen({super.key, this.from});
  final String? from;

  @override
  ConsumerState<PhoneSignInScreen> createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends ConsumerState<PhoneSignInScreen> {
  final _phone = TextEditingController();
  final _code = TextEditingController();
  String? _verificationId;
  bool _busy = false;

  @override
  void dispose() {
    _phone.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
    } catch (e) {
      if (mounted) showAuthError(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _sendCode() => _run(() async {
    final id = await ref
        .read(authRepositoryProvider)
        .sendSmsCode('$_dialCode${_phone.text}');
    // null = auto-verified on Android; the router takes us to /home.
    if (mounted) setState(() => _verificationId = id);
  });

  Future<void> _verify() => _run(() async {
    await ref
        .read(authRepositoryProvider)
        .confirmSmsCode(_verificationId!, _code.text);
    if (mounted) context.go(widget.from ?? '/home');
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final awaitingCode = _verificationId != null;

    return Scaffold(
      appBar: AppBar(title: Text(l.phoneSignInTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (!awaitingCode) ...[
              TextField(
                controller: _phone,
                enabled: !_busy,
                autofocus: true,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(_phoneLength),
                ],
                decoration: InputDecoration(
                  labelText: l.phoneNumber,
                  hintText: l.phoneNumberHint,
                  prefixText: '$_dialCode ',
                ),
              ),
              const SizedBox(height: 24),
              ValueListenableBuilder(
                valueListenable: _phone,
                builder: (_, value, _) => FilledButton(
                  onPressed: _busy || value.text.length != _phoneLength
                      ? null
                      : _sendCode,
                  child: Text(l.sendCode),
                ),
              ),
            ] else ...[
              Text(l.enterCodeTitle, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                l.enterCodeBody('$_dialCode ${_phone.text}'),
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _code,
                enabled: !_busy,
                autofocus: true,
                keyboardType: TextInputType.number,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                decoration: InputDecoration(labelText: l.verificationCode),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _busy || _code.text.length != 6 ? null : _verify,
                child: Text(l.verify),
              ),
              TextButton(
                onPressed: _busy
                    ? null
                    : () => setState(() {
                        _verificationId = null;
                        _code.clear();
                      }),
                child: Text(l.changeNumber),
              ),
            ],
            if (_busy) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}
