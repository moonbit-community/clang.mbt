///|
using @encoding {decode}

///|
impl Show for Type with output(self, logger) {
  try {
    let s = self.spelling() |> decode(encoding=UTF8)
    let k = Type::kind_spelling(self.kind()) |> decode(encoding=UTF8)
    logger.write_string("{ spelling : \{s}, kind: \{k} }")
  } catch {
    e => logger.write_object(e)
  }
}

///|
impl Show for Cursor with output(self, logger) {
  try {
    let s = self.spelling() |> decode(encoding=UTF8)
    let k = Cursor::kind_spelling(self.kind()) |> decode(encoding=UTF8)
    logger.write_string("{ spelling : \{s}, kind: \{k} }")
  } catch {
    e => logger.write_object(e)
  }
}

///|
test "type decl" {
  let index = Index::new(false, false)
  let tu = index.parse(b"test/type_decl.c\x00", [], None)
  let csr = tu.cursor()
  inspect(csr, content="{ spelling : test/type_decl.c, kind: TranslationUnit }")
  inspect(
    csr.children(),
    content="[{ spelling : A, kind: StructDecl }, { spelling : AA, kind: TypedefDecl }, { spelling : x, kind: VarDecl }]",
  )
  let x = csr.children().find_first(x => x.spelling() == "x").unwrap()
  inspect(x, content="{ spelling : x, kind: VarDecl }")
  inspect(x.type_(), content="{ spelling : AA, kind: Elaborated }")
  inspect(
    x.type_().type_declaration(),
    content="{ spelling : AA, kind: TypedefDecl }",
  )
  inspect(
    x.type_().type_declaration().type_(),
    content="{ spelling : AA, kind: Typedef }",
  )
  inspect(
    x.type_().type_declaration().type_().desugar(),
    content="{ spelling : struct A *, kind: Pointer }",
  )
}

///|
test {
  let index = Index::new(false, false)
  try {
    let _tu = index.parse(b"not_exists_file\x00", [], None)

  } catch {
    e => inspect(e, content="ParseError(ASTReadError)")
  }
}

///|
fn Bytes::to_utf16(x : Bytes) -> String {
  decode(x, encoding=UTF8) catch {
    _ => panic()
  }
}

///|
test "enum" {
  let index = Index::new(false, false)
  let tu = index.parse(b"test/enums.c\x00", [], None)
  let csr = tu.cursor()
  let x = csr.children().head().unwrap()
  inspect(x, content="{ spelling : ExitCode, kind: EnumDecl }")
  let enum_items = x
    .children()
    .map(fn(x) { (x.display_name().to_utf16(), x.enum_constant_decl_value()) })
  inspect(
    enum_items,
    content=(
      #|[("Success", 0), ("Failure", 255)]
    ),
  )
  inspect(csr, content="{ spelling : test/enums.c, kind: TranslationUnit }")
}

///|
test "DetailedPreprocessingRecord" {
  let index = Index::new(false, false)
  let tu = index.parse(b"test/test.c\x00", [], DetailedPreprocessingRecord)
  let csr = tu.cursor()
  let csr_loc = csr.source_location()
  let csr_rg = csr.extent()
  inspect(csr_loc == csr_loc, content="true")
  inspect(csr_rg == csr_rg, content="true")
  inspect(csr == csr, content="true")
  inspect(csr, content="{ spelling : test/test.c, kind: TranslationUnit }")
  let ti = tu.target_info()
  inspect(ti.pointer_width(), content="64")
  inspect(ti.triple() |> decode(encoding=UTF8), content="x86_64-pc-linux-gnu")
  let csr_children = csr.children().collect()
  let x = csr_children[0]
  // Cursor predicate
  inspect(x.is_macro_builtin(), content="false")
  inspect(x.is_function_inlined(), content="false")
  inspect(x.is_null(), content="false")
  inspect(x.is_macro_function_like(), content="false")
  inspect(x.is_function_inlined(), content="false")
  // Cursor predicate end
  inspect(x.availability(), content="Invalid")
  inspect(
    x.canonical(),
    content="{ spelling : __llvm__, kind: macro definition }",
  )
  inspect(x.display_name() |> decode(encoding=UTF8), content="__llvm__")
  let struct_idx = csr_children.search_by(c => c.kind() ==
    @cursor_kind.StructDecl)
  let st = csr_children[struct_idx.unwrap()]
  inspect(st, content="{ spelling : A, kind: StructDecl }")
  let stty = st.type_()
  inspect(stty, content="{ spelling : struct A, kind: Record }")
  inspect(stty.address_space(), content="0")
  inspect(stty.canonical(), content="{ spelling : struct A, kind: Record }")
  inspect(stty.is_const_qualified(), content="false")
  inspect(stty.is_restrict_qualified(), content="false")
  inspect(stty.is_volatile_qualified(), content="false")
  inspect(stty.kind(), content="105")
  inspect(stty.sizeof(), content="136")
  inspect(stty.offsetof(b"x\x00"), content="0")
  inspect(stty.offsetof(b"y\x00"), content="32")
  inspect(stty.offsetof(b"arr\x00"), content="64")
  inspect(stty.offsetof(b"undefined_field\x00"), content="-5")
  let foo_idx = csr_children.search_by(c => c.spelling() == b"foo")
  let foo = csr_children[foo_idx.unwrap()]
  let foo_ty = foo.type_()
  inspect(
    foo_ty,
    content="{ spelling : void (int, double, struct A), kind: FunctionProto }",
  )
  inspect(foo_ty == foo_ty, content="true")
  inspect(foo_ty.calling_conv(), content="C")
  inspect(foo_ty.result(), content="{ spelling : void, kind: Void }")
  inspect(foo_ty.arity(), content="3")
  inspect(foo.linkage(), content="External")
  inspect(foo.language(), content="C")
  inspect(foo.visibility(), content="UniqueExternal")
  inspect(foo.availability(), content="Invalid")
  let foo_ty_arity = foo_ty.arity()
  let args = []
  for i in 0..<foo_ty_arity {
    args.push(foo_ty.argument(i))
  }
  inspect(
    args.map(Type::to_string),
    content=(
      #|["{ spelling : int, kind: Int }", "{ spelling : double, kind: Double }", "{ spelling : struct A, kind: Elaborated }"]
    ),
  )
  let happy_idx = csr_children.search_by(c => c.spelling() == b"happy")
  let happy = csr_children[happy_idx.unwrap()]
  inspect(happy, content="{ spelling : happy, kind: TypedefDecl }")
  let happy_ty = happy.type_()
  inspect(happy, content="{ spelling : happy, kind: TypedefDecl }")
  let happy_ty_uy = happy_ty.desugar()
  inspect(
    happy_ty_uy,
    content="{ spelling : const volatile struct A *restrict, kind: Pointer }",
  )
  inspect(happy_ty_uy.kind(), content="101")
  inspect(happy_ty.kind(), content="107")
  inspect(
    happy_ty_uy.pointee(),
    content="{ spelling : const volatile struct A, kind: Record }",
  )
  inspect(happy_ty_uy.pointee().is_const_qualified(), content="true")
  inspect(happy_ty_uy.pointee().is_volatile_qualified(), content="true")
  inspect(happy_ty_uy.is_restrict_qualified(), content="true")
  inspect(
    happy.typedef_decl_underlying_type(),
    content="{ spelling : const volatile struct A *restrict, kind: Pointer }",
  )
  inspect(happy.display_name() |> decode(encoding=UTF8), content="happy")
}

