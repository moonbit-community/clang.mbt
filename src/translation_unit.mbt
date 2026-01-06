///|
#borrow(self)
pub extern "c" fn TranslationUnit::cursor(
  self : TranslationUnit,
) -> Cursor = "illusory0x0_clang_TranslationUnit_cursor"

///|
#borrow(self)
pub extern "c" fn TranslationUnit::target_info(
  self : TranslationUnit,
) -> TargetInfo = "illusory0x0_clang_TranslationUnit_target_info"

///|
#borrow(self, range)
pub extern "c" fn TranslationUnit::tokenize(
  self : TranslationUnit,
  range : SourceRange,
) -> FixedArray[Token] = "illusory0x0_clang_TranslationUnit_tokenize"
