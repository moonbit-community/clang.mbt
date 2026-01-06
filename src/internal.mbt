///|
#borrow(self, source_filename, command_line_args, out_ec)
extern "c" fn Index::_parse(
  self : Index,
  source_filename : Bytes,
  command_line_args : FixedArray[Bytes],
  option : TranslationUnit_Flags,
  out_ec : Ref[ErrorCode],
) -> TranslationUnit = "illusory0x0_clang_Index_parse"

///|
#borrow(self)
extern "c" fn Cursor::_visit_children(
  self : Cursor,
  f : (Cursor) -> IterResult,
) -> IterResult = "illusory0x0_clang_Cursor_visit_children"

///|
#borrow(self, other)
extern "c" fn Type::_op_equal(
  self : Type,
  other : Type,
) -> Bool = "illusory0x0_clang_Type_op_equal"

///|
#borrow(self, other)
extern "c" fn Cursor::_op_equal(
  self : Cursor,
  other : Cursor,
) -> Bool = "illusory0x0_clang_Cursor_op_equal"

///|
#borrow(self, other)
extern "c" fn SourceLocation::_op_equal(
  self : SourceLocation,
  other : SourceLocation,
) -> Bool = "illusory0x0_clang_SourceLocation_op_equal"

///|
#borrow(self, other)
extern "c" fn SourceRange::_op_equal(
  self : SourceRange,
  other : SourceRange,
) -> Bool = "illusory0x0_clang_SourceRange_op_equal"