///|
test {
  let index = Index::new(false, false)
  let tu = index.parse(b"test/test.cxx\x00", [], None)
  let csr = tu.cursor()
  inspect(csr, content="{ spelling : test/test.cxx, kind: TranslationUnit }")
  let toplvls = csr.children().collect()
  let foo = toplvls[0]
  inspect(foo, content="{ spelling : swap, kind: FunctionTemplate }")
  let methods = foo.children().collect()
  inspect(methods.map(Cursor::storage_class), content="[Invalid, None, None]")
  let bar = toplvls[3]
  inspect(bar, content="{ spelling : reverse, kind: FunctionTemplate }")
  let bar_expr = bar.children().head().unwrap().children().collect()
  inspect(bar_expr.length(), content="0")
  let xs = []
  fn dfs(cur : Cursor) -> Unit {
    if cur.kind() == @cursor_kind.OverloadedDeclRef {
      xs.push(cur)
    }
    for x in cur.children() {
      dfs(x)
    }
  }

  dfs(csr)
  inspect(xs, content="[{ spelling : swap, kind: OverloadedDeclRef }]")
  let oldr = xs[0]
  inspect(oldr.overloaded_decls_num(), content="2")
  inspect(
    oldr.overloaded_decls(0),
    content="{ spelling : swap, kind: FunctionDecl }",
  )
  inspect(
    oldr.overloaded_decls(1),
    content="{ spelling : swap, kind: FunctionTemplate }",
  )
}

///|
test "macro" {
  let index = Index::new(false, false)
  let tu = index.parse(b"test/macro.c\x00", [], DetailedPreprocessingRecord)
  let csr = tu.cursor()
  inspect(csr, content="{ spelling : test/macro.c, kind: TranslationUnit }")
  let x = csr.children().find_first(x => x.spelling() == "FOO").unwrap()
  inspect(x, content="{ spelling : FOO, kind: macro definition }")
  let range = x.extent()
  let toks = tu.tokenize(range)
  inspect(
    toks.map(t => Token::spelling(t).to_utf16()),
    content=(
      #|["FOO", "(", "{", "1", ",", "2", ",", "3", ",", "4", ",", "5", "}", ")"]
    ),
  )
  let bar = csr
    .children()
    .find_first(x => x.spelling() == "Bar" &&
      x.kind() == @cursor_kind.MacroDefinition)
    .unwrap()
  inspect(bar, content="{ spelling : Bar, kind: macro definition }")
  let rg = bar.extent()
  inspect(bar.display_name() |> decode(encoding=UTF8), content="Bar")
  inspect(bar.children(), content="[]")
  let toks = tu.tokenize(rg)
  inspect(
    toks.map(t => Token::spelling(t).to_utf16()),
    content=(
      #|["Bar", "Bar"]
    ),
  )
  let max = csr.children().find_first(x => x.spelling() == "max").unwrap()
  let rg = max.extent()
  inspect(max.display_name() |> decode(encoding=UTF8), content="max")
  inspect(max.children(), content="[]")
  let toks = tu.tokenize(rg)
  inspect(
    toks.map(t => Token::spelling(t).to_utf16()),
    content=(
      #|["max", "(", "a", ",", "b", ")", "(", "a", ">", "b", "?", "a", ":", "b", ")"]
    ),
  )
  inspect(max, content="{ spelling : max, kind: macro definition }")
}

