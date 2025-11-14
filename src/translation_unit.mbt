///|
pub extern "c" fn TranslationUnit::cursor(self : TranslationUnit) #borrow -> Cursor = "illusory0x0_clang_TranslationUnit_cursor"

///|
pub extern "c" fn TranslationUnit::target_info(
  self : TranslationUnit,  // #borrow
) -> TargetInfo = "illusory0x0_clang_TranslationUnit_target_info"

///|
pub extern "c" fn TranslationUnit::tokenize(
  self : TranslationUnit,  // #borrow
  range : SourceRange,
) -> FixedArray[Token] = "illusory0x0_clang_TranslationUnit_tokenize"
