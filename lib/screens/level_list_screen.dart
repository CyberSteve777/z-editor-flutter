import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_editor/data/level_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';

class LevelListScreen extends StatefulWidget {
  const LevelListScreen({
    super.key,
    required this.isDarkTheme,
    required this.onToggleTheme,
    required this.uiScale,
    required this.onUiScaleChange,
    required this.onLevelClick,
    required this.onAboutClick,
    required this.onLanguageTap,
  });

  final bool isDarkTheme;
  final VoidCallback onToggleTheme;
  final double uiScale;
  final ValueChanged<double> onUiScaleChange;
  final void Function(String fileName, String filePath) onLevelClick;
  final VoidCallback onAboutClick;
  final ValueChanged<BuildContext> onLanguageTap;

  @override
  State<LevelListScreen> createState() => _LevelListScreenState();
}

class _LevelListScreenState extends State<LevelListScreen> {
  List<FileItem> _fileItems = [];
  bool _isLoading = false;
  List<({String name, String path})> _pathStack = [];
  String? _rootFolderPath;
  FileItem? _itemToDelete;
  FileItem? _itemToRename;
  FileItem? _itemToCopy;
  bool _confirmCheckbox = false;
  String _renameInput = '';
  String _copyInput = '';
  bool _showNewFolderDialog = false;
  String _newFolderNameInput = '';
  bool _showTemplateDialog = false;
  bool _showCreateNameDialog = false;
  List<String> _templates = [];
  String _selectedTemplate = '';
  String _newLevelNameInput = '';
  bool _showUiScaleDialog = false;
  bool _showMenu = false;

  @override
  void initState() {
    super.initState();
    _loadSavedPathAndList();
  }

  Future<void> _loadSavedPathAndList() async {
    final path = await LevelRepository.getSavedFolderPath();
    if (path != null && mounted) {
      setState(() {
        _rootFolderPath = path;
        if (_pathStack.isEmpty) {
          final name = path.split(RegExp(r'[/\\]')).last;
          _pathStack = [(name: name.isEmpty ? 'Root' : name, path: path)];
        }
      });
      _loadCurrentDirectory();
    }
  }