///|
test {
  let index = Index::new(false, false)
  let tu = index.parse(b"test/test.c\x00", [], DetailedPreprocessingRecord)
  let csr = tu.cursor()
  inspect(csr, content="{ spelling : test/test.c, kind: TranslationUnit }")
  let sr = csr.extent()
  let toks = tu.tokenize(sr)
  let tokss = toks.map(tok => tok.spelling().to_utf16()).iter().join(" ")
  inspect(toks.length(), content="50")
  inspect(
    tokss,
    content="struct A { int x ; int y ; char arr [ 128 ] ; } ; void foo ( int x , double y , struct A z ) { } # define id ( x ) ( x ) typedef struct A const volatile * restrict happy ;",
  )
  toks |> ignore
  inspect(
    csr.children().map(c => c.to_string()).join("\n"),
    content=(
      #|{ spelling : __llvm__, kind: macro definition }
      #|{ spelling : __clang__, kind: macro definition }
      #|{ spelling : __clang_major__, kind: macro definition }
      #|{ spelling : __clang_minor__, kind: macro definition }
      #|{ spelling : __clang_patchlevel__, kind: macro definition }
      #|{ spelling : __clang_version__, kind: macro definition }
      #|{ spelling : __GNUC__, kind: macro definition }
      #|{ spelling : __GNUC_MINOR__, kind: macro definition }
      #|{ spelling : __GNUC_PATCHLEVEL__, kind: macro definition }
      #|{ spelling : __GXX_ABI_VERSION, kind: macro definition }
      #|{ spelling : __ATOMIC_RELAXED, kind: macro definition }
      #|{ spelling : __ATOMIC_CONSUME, kind: macro definition }
      #|{ spelling : __ATOMIC_ACQUIRE, kind: macro definition }
      #|{ spelling : __ATOMIC_RELEASE, kind: macro definition }
      #|{ spelling : __ATOMIC_ACQ_REL, kind: macro definition }
      #|{ spelling : __ATOMIC_SEQ_CST, kind: macro definition }
      #|{ spelling : __MEMORY_SCOPE_SYSTEM, kind: macro definition }
      #|{ spelling : __MEMORY_SCOPE_DEVICE, kind: macro definition }
      #|{ spelling : __MEMORY_SCOPE_WRKGRP, kind: macro definition }
      #|{ spelling : __MEMORY_SCOPE_WVFRNT, kind: macro definition }
      #|{ spelling : __MEMORY_SCOPE_SINGLE, kind: macro definition }
      #|{ spelling : __OPENCL_MEMORY_SCOPE_WORK_ITEM, kind: macro definition }
      #|{ spelling : __OPENCL_MEMORY_SCOPE_WORK_GROUP, kind: macro definition }
      #|{ spelling : __OPENCL_MEMORY_SCOPE_DEVICE, kind: macro definition }
      #|{ spelling : __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES, kind: macro definition }
      #|{ spelling : __OPENCL_MEMORY_SCOPE_SUB_GROUP, kind: macro definition }
      #|{ spelling : __FPCLASS_SNAN, kind: macro definition }
      #|{ spelling : __FPCLASS_QNAN, kind: macro definition }
      #|{ spelling : __FPCLASS_NEGINF, kind: macro definition }
      #|{ spelling : __FPCLASS_NEGNORMAL, kind: macro definition }
      #|{ spelling : __FPCLASS_NEGSUBNORMAL, kind: macro definition }
      #|{ spelling : __FPCLASS_NEGZERO, kind: macro definition }
      #|{ spelling : __FPCLASS_POSZERO, kind: macro definition }
      #|{ spelling : __FPCLASS_POSSUBNORMAL, kind: macro definition }
      #|{ spelling : __FPCLASS_POSNORMAL, kind: macro definition }
      #|{ spelling : __FPCLASS_POSINF, kind: macro definition }
      #|{ spelling : __PRAGMA_REDEFINE_EXTNAME, kind: macro definition }
      #|{ spelling : __VERSION__, kind: macro definition }
      #|{ spelling : __OBJC_BOOL_IS_BOOL, kind: macro definition }
      #|{ spelling : __CONSTANT_CFSTRINGS__, kind: macro definition }
      #|{ spelling : __clang_literal_encoding__, kind: macro definition }
      #|{ spelling : __clang_wide_literal_encoding__, kind: macro definition }
      #|{ spelling : __ORDER_LITTLE_ENDIAN__, kind: macro definition }
      #|{ spelling : __ORDER_BIG_ENDIAN__, kind: macro definition }
      #|{ spelling : __ORDER_PDP_ENDIAN__, kind: macro definition }
      #|{ spelling : __BYTE_ORDER__, kind: macro definition }
      #|{ spelling : __LITTLE_ENDIAN__, kind: macro definition }
      #|{ spelling : _LP64, kind: macro definition }
      #|{ spelling : __LP64__, kind: macro definition }
      #|{ spelling : __CHAR_BIT__, kind: macro definition }
      #|{ spelling : __BOOL_WIDTH__, kind: macro definition }
      #|{ spelling : __SHRT_WIDTH__, kind: macro definition }
      #|{ spelling : __INT_WIDTH__, kind: macro definition }
      #|{ spelling : __LONG_WIDTH__, kind: macro definition }
      #|{ spelling : __LLONG_WIDTH__, kind: macro definition }
      #|{ spelling : __BITINT_MAXWIDTH__, kind: macro definition }
      #|{ spelling : __SCHAR_MAX__, kind: macro definition }
      #|{ spelling : __SHRT_MAX__, kind: macro definition }
      #|{ spelling : __INT_MAX__, kind: macro definition }
      #|{ spelling : __LONG_MAX__, kind: macro definition }
      #|{ spelling : __LONG_LONG_MAX__, kind: macro definition }
      #|{ spelling : __WCHAR_MAX__, kind: macro definition }
      #|{ spelling : __WCHAR_WIDTH__, kind: macro definition }
      #|{ spelling : __WINT_MAX__, kind: macro definition }
      #|{ spelling : __WINT_WIDTH__, kind: macro definition }
      #|{ spelling : __INTMAX_MAX__, kind: macro definition }
      #|{ spelling : __INTMAX_WIDTH__, kind: macro definition }
      #|{ spelling : __SIZE_MAX__, kind: macro definition }
      #|{ spelling : __SIZE_WIDTH__, kind: macro definition }
      #|{ spelling : __UINTMAX_MAX__, kind: macro definition }
      #|{ spelling : __UINTMAX_WIDTH__, kind: macro definition }
      #|{ spelling : __PTRDIFF_MAX__, kind: macro definition }
      #|{ spelling : __PTRDIFF_WIDTH__, kind: macro definition }
      #|{ spelling : __INTPTR_MAX__, kind: macro definition }
      #|{ spelling : __INTPTR_WIDTH__, kind: macro definition }
      #|{ spelling : __UINTPTR_MAX__, kind: macro definition }
      #|{ spelling : __UINTPTR_WIDTH__, kind: macro definition }
      #|{ spelling : __SIZEOF_DOUBLE__, kind: macro definition }
      #|{ spelling : __SIZEOF_FLOAT__, kind: macro definition }
      #|{ spelling : __SIZEOF_INT__, kind: macro definition }
      #|{ spelling : __SIZEOF_LONG__, kind: macro definition }
      #|{ spelling : __SIZEOF_LONG_DOUBLE__, kind: macro definition }
      #|{ spelling : __SIZEOF_LONG_LONG__, kind: macro definition }
      #|{ spelling : __SIZEOF_POINTER__, kind: macro definition }
      #|{ spelling : __SIZEOF_SHORT__, kind: macro definition }
      #|{ spelling : __SIZEOF_PTRDIFF_T__, kind: macro definition }
      #|{ spelling : __SIZEOF_SIZE_T__, kind: macro definition }
      #|{ spelling : __SIZEOF_WCHAR_T__, kind: macro definition }
      #|{ spelling : __SIZEOF_WINT_T__, kind: macro definition }
      #|{ spelling : __SIZEOF_INT128__, kind: macro definition }
      #|{ spelling : __INTMAX_TYPE__, kind: macro definition }
      #|{ spelling : __INTMAX_FMTd__, kind: macro definition }
      #|{ spelling : __INTMAX_FMTi__, kind: macro definition }
      #|{ spelling : __INTMAX_C_SUFFIX__, kind: macro definition }
      #|{ spelling : __UINTMAX_TYPE__, kind: macro definition }
      #|{ spelling : __UINTMAX_FMTo__, kind: macro definition }
      #|{ spelling : __UINTMAX_FMTu__, kind: macro definition }
      #|{ spelling : __UINTMAX_FMTx__, kind: macro definition }
      #|{ spelling : __UINTMAX_FMTX__, kind: macro definition }
      #|{ spelling : __UINTMAX_C_SUFFIX__, kind: macro definition }
      #|{ spelling : __PTRDIFF_TYPE__, kind: macro definition }
      #|{ spelling : __PTRDIFF_FMTd__, kind: macro definition }
      #|{ spelling : __PTRDIFF_FMTi__, kind: macro definition }
      #|{ spelling : __INTPTR_TYPE__, kind: macro definition }
      #|{ spelling : __INTPTR_FMTd__, kind: macro definition }
      #|{ spelling : __INTPTR_FMTi__, kind: macro definition }
      #|{ spelling : __SIZE_TYPE__, kind: macro definition }
      #|{ spelling : __SIZE_FMTo__, kind: macro definition }
      #|{ spelling : __SIZE_FMTu__, kind: macro definition }
      #|{ spelling : __SIZE_FMTx__, kind: macro definition }
      #|{ spelling : __SIZE_FMTX__, kind: macro definition }
      #|{ spelling : __WCHAR_TYPE__, kind: macro definition }
      #|{ spelling : __WINT_TYPE__, kind: macro definition }
      #|{ spelling : __SIG_ATOMIC_MAX__, kind: macro definition }
      #|{ spelling : __SIG_ATOMIC_WIDTH__, kind: macro definition }
      #|{ spelling : __CHAR16_TYPE__, kind: macro definition }
      #|{ spelling : __CHAR32_TYPE__, kind: macro definition }
      #|{ spelling : __UINTPTR_TYPE__, kind: macro definition }
      #|{ spelling : __UINTPTR_FMTo__, kind: macro definition }
      #|{ spelling : __UINTPTR_FMTu__, kind: macro definition }
      #|{ spelling : __UINTPTR_FMTx__, kind: macro definition }
      #|{ spelling : __UINTPTR_FMTX__, kind: macro definition }
      #|{ spelling : __FLT16_DENORM_MIN__, kind: macro definition }
      #|{ spelling : __FLT16_HAS_DENORM__, kind: macro definition }
      #|{ spelling : __FLT16_DIG__, kind: macro definition }
      #|{ spelling : __FLT16_DECIMAL_DIG__, kind: macro definition }
      #|{ spelling : __FLT16_EPSILON__, kind: macro definition }
      #|{ spelling : __FLT16_HAS_INFINITY__, kind: macro definition }
      #|{ spelling : __FLT16_HAS_QUIET_NAN__, kind: macro definition }
      #|{ spelling : __FLT16_MANT_DIG__, kind: macro definition }
      #|{ spelling : __FLT16_MAX_10_EXP__, kind: macro definition }
      #|{ spelling : __FLT16_MAX_EXP__, kind: macro definition }
      #|{ spelling : __FLT16_MAX__, kind: macro definition }
      #|{ spelling : __FLT16_MIN_10_EXP__, kind: macro definition }
      #|{ spelling : __FLT16_MIN_EXP__, kind: macro definition }
      #|{ spelling : __FLT16_MIN__, kind: macro definition }
      #|{ spelling : __FLT_DENORM_MIN__, kind: macro definition }
      #|{ spelling : __FLT_HAS_DENORM__, kind: macro definition }
      #|{ spelling : __FLT_DIG__, kind: macro definition }
      #|{ spelling : __FLT_DECIMAL_DIG__, kind: macro definition }
      #|{ spelling : __FLT_EPSILON__, kind: macro definition }
      #|{ spelling : __FLT_HAS_INFINITY__, kind: macro definition }
      #|{ spelling : __FLT_HAS_QUIET_NAN__, kind: macro definition }
      #|{ spelling : __FLT_MANT_DIG__, kind: macro definition }
      #|{ spelling : __FLT_MAX_10_EXP__, kind: macro definition }
      #|{ spelling : __FLT_MAX_EXP__, kind: macro definition }
      #|{ spelling : __FLT_MAX__, kind: macro definition }
      #|{ spelling : __FLT_MIN_10_EXP__, kind: macro definition }
      #|{ spelling : __FLT_MIN_EXP__, kind: macro definition }
      #|{ spelling : __FLT_MIN__, kind: macro definition }
      #|{ spelling : __DBL_DENORM_MIN__, kind: macro definition }
      #|{ spelling : __DBL_HAS_DENORM__, kind: macro definition }
      #|{ spelling : __DBL_DIG__, kind: macro definition }
      #|{ spelling : __DBL_DECIMAL_DIG__, kind: macro definition }
      #|{ spelling : __DBL_EPSILON__, kind: macro definition }
      #|{ spelling : __DBL_HAS_INFINITY__, kind: macro definition }
      #|{ spelling : __DBL_HAS_QUIET_NAN__, kind: macro definition }
      #|{ spelling : __DBL_MANT_DIG__, kind: macro definition }
      #|{ spelling : __DBL_MAX_10_EXP__, kind: macro definition }
      #|{ spelling : __DBL_MAX_EXP__, kind: macro definition }
      #|{ spelling : __DBL_MAX__, kind: macro definition }
      #|{ spelling : __DBL_MIN_10_EXP__, kind: macro definition }
      #|{ spelling : __DBL_MIN_EXP__, kind: macro definition }
      #|{ spelling : __DBL_MIN__, kind: macro definition }
      #|{ spelling : __LDBL_DENORM_MIN__, kind: macro definition }
      #|{ spelling : __LDBL_HAS_DENORM__, kind: macro definition }
      #|{ spelling : __LDBL_DIG__, kind: macro definition }
      #|{ spelling : __LDBL_DECIMAL_DIG__, kind: macro definition }
      #|{ spelling : __LDBL_EPSILON__, kind: macro definition }
      #|{ spelling : __LDBL_HAS_INFINITY__, kind: macro definition }
      #|{ spelling : __LDBL_HAS_QUIET_NAN__, kind: macro definition }
      #|{ spelling : __LDBL_MANT_DIG__, kind: macro definition }
      #|{ spelling : __LDBL_MAX_10_EXP__, kind: macro definition }
      #|{ spelling : __LDBL_MAX_EXP__, kind: macro definition }
      #|{ spelling : __LDBL_MAX__, kind: macro definition }
      #|{ spelling : __LDBL_MIN_10_EXP__, kind: macro definition }
      #|{ spelling : __LDBL_MIN_EXP__, kind: macro definition }
      #|{ spelling : __LDBL_MIN__, kind: macro definition }
      #|{ spelling : __POINTER_WIDTH__, kind: macro definition }
      #|{ spelling : __BIGGEST_ALIGNMENT__, kind: macro definition }
      #|{ spelling : __WINT_UNSIGNED__, kind: macro definition }
      #|{ spelling : __INT8_TYPE__, kind: macro definition }
      #|{ spelling : __INT8_FMTd__, kind: macro definition }
      #|{ spelling : __INT8_FMTi__, kind: macro definition }
      #|{ spelling : __INT8_C_SUFFIX__, kind: macro definition }
      #|{ spelling : __INT16_TYPE__, kind: macro definition }
      #|{ spelling : __INT16_FMTd__, kind: macro definition }
      #|{ spelling : __INT16_FMTi__, kind: macro definition }
      #|{ spelling : __INT16_C_SUFFIX__, kind: macro definition }
      #|{ spelling : __INT32_TYPE__, kind: macro definition }
      #|{ spelling : __INT32_FMTd__, kind: macro definition }
      #|{ spelling : __INT32_FMTi__, kind: macro definition }
      #|{ spelling : __INT32_C_SUFFIX__, kind: macro definition }
      #|{ spelling : __INT64_TYPE__, kind: macro definition }
      #|{ spelling : __INT64_FMTd__, kind: macro definition }
      #|{ spelling : __INT64_FMTi__, kind: macro definition }
      #|{ spelling : __INT64_C_SUFFIX__, kind: macro definition }
      #|{ spelling : __UINT8_TYPE__, kind: macro definition }
      #|{ spelling : __UINT8_FMTo__, kind: macro definition }
      #|{ spelling : __UINT8_FMTu__, kind: macro definition }
      #|{ spelling : __UINT8_FMTx__, kind: macro definition }
      #|{ spelling : __UINT8_FMTX__, kind: macro definition }
      #|{ spelling : __UINT8_C_SUFFIX__, kind: macro definition }
      #|{ spelling : __UINT8_MAX__, kind: macro definition }
      #|{ spelling : __INT8_MAX__, kind: macro definition }
      #|{ spelling : __UINT16_TYPE__, kind: macro definition }
      #|{ spelling : __UINT16_FMTo__, kind: macro definition }
      #|{ spelling : __UINT16_FMTu__, kind: macro definition }
      #|{ spelling : __UINT16_FMTx__, kind: macro definition }
      #|{ spelling : __UINT16_FMTX__, kind: macro definition }
      #|{ spelling : __UINT16_C_SUFFIX__, kind: macro definition }
      #|{ spelling : __UINT16_MAX__, kind: macro definition }
      #|{ spelling : __INT16_MAX__, kind: macro definition }
      #|{ spelling : __UINT32_TYPE__, kind: macro definition }
      #|{ spelling : __UINT32_FMTo__, kind: macro definition }
      #|{ spelling : __UINT32_FMTu__, kind: macro definition }
      #|{ spelling : __UINT32_FMTx__, kind: macro definition }
      #|{ spelling : __UINT32_FMTX__, kind: macro definition }
      #|{ spelling : __UINT32_C_SUFFIX__, kind: macro definition }
      #|{ spelling : __UINT32_MAX__, kind: macro definition }
      #|{ spelling : __INT32_MAX__, kind: macro definition }
      #|{ spelling : __UINT64_TYPE__, kind: macro definition }
      #|{ spelling : __UINT64_FMTo__, kind: macro definition }
      #|{ spelling : __UINT64_FMTu__, kind: macro definition }
      #|{ spelling : __UINT64_FMTx__, kind: macro definition }
      #|{ spelling : __UINT64_FMTX__, kind: macro definition }
      #|{ spelling : __UINT64_C_SUFFIX__, kind: macro definition }
      #|{ spelling : __UINT64_MAX__, kind: macro definition }
      #|{ spelling : __INT64_MAX__, kind: macro definition }
      #|{ spelling : __INT_LEAST8_TYPE__, kind: macro definition }
      #|{ spelling : __INT_LEAST8_MAX__, kind: macro definition }
      #|{ spelling : __INT_LEAST8_WIDTH__, kind: macro definition }
      #|{ spelling : __INT_LEAST8_FMTd__, kind: macro definition }
      #|{ spelling : __INT_LEAST8_FMTi__, kind: macro definition }
      #|{ spelling : __UINT_LEAST8_TYPE__, kind: macro definition }
      #|{ spelling : __UINT_LEAST8_MAX__, kind: macro definition }
      #|{ spelling : __UINT_LEAST8_FMTo__, kind: macro definition }
      #|{ spelling : __UINT_LEAST8_FMTu__, kind: macro definition }
      #|{ spelling : __UINT_LEAST8_FMTx__, kind: macro definition }
      #|{ spelling : __UINT_LEAST8_FMTX__, kind: macro definition }
      #|{ spelling : __INT_LEAST16_TYPE__, kind: macro definition }
      #|{ spelling : __INT_LEAST16_MAX__, kind: macro definition }
      #|{ spelling : __INT_LEAST16_WIDTH__, kind: macro definition }
      #|{ spelling : __INT_LEAST16_FMTd__, kind: macro definition }
      #|{ spelling : __INT_LEAST16_FMTi__, kind: macro definition }
      #|{ spelling : __UINT_LEAST16_TYPE__, kind: macro definition }
      #|{ spelling : __UINT_LEAST16_MAX__, kind: macro definition }
      #|{ spelling : __UINT_LEAST16_FMTo__, kind: macro definition }
      #|{ spelling : __UINT_LEAST16_FMTu__, kind: macro definition }
      #|{ spelling : __UINT_LEAST16_FMTx__, kind: macro definition }
      #|{ spelling : __UINT_LEAST16_FMTX__, kind: macro definition }
      #|{ spelling : __INT_LEAST32_TYPE__, kind: macro definition }
      #|{ spelling : __INT_LEAST32_MAX__, kind: macro definition }
      #|{ spelling : __INT_LEAST32_WIDTH__, kind: macro definition }
      #|{ spelling : __INT_LEAST32_FMTd__, kind: macro definition }
      #|{ spelling : __INT_LEAST32_FMTi__, kind: macro definition }
      #|{ spelling : __UINT_LEAST32_TYPE__, kind: macro definition }
      #|{ spelling : __UINT_LEAST32_MAX__, kind: macro definition }
      #|{ spelling : __UINT_LEAST32_FMTo__, kind: macro definition }
      #|{ spelling : __UINT_LEAST32_FMTu__, kind: macro definition }
      #|{ spelling : __UINT_LEAST32_FMTx__, kind: macro definition }
      #|{ spelling : __UINT_LEAST32_FMTX__, kind: macro definition }
      #|{ spelling : __INT_LEAST64_TYPE__, kind: macro definition }
      #|{ spelling : __INT_LEAST64_MAX__, kind: macro definition }
      #|{ spelling : __INT_LEAST64_WIDTH__, kind: macro definition }
      #|{ spelling : __INT_LEAST64_FMTd__, kind: macro definition }
      #|{ spelling : __INT_LEAST64_FMTi__, kind: macro definition }
      #|{ spelling : __UINT_LEAST64_TYPE__, kind: macro definition }
      #|{ spelling : __UINT_LEAST64_MAX__, kind: macro definition }
      #|{ spelling : __UINT_LEAST64_FMTo__, kind: macro definition }
      #|{ spelling : __UINT_LEAST64_FMTu__, kind: macro definition }
      #|{ spelling : __UINT_LEAST64_FMTx__, kind: macro definition }
      #|{ spelling : __UINT_LEAST64_FMTX__, kind: macro definition }
      #|{ spelling : __INT_FAST8_TYPE__, kind: macro definition }
      #|{ spelling : __INT_FAST8_MAX__, kind: macro definition }
      #|{ spelling : __INT_FAST8_WIDTH__, kind: macro definition }
      #|{ spelling : __INT_FAST8_FMTd__, kind: macro definition }
      #|{ spelling : __INT_FAST8_FMTi__, kind: macro definition }
      #|{ spelling : __UINT_FAST8_TYPE__, kind: macro definition }
      #|{ spelling : __UINT_FAST8_MAX__, kind: macro definition }
      #|{ spelling : __UINT_FAST8_FMTo__, kind: macro definition }
      #|{ spelling : __UINT_FAST8_FMTu__, kind: macro definition }
      #|{ spelling : __UINT_FAST8_FMTx__, kind: macro definition }
      #|{ spelling : __UINT_FAST8_FMTX__, kind: macro definition }
      #|{ spelling : __INT_FAST16_TYPE__, kind: macro definition }
      #|{ spelling : __INT_FAST16_MAX__, kind: macro definition }
      #|{ spelling : __INT_FAST16_WIDTH__, kind: macro definition }
      #|{ spelling : __INT_FAST16_FMTd__, kind: macro definition }
      #|{ spelling : __INT_FAST16_FMTi__, kind: macro definition }
      #|{ spelling : __UINT_FAST16_TYPE__, kind: macro definition }
      #|{ spelling : __UINT_FAST16_MAX__, kind: macro definition }
      #|{ spelling : __UINT_FAST16_FMTo__, kind: macro definition }
      #|{ spelling : __UINT_FAST16_FMTu__, kind: macro definition }
      #|{ spelling : __UINT_FAST16_FMTx__, kind: macro definition }
      #|{ spelling : __UINT_FAST16_FMTX__, kind: macro definition }
      #|{ spelling : __INT_FAST32_TYPE__, kind: macro definition }
      #|{ spelling : __INT_FAST32_MAX__, kind: macro definition }
      #|{ spelling : __INT_FAST32_WIDTH__, kind: macro definition }
      #|{ spelling : __INT_FAST32_FMTd__, kind: macro definition }
      #|{ spelling : __INT_FAST32_FMTi__, kind: macro definition }
      #|{ spelling : __UINT_FAST32_TYPE__, kind: macro definition }
      #|{ spelling : __UINT_FAST32_MAX__, kind: macro definition }
      #|{ spelling : __UINT_FAST32_FMTo__, kind: macro definition }
      #|{ spelling : __UINT_FAST32_FMTu__, kind: macro definition }
      #|{ spelling : __UINT_FAST32_FMTx__, kind: macro definition }
      #|{ spelling : __UINT_FAST32_FMTX__, kind: macro definition }
      #|{ spelling : __INT_FAST64_TYPE__, kind: macro definition }
      #|{ spelling : __INT_FAST64_MAX__, kind: macro definition }
      #|{ spelling : __INT_FAST64_WIDTH__, kind: macro definition }
      #|{ spelling : __INT_FAST64_FMTd__, kind: macro definition }
      #|{ spelling : __INT_FAST64_FMTi__, kind: macro definition }
      #|{ spelling : __UINT_FAST64_TYPE__, kind: macro definition }
      #|{ spelling : __UINT_FAST64_MAX__, kind: macro definition }
      #|{ spelling : __UINT_FAST64_FMTo__, kind: macro definition }
      #|{ spelling : __UINT_FAST64_FMTu__, kind: macro definition }
      #|{ spelling : __UINT_FAST64_FMTx__, kind: macro definition }
      #|{ spelling : __UINT_FAST64_FMTX__, kind: macro definition }
      #|{ spelling : __USER_LABEL_PREFIX__, kind: macro definition }
      #|{ spelling : __FINITE_MATH_ONLY__, kind: macro definition }
      #|{ spelling : __GNUC_STDC_INLINE__, kind: macro definition }
      #|{ spelling : __GCC_ATOMIC_TEST_AND_SET_TRUEVAL, kind: macro definition }
      #|{ spelling : __CLANG_ATOMIC_BOOL_LOCK_FREE, kind: macro definition }
      #|{ spelling : __CLANG_ATOMIC_CHAR_LOCK_FREE, kind: macro definition }
      #|{ spelling : __CLANG_ATOMIC_CHAR16_T_LOCK_FREE, kind: macro definition }
      #|{ spelling : __CLANG_ATOMIC_CHAR32_T_LOCK_FREE, kind: macro definition }
      #|{ spelling : __CLANG_ATOMIC_WCHAR_T_LOCK_FREE, kind: macro definition }
      #|{ spelling : __CLANG_ATOMIC_SHORT_LOCK_FREE, kind: macro definition }
      #|{ spelling : __CLANG_ATOMIC_INT_LOCK_FREE, kind: macro definition }
      #|{ spelling : __CLANG_ATOMIC_LONG_LOCK_FREE, kind: macro definition }
      #|{ spelling : __CLANG_ATOMIC_LLONG_LOCK_FREE, kind: macro definition }
      #|{ spelling : __CLANG_ATOMIC_POINTER_LOCK_FREE, kind: macro definition }
      #|{ spelling : __GCC_ATOMIC_BOOL_LOCK_FREE, kind: macro definition }
      #|{ spelling : __GCC_ATOMIC_CHAR_LOCK_FREE, kind: macro definition }
      #|{ spelling : __GCC_ATOMIC_CHAR16_T_LOCK_FREE, kind: macro definition }
      #|{ spelling : __GCC_ATOMIC_CHAR32_T_LOCK_FREE, kind: macro definition }
      #|{ spelling : __GCC_ATOMIC_WCHAR_T_LOCK_FREE, kind: macro definition }
      #|{ spelling : __GCC_ATOMIC_SHORT_LOCK_FREE, kind: macro definition }
      #|{ spelling : __GCC_ATOMIC_INT_LOCK_FREE, kind: macro definition }
      #|{ spelling : __GCC_ATOMIC_LONG_LOCK_FREE, kind: macro definition }
      #|{ spelling : __GCC_ATOMIC_LLONG_LOCK_FREE, kind: macro definition }
      #|{ spelling : __GCC_ATOMIC_POINTER_LOCK_FREE, kind: macro definition }
      #|{ spelling : __NO_INLINE__, kind: macro definition }
      #|{ spelling : __PIC__, kind: macro definition }
      #|{ spelling : __pic__, kind: macro definition }
      #|{ spelling : __PIE__, kind: macro definition }
      #|{ spelling : __pie__, kind: macro definition }
      #|{ spelling : __FLT_RADIX__, kind: macro definition }
      #|{ spelling : __DECIMAL_DIG__, kind: macro definition }
      #|{ spelling : __ELF__, kind: macro definition }
      #|{ spelling : __GCC_ASM_FLAG_OUTPUTS__, kind: macro definition }
      #|{ spelling : __code_model_small__, kind: macro definition }
      #|{ spelling : __amd64__, kind: macro definition }
      #|{ spelling : __amd64, kind: macro definition }
      #|{ spelling : __x86_64, kind: macro definition }
      #|{ spelling : __x86_64__, kind: macro definition }
      #|{ spelling : __SEG_GS, kind: macro definition }
      #|{ spelling : __SEG_FS, kind: macro definition }
      #|{ spelling : __seg_gs, kind: macro definition }
      #|{ spelling : __seg_fs, kind: macro definition }
      #|{ spelling : __k8, kind: macro definition }
      #|{ spelling : __k8__, kind: macro definition }
      #|{ spelling : __tune_k8__, kind: macro definition }
      #|{ spelling : __REGISTER_PREFIX__, kind: macro definition }
      #|{ spelling : __NO_MATH_INLINES, kind: macro definition }
      #|{ spelling : __FXSR__, kind: macro definition }
      #|{ spelling : __SSE2__, kind: macro definition }
      #|{ spelling : __SSE2_MATH__, kind: macro definition }
      #|{ spelling : __SSE__, kind: macro definition }
      #|{ spelling : __SSE_MATH__, kind: macro definition }
      #|{ spelling : __MMX__, kind: macro definition }
      #|{ spelling : __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1, kind: macro definition }
      #|{ spelling : __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2, kind: macro definition }
      #|{ spelling : __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4, kind: macro definition }
      #|{ spelling : __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8, kind: macro definition }
      #|{ spelling : __SIZEOF_FLOAT128__, kind: macro definition }
      #|{ spelling : unix, kind: macro definition }
      #|{ spelling : __unix, kind: macro definition }
      #|{ spelling : __unix__, kind: macro definition }
      #|{ spelling : linux, kind: macro definition }
      #|{ spelling : __linux, kind: macro definition }
      #|{ spelling : __linux__, kind: macro definition }
      #|{ spelling : __gnu_linux__, kind: macro definition }
      #|{ spelling : __FLOAT128__, kind: macro definition }
      #|{ spelling : __STDC__, kind: macro definition }
      #|{ spelling : __STDC_HOSTED__, kind: macro definition }
      #|{ spelling : __STDC_VERSION__, kind: macro definition }
      #|{ spelling : __STDC_UTF_16__, kind: macro definition }
      #|{ spelling : __STDC_UTF_32__, kind: macro definition }
      #|{ spelling : __GCC_HAVE_DWARF2_CFI_ASM, kind: macro definition }
      #|{ spelling : id, kind: macro definition }
      #|{ spelling : A, kind: StructDecl }
      #|{ spelling : foo, kind: FunctionDecl }
      #|{ spelling : happy, kind: TypedefDecl }
    ),
  )
}
