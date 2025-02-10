import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/adoption/adoption_history_bloc.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = context.watch<AdoptionHistoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmClearHistory(context),
          ),
        ],
      ),
      body: historyProvider.history.isEmpty
          ? Center(
        child: Text(
          'No adoption history yet!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      )
          : ListView.builder(
        itemCount: historyProvider.history.length,
        itemBuilder: (context, index) {
          final entry = historyProvider.history[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Theme.of(context).cardTheme.color,
            child: ListTile(
              leading: Hero(
                tag: 'history-${entry.petId}',
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(entry.imageUrl),
                ),
              ),
              title: Text(
                entry.petName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                entry.formattedDate,
                style: Theme.of(context).textTheme.titleMedium,
              ),

            ),
          );
        },
      ),
    );
  }

  void _confirmClearHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Clear History?',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'This will permanently delete all adoption history.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<AdoptionHistoryProvider>().clearHistory();
              Navigator.pop(context);
            },
            child: Text(
              'Clear',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}