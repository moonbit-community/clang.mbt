///|
pub extern "c" fn Type::address_space(self : Type) #borrow -> Int = "illusory0x0_clang_Type_address_space"

///|
pub extern "c" fn Type::typedef_name(self : Type) #borrow -> Byte = "illusory0x0_Type_typedef_name"

///|
pub extern "c" fn Type::pointee(self : Type) #borrow -> Type = "illusory0x0_clang_Type_pointee"

///|
pub extern "c" fn Type::unqualified(self : Type) #borrow -> Type = "illusory0x0_clang_Type_unqualified"

///|
pub extern "c" fn Type::calling_conv(self : Type) #borrow -> CallingConv = "illusory0x0_clang_Type_calling_conv"

///|
pub extern "c" fn Type::arity(self : Type) #borrow -> Int = "illusory0x0_clang_Type_arity"

///|
pub extern "c" fn Type::argument(self : Type,  // #borrow index : Int) -> Type = "illusory0x0_clang_Type_argument"

///|
pub extern "c" fn Type::result(self : Type) #borrow -> Type = "illusory0x0_clang_Type_result"

///| 
/// Return the size of a type in **bytes**
pub extern "c" fn Type::sizeof(self : Type) #borrow -> Int64 = "illusory0x0_clang_Type_sizeof"

///| 
/// Return the offset of a field named S in a record of type T in **bits**
pub extern "c" fn Type::offsetof(self : Type,  // #borrow member_ : Bytes) -> Int64 = "illusory0x0_clang_Type_offsetof"

///|
pub extern "c" fn Type::is_const_qualified(self : Type) #borrow -> Bool = "illusory0x0_clang_Type_is_const_qualified"

///|
pub extern "c" fn Type::is_volatile_qualified(self : Type) #borrow -> Bool = "illusory0x0_clang_Type_is_volatile_qualified"

///|
pub extern "c" fn Type::is_restrict_qualified(self : Type) #borrow -> Bool = "illusory0x0_clang_Type_is_restrict_qualified"

///|
fn Type::desugar(self : Type) -> Type {
  self.canonical()
}

///|
pub extern "c" fn Type::canonical(self : Type) #borrow -> Type = "illsuory0x0_clang_Type_canonical"

///|
pub extern "c" fn Type::spelling(self : Type) #borrow -> Bytes = "illusory0x0_clang_Type_spelling"

///| TODO: use pattern match implemented String version
pub extern "c" fn Type::kind_spelling(k : TypeKind) -> Bytes = "illusory0x0_clang_Type_kind_spelling"

///|
pub extern "c" fn Type::kind(self : Type) #borrow -> TypeKind = "illusory0x0_clang_Type_kind"

///|
pub extern "c" fn Type::type_declaration(self : Type) #borrow -> Cursor = "illusory0x0_clang_Type_type_declaration"
