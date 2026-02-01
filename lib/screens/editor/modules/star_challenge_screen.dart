import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/reference_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';

class StarChallengeModuleScreen extends StatefulWidget {
  const StarChallengeModuleScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;

  @override
  State<StarChallengeModuleScreen> createState() => _StarChallengeModuleScreenState();
}

class _StarChallengeModuleScreenState extends State<StarChallengeModuleScreen> {
  late StarChallengeModuleData _data;
  late PvzObject _moduleObj;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final info = RtidParser.parse(widget.rtid);
    if (info == null) return;
    
    _moduleObj = widget.levelFile.objects.firstWhere(
      (o) => o.aliases?.contains(info.alias) == true,
      orElse: () => PvzObject(objClass: 'StarChallengeModuleProperties', objData: {}),
    );

    try {
      _data = StarChallengeModuleData.fromJson(_moduleObj.objData);
    } catch (e) {
      _data = StarChallengeModuleData();
    }
    
    // Ensure at least one list exists (for 1st star)
    if (_data.challenges.isEmpty) {
      _data.challenges.add([]);
    }
  }

  void _saveData() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
  }

  void _removeChallenge(int index, String challengeRtid) {
    if (_data.challenges.isEmpty) return;
    
    setState(() {
      _data.challenges[0].removeAt(index);
      
      // Also remove the object if it's local
      final info = RtidParser.parse(challengeRtid);
      if (info != null && info.source == 'CurrentLevel') {
        widget.levelFile.objects.removeWhere((o) => o.aliases?.contains(info.alias) == true);
      }
      
      _saveData();
    });
  }

  void _editChallenge(String challengeRtid) {
    // TODO: Implement challenge specific editors
    final info = RtidParser.parse(challengeRtid);
    final alias = info?.alias ?? challengeRtid;
    final obj = widget.levelFile.objects.firstWhere(
      (o) => o.aliases?.contains(alias) == true,
      orElse: () => PvzObject(objClass: 'Unknown', objData: {}),
    );
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(obj.objClass),
        content: const Text('Challenge editor not yet implemented'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _addChallenge() {
    // TODO: Navigate to ChallengeSelectionScreen
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Challenge'),
        content: const Text('Challenge selection not yet implemented'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final challenges = _data.challenges.isNotEmpty ? _data.challenges[0] : <String>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Challenges'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (challenges.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: Text('No challenges configured')),
            )
          else
            ...challenges.asMap().entries.map((entry) {
              final index = entry.key;
              final rtid = entry.value;
              final info = RtidParser.parse(rtid);
              final alias = info?.alias ?? rtid;
              final isLocal = info?.source == 'CurrentLevel';
              
              String? objClass;
              if (isLocal) {
                objClass = widget.levelFile.objects
                    .where((o) => o.aliases?.contains(alias) == true)
                    .firstOrNull
                    ?.objClass;
              } else {
                objClass = ReferenceRepository.instance.getObjClass(alias);
              }

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.star_border),
                  title: Text(objClass ?? 'Unknown Challenge'),
                  subtitle: Text(alias),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLocal)
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editChallenge(rtid),
                        ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeChallenge(index, rtid),
                      ),
                    ],
                  ),
                ),
              );
            }),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _addChallenge,
            icon: const Icon(Icons.add),
            label: const Text('Add Challenge'),
          ),
        ],
      ),
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull {
    final it = iterator;
    return it.moveNext() ? it.current : null;
  }
}