  Future<void> _pickFolder() async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null && mounted) {
      await LevelRepository.setSavedFolderPath(result);
      setState(() {
        _rootFolderPath = result;
        final name = result.split(RegExp(r'[/\\]')).last;
        _pathStack = [(name: name.isEmpty ? 'Root' : name, path: result)];
      });
      _loadCurrentDirectory();
    }
  }

  Future<void> _loadCurrentDirectory() async {
    final currentPath = _pathStack.isNotEmpty ? _pathStack.last.path : _rootFolderPath;
    if (currentPath == null) return;
    setState(() => _isLoading = true);
    final items = await LevelRepository.getDirectoryContents(currentPath);
    if (mounted) setState(() {
      _fileItems = items;
      _isLoading = false;
    });
  }

  void _navigateToFolder(FileItem folder) {
    setState(() => _pathStack = [..._pathStack, (name: folder.name, path: folder.path)]);
    _loadCurrentDirectory();
  }

  void _breadcrumbTap(int index) {
    setState(() => _pathStack = _pathStack.take(index + 1).toList());
    _loadCurrentDirectory();
  }

  Future<void> _handleRenameConfirm() async {
    final target = _itemToRename;
    if (target == null || _pathStack.isEmpty) return;
    var finalName = _renameInput.trim();
    if (!target.isDirectory && !finalName.toLowerCase().endsWith('.json')) finalName += '.json';
    final ok = await LevelRepository.renameItem(
      _pathStack.last.path, target.name, finalName, target.isDirectory,
    );
    if (mounted) {
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.renameSuccess)),
        );
        setState(() => _itemToRename = null);
        _loadCurrentDirectory();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.renameFail)),
        );
      }
    }
  }


  Future<void> _handleCopyConfirm() async {
    final target = _itemToCopy;
    if (target == null || _pathStack.isEmpty) return;
    var finalName = _copyInput.trim();
    if (!finalName.toLowerCase().endsWith('.json')) finalName += '.json';
    final ok = await LevelRepository.copyLevelToTarget(
      target.path, _pathStack.last.path, finalName,
    );
    if (mounted) {
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.copySuccess)),
        );
        setState(() => _itemToCopy = null);
        _loadCurrentDirectory();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.copyFail)),
        );
      }
    }
  }

  Future<void> _handleNewFolder() async {
    if (_newFolderNameInput.trim().isEmpty || _pathStack.isEmpty) return;
    final ok = await LevelRepository.createDirectory(_pathStack.last.path, _newFolderNameInput.trim());
    if (mounted) {
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.folderCreated)),
        );
        setState(() {
          _showNewFolderDialog = false;
          _newFolderNameInput = '';
        });
        _loadCurrentDirectory();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.createFail)),
        );
      }
    }
  }

  void _openTemplateSelector() async {
    List<String> list;
    try {
      final manifest = await rootBundle.loadString('assets/template/manifest.json');
      list = LevelRepository.parseTemplateManifest(manifest);
    } catch (_) {
      list = [];
    }
    if (list.isEmpty) list = await LevelRepository.getTemplateList();
    if (!mounted) return;
    if (list.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)?.noTemplates ?? 'No templates found')),
      );
    } else {
      _templates = list;
      _showTemplateListDialog();
    }
  }

  static String _templateDisplayName(String filename, AppLocalizations? l10n) {
    if (l10n == null) return filename.replaceFirst(RegExp(r'\.json$'), '');
    switch (filename) {
      case '1_blank_level.json': return l10n.templateBlankLevel;
      case '2_card_pick_example.json': return l10n.templateCardPickExample;
      case '3_conveyor_example.json': return l10n.templateConveyorExample;
      case '4_last_stand_example.json': return l10n.templateLastStandExample;
      case '5_i_zombie_example.json': return l10n.templateIZombieExample;
      case '6_vase_breaker_example.json': return l10n.templateVaseBreakerExample;
      case '7_zomboss_example.json': return l10n.templateZombossExample;
      case '8_custom_zombie_example.json': return l10n.templateCustomZombieExample;
      case '9_i_plant_example.json': return l10n.templateIPlantExample;
      default: return filename.replaceFirst(RegExp(r'\.json$'), '');
    }
  }

  void _showTemplateListDialog() {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.newLevelTemplate ?? 'New level - Select template'),
        content: SizedBox(
          width: double.maxFinite,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 320),
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: _templates.length,
              itemBuilder: (_, i) {
                final t = _templates[i];
                return ListTile(
                  leading: const Icon(Icons.description, color: Colors.grey),
                  title: Text(_templateDisplayName(t, l10n)),
                  onTap: () {
                    Navigator.pop(ctx);
                    _selectedTemplate = t;
                    _newLevelNameInput = t.replaceFirst(RegExp(r'\.json$'), '');
                    _methodShowCreateNameDialog();
                  },
                );
              },
            ),
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n?.cancel ?? 'Cancel'))],
      ),
    );
  }

  void _methodShowCreateNameDialog() {
    final l10n = AppLocalizations.of(context)!;
    final ctrl = TextEditingController(text: _newLevelNameInput);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.nameLevel),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(labelText: 'Name'),
          onChanged: (v) => _newLevelNameInput = v,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () async {
              _newLevelNameInput = ctrl.text;
              Navigator.pop(ctx);
              await _handleCreateLevelConfirm();
            },
            child: Text(l10n.create),
          ),
        ],
      ),
    );
  }

  Future<void> _handleCreateLevelConfirm() async {
    if (_pathStack.isEmpty) return;
    var name = _newLevelNameInput.trim();
    if (!name.toLowerCase().endsWith('.json')) name += '.json';
    // Load template from assets
    String content;
    try {
      content = await rootBundle.loadString('assets/template/${_selectedTemplate}');
    } catch (_) {
      content = '{"objects":[{"objclass":"LevelDefinition","objdata":{"Name":"","LevelNumber":1,"Description":"","StageModule":"RTID(TutorialStage@LevelModules)","Loot":"RTID(DefaultLoot@LevelModules)","StartingSun":200,"VictoryModule":"RTID(VictoryOutro@LevelModules)","MusicType":"","Modules":[]}}],"version":1}';
    }
    final ok = await LevelRepository.createLevelFromTemplate(
      _pathStack.last.path, _selectedTemplate, name, content,
    );
    if (mounted) {
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.levelCreated)),
        );
        setState(() {
          _showCreateNameDialog = false;
          _newLevelNameInput = '';
        });
        _loadCurrentDirectory();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.levelCreateFail)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadCurrentDirectory),
          IconButton(
            icon: Icon(widget.isDarkTheme ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
          PopupMenuButton<String>(
            onOpened: () => _showMenu = true,
            onCanceled: () => _showMenu = false,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'folder',
                child: ListTile(
                  leading: const Icon(Icons.folder_open),
                  title: Text(l10n.switchFolder),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'cache',
                child: ListTile(
                  leading: const Icon(Icons.delete_outline),
                  title: Text(l10n.clearCache),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'ui',
                child: ListTile(
                  leading: const Icon(Icons.aspect_ratio),
                  title: Text(l10n.uiSize),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'lang',
                child: ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(l10n.language),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'about',
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(l10n.aboutSoftware),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 'folder') _pickFolder();
              else if (value == 'cache') {
                final count = await LevelRepository.clearAllInternalCache();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.cacheCleared(count))),
                  );
                }
              } else if (value == 'ui') {
                setState(() => _showUiScaleDialog = true);
                WidgetsBinding.instance.addPostFrameCallback((_) => _showUiScaleDialogImpl());
              }
              else if (value == 'lang') widget.onLanguageTap(context);
              else if (value == 'about') widget.onAboutClick();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_rootFolderPath == null)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(l10n.initSetup, style: theme.textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(l10n.selectFolderPrompt, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: _pickFolder,
                        icon: const Icon(Icons.folder_open),
                        label: Text(l10n.selectFolderButton),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else ...[
            _BreadcrumbBar(pathStack: _pathStack, onBreadcrumbClick: _breadcrumbTap),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _fileItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.folder_open, size: 64, color: theme.colorScheme.surfaceContainerHighest),
                              const SizedBox(height: 16),
                              Text(l10n.emptyFolder, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: (_pathStack.length > 1 ? 1 : 0) + _fileItems.length + 1,
                          itemBuilder: (context, index) {
                            if (_pathStack.length > 1 && index == 0) {
                              return Card(
                                child: ListTile(
                                  leading: const Icon(Icons.folder),
                                  title: Text(l10n.returnUp, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    setState(() => _pathStack = _pathStack.take(_pathStack.length - 1).toList());
                                    _loadCurrentDirectory();
                                  },
                                ),
                              );
                            }
                            final itemIndex = index - (_pathStack.length > 1 ? 1 : 0);
                            if (itemIndex >= _fileItems.length) return const SizedBox(height: 80);
                            final item = _fileItems[itemIndex];
                            return _FileItemRow(
                              item: item,
                              onTap: () async {
                                if (item.isDirectory) {
                                  _navigateToFolder(item);
                                } else {
                                  final ok = await LevelRepository.prepareInternalCache(item.path, item.name);
                                  if (mounted && ok) widget.onLevelClick(item.name, item.path);
                                }
                              },
                              onRename: () {
                                setState(() {
                                  _renameInput = item.isDirectory ? item.name : item.name.replaceFirst(RegExp(r'\.json$'), '');
                                  _itemToRename = item;
                                });
                                WidgetsBinding.instance.addPostFrameCallback((_) => _showRenameDialog());
                              },
                              onDelete: () {
                                setState(() => _itemToDelete = item);
                                WidgetsBinding.instance.addPostFrameCallback((_) => _showDeleteDialog());
                              },
                              onCopy: () {
                                if (!item.isDirectory) {
                                  setState(() {
                                    _copyInput = '${item.name.replaceFirst(RegExp(r'\.json$'), '')}_copy';
                                    _itemToCopy = item;
                                  });
                                  WidgetsBinding.instance.addPostFrameCallback((_) => _showCopyDialog());
                                }
                              },
                            );
                          },
                        ),
            ),
          ],
        ],
      ),
      floatingActionButton: _rootFolderPath != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'folder',
                  onPressed: () {
                    setState(() => _showNewFolderDialog = true);
                    WidgetsBinding.instance.addPostFrameCallback((_) => _showNewFolderDialogImpl());
                  },
                  child: const Icon(Icons.create_new_folder),
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: 'level',
                  onPressed: _openTemplateSelector,
                  child: const Icon(Icons.add),
                ),
              ],
            )
          : null,
    );
  }

  void _showNewFolderDialogImpl() {
    if (!_showNewFolderDialog || !mounted) return;
    setState(() => _showNewFolderDialog = false);
    final l10n = AppLocalizations.of(context)!;
    final ctrl = TextEditingController(text: _newFolderNameInput);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.newFolder),
        content: TextField(
          controller: ctrl,
          decoration: InputDecoration(labelText: l10n.folderName),
          onChanged: (v) => _newFolderNameInput = v,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () async {
              _newFolderNameInput = ctrl.text;
              Navigator.pop(ctx);
              await _handleNewFolder();
            },
            child: Text(l10n.create),
          ),
        ],
      ),
    );
  }

  void _showRenameDialog() {
    final item = _itemToRename;
    if (item == null || !mounted) return;
    setState(() => _itemToRename = null);
    final l10n = AppLocalizations.of(context)!;
    final ctrl = TextEditingController(text: _renameInput);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.rename),
        content: TextField(
          controller: ctrl,
          decoration: InputDecoration(labelText: l10n.newName),
          onChanged: (v) => _renameInput = v,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () async {
              _renameInput = ctrl.text;
              Navigator.pop(ctx);
              await _handleRenameConfirm();
            },
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    final target = _itemToDelete;
    if (target == null || !mounted) return;
    setState(() => _itemToDelete = null);
    final l10n = AppLocalizations.of(context)!;
    var confirm = false;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.confirmDelete),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.confirmDeleteMessage(
                target.name,
                target.isDirectory ? l10n.folderDeleteDetail : l10n.levelDeleteDetail,
              )),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: confirm,
                onChanged: (v) => setDialogState(() => confirm = v ?? false),
                title: Text(l10n.confirmDeleteCheckbox),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
            FilledButton(
              onPressed: confirm
                  ? () async {
                      Navigator.pop(ctx);
                      await _handleDeleteConfirmFor(target);
                    }
                  : null,
              child: Text(l10n.confirm),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleDeleteConfirmFor(FileItem target) async {
    if (_pathStack.isEmpty) return;
    await LevelRepository.deleteItem(_pathStack.last.path, target.name, target.isDirectory);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.deleted)),
      );
      _loadCurrentDirectory();
    }
  }

  void _showCopyDialog() {
    final item = _itemToCopy;
    if (item == null || !mounted) return;
    setState(() => _itemToCopy = null);
    final l10n = AppLocalizations.of(context)!;
    final ctrl = TextEditingController(text: _copyInput);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.copyLevel),
        content: TextField(
          controller: ctrl,
          decoration: InputDecoration(labelText: l10n.newFileName),
          onChanged: (v) => _copyInput = v,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () async {
              _copyInput = ctrl.text;
              Navigator.pop(ctx);
              await _handleCopyConfirm();
            },
            child: Text(l10n.copy),
          ),
        ],
      ),
    );
  }

  void _showUiScaleDialogImpl() {
    if (!_showUiScaleDialog || !mounted) return;
    setState(() => _showUiScaleDialog = false);
    final l10n = AppLocalizations.of(context)!;
    var tempScale = widget.uiScale;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.adjustUiSize),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.currentScale((tempScale * 100).toInt().toString())),
              Slider(
                value: tempScale,
                min: 0.75,
                max: 1.25,
                onChanged: (v) => setDialogState(() => tempScale = v),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.small),
                  Text(l10n.standard),
                  Text(l10n.large),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.onUiScaleChange(1.0);
                Navigator.pop(ctx);
              },
              child: Text(l10n.reset),
            ),
            TextButton(
              onPressed: () {
                widget.onUiScaleChange(tempScale);
                Navigator.pop(ctx);
              },
              child: Text(l10n.done),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreadcrumbBar extends StatelessWidget {
  const _BreadcrumbBar({
    required this.pathStack,
    required this.onBreadcrumbClick,
  });

  final List<({String name, String path})> pathStack;
  final void Function(int index) onBreadcrumbClick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Row(
        children: [
          for (int i = 0; i < pathStack.length; i++) ...[
            InkWell(
              onTap: i < pathStack.length - 1 ? () => onBreadcrumbClick(i) : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: i == pathStack.length - 1
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (i == 0) ...[
                      Icon(Icons.folder_open, size: 16, color: theme.colorScheme.onPrimaryContainer),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      pathStack[i].name,
                      style: TextStyle(
                        fontWeight: i == pathStack.length - 1 ? FontWeight.bold : FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (i < pathStack.length - 1) ...[
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios, size: 12, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
            ],
          ],
        ],
      ),
    );
  }
}

class _FileItemRow extends StatelessWidget {
  const _FileItemRow({
    required this.item,
    required this.onTap,
    required this.onRename,
    required this.onDelete,
    required this.onCopy,
  });

  final FileItem item;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final displayName = item.isDirectory ? item.name : item.name.replaceFirst(RegExp(r'\.json$'), '');

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          item.isDirectory ? Icons.folder : Icons.description,
          color: item.isDirectory ? const Color(0xFFFFC107) : theme.colorScheme.primary,
        ),
        title: Text(displayName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: item.isDirectory ? null : Text(l10n.jsonFile),
        onTap: onTap,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onRename),
            if (!item.isDirectory) IconButton(icon: const Icon(Icons.copy), onPressed: onCopy),
            IconButton(icon: Icon(Icons.delete, color: theme.colorScheme.error), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
