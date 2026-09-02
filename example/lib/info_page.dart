import 'package:flutter/material.dart';

import 'widgets/copyable_row.dart';

/// bKash sandbox test wallet credentials, shared by bKash for exercising the
/// Checkout WebView (these are separate from the app_key/app_secret used to
/// call the API itself). Sandbox only — never valid in production.
const _activeWallets = [
  '01770618575',
  '01929918378',
  '01770618576',
  '01877722345',
  '01619777282',
  '01619777283',
];
const _insufficientBalanceNumber = '01823074817';
const _debitBlockNumber = '01823074818';
const _pin = '12121';
const _otp = '123456';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sandbox Info')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'These wallet numbers, OTP and PIN only work in the bKash '
                'sandbox environment — enter them on the bKash checkout '
                'WebView screen, not in this demo\'s own form.',
              ),
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'Regular Active Customer Wallets',
            children: [
              for (var i = 0; i < _activeWallets.length; i++)
                CopyableRow(label: 'Wallet ${i + 1}', value: _activeWallets[i]),
            ],
          ),
          const _Section(
            title: 'Wallets for Failed Cases',
            children: [
              CopyableRow(
                label: 'Insufficient Balance',
                value: _insufficientBalanceNumber,
              ),
              CopyableRow(
                label: 'Debit Block',
                value: _debitBlockNumber,
              ),
            ],
          ),
          const _Section(
            title: 'PIN & OTP (all wallets above)',
            children: [
              CopyableRow(label: 'PIN', value: _pin),
              CopyableRow(label: 'OTP', value: _otp),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
