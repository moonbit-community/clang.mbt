///|
pub enum TranslationUnit_Flags {
  None = 0x0
  DetailedPreprocessingRecord = 0x01
  Incomplete = 0x02
  PrecompiledPreamble = 0x04
  CacheCompletionResults = 0x08
  ForSerialization = 0x10
  CXXChainedPCH = 0x20
  SkipFunctionBodies = 0x40
  IncludeBriefCommentsInCodeCompletion = 0x80
  CreatePreambleOnFirstParse = 0x100
  KeepGoing = 0x200
  SingleFileParse = 0x400
  LimitSkipFunctionBodiesToPreamble = 0x800
  IncludeAttributedTypes = 0x1000
  VisitImplicitAttributes = 0x2000
  IgnoreNonErrorsFromIncludedFiles = 0x4000
  RetainExcludedConditionalBlocks = 0x8000
} derive(Show, Eq)

///|
pub impl BitOr for TranslationUnit_Flags with lor(self, other) = "%i32_lor"
