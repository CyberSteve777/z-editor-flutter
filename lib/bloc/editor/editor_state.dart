part of 'editor_cubit.dart';

final class EditorState extends Equatable {
  const EditorState({
    this.levelFile,
    this.parsedData,
    this.isLoading = true,
    this.hasChanges = false,
    this.availableTabs = const [EditorTabType.settings],
  });

  final PvzLevelFile? levelFile;
  final ParsedLevelData? parsedData;
  final bool isLoading;
  final bool hasChanges;
  final List<EditorTabType> availableTabs;

  EditorState copyWith({
    PvzLevelFile? levelFile,
    ParsedLevelData? parsedData,
    bool? isLoading,
    bool? hasChanges,
    List<EditorTabType>? availableTabs,
    bool clearLevel = false,
  }) {
    return EditorState(
      levelFile: clearLevel ? null : (levelFile ?? this.levelFile),
      parsedData: clearLevel ? null : (parsedData ?? this.parsedData),
      isLoading: isLoading ?? this.isLoading,
      hasChanges: hasChanges ?? this.hasChanges,
      availableTabs: availableTabs ?? this.availableTabs,
    );
  }

  @override
  List<Object?> get props =>
      [levelFile, parsedData, isLoading, hasChanges, availableTabs];
}
