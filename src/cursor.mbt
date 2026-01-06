///|
#borrow(self)
pub extern "c" fn Cursor::kind(self : Cursor) -> CursorKind = "illusory0x0_clang_Cursor_kind"

///|
#borrow(self)
pub extern "c" fn Cursor::spelling(self : Cursor) -> Bytes = "illusory0x0_clang_Cursor_spelling"

///|
#borrow(self)
pub extern "c" fn Cursor::display_name(self : Cursor) -> Bytes = "illusory0x0_clang_Cursor_display_name"

///|
#borrow(self)
pub extern "c" fn Cursor::type_(self : Cursor) -> Type = "illusory0x0_clang_Cursor_type_"

///|
/// TODO: use pattern match implemented String version
pub extern "c" fn Cursor::kind_spelling(k : CursorKind) -> Bytes = "illusory0x0_clang_Cursor_kind_spelling"

///|
#borrow(self)
pub extern "c" fn Cursor::semantic_parent(self : Cursor) -> Cursor = "illusory0x0_clang_Cursor_semantic_parent"

///|
#borrow(self)
pub extern "c" fn Cursor::lexical_parent(self : Cursor) -> Cursor = "illusory0x0_clang_Cursor_lexical_parent"

///|
pub extern "c" fn Cursor::null() -> Cursor = "illusory0x0_clang_Cursor_null"

///|
#borrow(self)
pub extern "c" fn Cursor::is_null(self : Cursor) -> Bool = "illusory0x0_clang_Cursor_is_null"

///|
#borrow(self)
pub extern "c" fn Cursor::typedef_decl_underlying_type(self : Cursor) -> Type = "illusory0x0_clang_Cursor_typedef_decl_underlying_type"

///|
#borrow(self)
pub extern "c" fn Cursor::enum_decl_integer_type(self : Cursor) -> Type = "illusory0x0_clang_Cursor_enum_decl_integer_type"

///|
#borrow(self)
pub extern "c" fn Cursor::enum_constant_decl_value(self : Cursor) -> Int64 = "illusory0x0_clang_Cursor_enum_constant_decl_value"

///|
#borrow(self)
pub extern "c" fn Cursor::enum_constant_decl_unsigned_value(
  self : Cursor,
) -> UInt64 = "illusory0x0_clang_Cursor_enum_constant_decl_unsigned_value"

///|

///|
fn Cursor::children(self : Cursor) -> Iterator[Cursor] {
  let children : Array[Cursor] = []
  ignore(
    Cursor::_visit_children(self, fn(child) {
      children.push(child)
      IterResult::IterContinue
    }),
  )
  let mut index = 0
  Iterator::new(fn() {
    if index < children.length() {
      let child = children[index]
      index += 1
      Some(child)
    } else {
      None
    }
  })
}

///|
#borrow(self)
pub extern "c" fn Cursor::canonical(self : Cursor) -> Cursor = "illsuory0x0_clang_Cursor_canonical"

///|
#borrow(self)
pub extern "c" fn Cursor::is_macro_function_like(self : Cursor) -> Bool = "illusory0x0_clang_Cursor_is_macro_function_like"

///|
#borrow(self)
pub extern "c" fn Cursor::is_macro_builtin(self : Cursor) -> Bool = "illusory0x0_clang_Cursor_is_macro_builtin"

///|
#borrow(self)
pub extern "c" fn Cursor::is_function_inlined(self : Cursor) -> Bool = "illusory0x0_clang_Cursor_is_function_inlined"

///|
#borrow(self)
pub extern "c" fn Cursor::language(self : Cursor) -> LanguageKind = "illusory0x0_clang_Cursor_language"

///|
#borrow(self)
pub extern "c" fn Cursor::linkage(self : Cursor) -> LinkageKind = "illusory0x0_clang_Cursor_linkage"

///|
#borrow(self)
pub extern "c" fn Cursor::availability(self : Cursor) -> LinkageKind = "illusory0x0_clang_Cursor_availability"

///|
#borrow(self)
pub extern "c" fn Cursor::visibility(self : Cursor) -> LinkageKind = "illusory0x0_clang_Cursor_visibility"

///|
#borrow(self)
pub extern "c" fn Cursor::cxx_access_specifier(
  self : Cursor,
) -> CXX_AccessSpecifier = "illusory0x0_clang_cursor_cxx_access_specifier"

///|
#borrow(self)
pub extern "c" fn Cursor::storage_class(self : Cursor) -> StorageClass = "illusory0x0_clang_cursor_storage_class"

///|
#borrow(self)
pub extern "c" fn Cursor::overloaded_decls_num(self : Cursor) -> Int = "illusory0x0_clang_cursor_overloaded_decls_num"

///|
#borrow(self)
pub extern "c" fn Cursor::overloaded_decls(
  self : Cursor,
  index : Int,
) -> Cursor = "illusory0x0_clang_Cursor_overloaded_decls"

///|
#borrow(self)
pub extern "c" fn Cursor::source_location(self : Cursor) -> SourceLocation = "illusory0x0_clang_Cursor_source_location"

///|
#borrow(self)
pub extern "c" fn Cursor::extent(self : Cursor) -> SourceRange = "illusory0x0_clang_Cursor_extent"
