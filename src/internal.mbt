///|
extern "c" fn Index::_parse(
  self : Index #borrow,
  source_filename : Bytes,
  command_line_args : FixedArray[Bytes],
  option : TranslationUnit_Flags,
  out_ec : Ref[ErrorCode],
) -> TranslationUnit = "illusory0x0_clang_Index_parse"

///|
extern "c" fn Cursor::_visit_children(
  self : Cursor #borrow,
  f : (Cursor) -> IterResult,
) -> IterResult = "illusory0x0_clang_Cursor_visit_children"

///|
extern "c" fn Type::_op_equal(self : Type #borrow, other : Type #borrow) -> Bool = "illusory0x0_clang_Type_op_equal"

///|
extern "c" fn Cursor::_op_equal(self : Cursor #borrow, other : Cursor #borrow) -> Bool = "illusory0x0_clang_Cursor_op_equal"

///|
extern "c" fn SourceLocation::_op_equal(
  self : SourceLocation #borrow,
  other : SourceLocation,
) -> Bool = "illusory0x0_clang_SourceLocation_op_equal"

///|
extern "c" fn SourceRange::_op_equal(
  self : SourceRange #borrow,
  other : SourceRange,
) -> Bool = "illusory0x0_clang_SourceRange_op_equal"
