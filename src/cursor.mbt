///|
pub extern "c" fn Cursor::kind(self : Cursor) #borrow -> CursorKind = "illusory0x0_clang_Cursor_kind"

///|
pub extern "c" fn Cursor::spelling(self : Cursor) #borrow -> Bytes = "illusory0x0_clang_Cursor_spelling"

///|
pub extern "c" fn Cursor::display_name(self : Cursor) #borrow -> Bytes = "illusory0x0_clang_Cursor_display_name"

///|
pub extern "c" fn Cursor::type_(self : Cursor) #borrow -> Type = "illusory0x0_clang_Cursor_type_"

///| TODO: use pattern match implemented String version
pub extern "c" fn Cursor::kind_spelling(k : CursorKind) -> Bytes = "illusory0x0_clang_Cursor_kind_spelling"

///|
pub extern "c" fn Cursor::semantic_parent(self : Cursor) #borrow -> Cursor = "illusory0x0_clang_Cursor_semantic_parent"

///|
pub extern "c" fn Cursor::lexical_parent(self : Cursor) #borrow -> Cursor = "illusory0x0_clang_Cursor_lexical_parent"

///|
pub extern "c" fn Cursor::null() -> Cursor = "illusory0x0_clang_Cursor_null"

///|
pub extern "c" fn Cursor::is_null(self : Cursor) #borrow -> Bool = "illusory0x0_clang_Cursor_is_null"

///|
pub extern "c" fn Cursor::typedef_decl_underlying_type(self : Cursor) #borrow -> Type = "illusory0x0_clang_Cursor_typedef_decl_underlying_type"

///|
pub extern "c" fn Cursor::enum_decl_integer_type(self : Cursor) #borrow -> Type = "illusory0x0_clang_Cursor_enum_decl_integer_type"

///|
pub extern "c" fn Cursor::enum_constant_decl_value(self : Cursor) #borrow -> Int64 = "illusory0x0_clang_Cursor_enum_constant_decl_value"

///|
pub extern "c" fn Cursor::enum_constant_decl_unsigned_value(
  self : Cursor,
) -> UInt64 = "illusory0x0_clang_Cursor_enum_constant_decl_unsigned_value"

///|

///|
fn Cursor::children(self : Cursor) -> Iter[Cursor] {
  Iter::new(fn(f) { Cursor::_visit_children(self, f) })
}

///|
pub extern "c" fn Cursor::canonical(self : Cursor) #borrow -> Cursor = "illsuory0x0_clang_Cursor_canonical"

///|
pub extern "c" fn Cursor::is_macro_function_like(self : Cursor) #borrow -> Bool = "illusory0x0_clang_Cursor_is_macro_function_like"

///|
pub extern "c" fn Cursor::is_macro_builtin(self : Cursor) #borrow -> Bool = "illusory0x0_clang_Cursor_is_macro_builtin"

///|
pub extern "c" fn Cursor::is_function_inlined(self : Cursor) #borrow -> Bool = "illusory0x0_clang_Cursor_is_function_inlined"

///|
pub extern "c" fn Cursor::language(self : Cursor) #borrow -> LanguageKind = "illusory0x0_clang_Cursor_language"

///|
pub extern "c" fn Cursor::linkage(self : Cursor) #borrow -> LinkageKind = "illusory0x0_clang_Cursor_linkage"

///|
pub extern "c" fn Cursor::availability(self : Cursor) #borrow -> LinkageKind = "illusory0x0_clang_Cursor_availability"

///|
pub extern "c" fn Cursor::visibility(self : Cursor) #borrow -> LinkageKind = "illusory0x0_clang_Cursor_visibility"

///|
pub extern "c" fn Cursor::cxx_access_specifier(
  self : Cursor,
) -> CXX_AccessSpecifier = "illusory0x0_clang_cursor_cxx_access_specifier"

///|
pub extern "c" fn Cursor::storage_class(self : Cursor) #borrow -> StorageClass = "illusory0x0_clang_cursor_storage_class"

///|
pub extern "c" fn Cursor::overloaded_decls_num(self : Cursor) #borrow -> Int = "illusory0x0_clang_cursor_overloaded_decls_num"

///|
pub extern "c" fn Cursor::overloaded_decls(
  self : Cursor,
  index : Int,
) -> Cursor = "illusory0x0_clang_Cursor_overloaded_decls"

///|
pub extern "c" fn Cursor::source_location(self : Cursor) #borrow -> SourceLocation = "illusory0x0_clang_Cursor_source_location"

///|
pub extern "c" fn Cursor::extent(self : Cursor) #borrow -> SourceRange = "illusory0x0_clang_Cursor_extent"
