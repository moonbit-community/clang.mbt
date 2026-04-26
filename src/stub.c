#include <clang-c/Index.h>
#include <moonbit.h>
#include <string.h>

// naming convention
//
// struct fields
//
// start with 'cx' is clang-c object, use clang_dispose_xxxx to destroy object.
// start with 'm' is moonbit object, use moonbit_decref to destroy object.

#pragma region Moonbit Type
// WARNING: hack moonbit native FFI type

typedef moonbit_bytes_t *FixedArray_Bytes;
typedef moonbit_bytes_t Bytes;
typedef int32_t Bool;
#define True 1
#define False 0

#define IterEnd 0
#define IterContinue 1

typedef int32_t IterResult;

#pragma endregion

#pragma region Payload

typedef struct Index_payload {
  CXIndex cxidx;
} *Index;

typedef struct TranslationUnit_payload {
  CXTranslationUnit cxtu;
  Index midx; // moonbit rc sharing
} *TranslationUnit;

typedef struct Cursor_payload {
  TranslationUnit tu;
  CXCursor cxcrs;
} *Cursor;

typedef struct Type_payload {
  CXType cxty;
  TranslationUnit tu;
} *Type;

typedef struct Token_payload {
  CXToken cxtok;
  TranslationUnit tu;
} *Token;

typedef struct TargetInfo_payload {
  TranslationUnit tu;
  CXTargetInfo cxti;
} *TargetInfo;

typedef struct SourceLocation_payload {
  TranslationUnit tu;
  CXSourceLocation cxsl;
} *SourceLocation;

typedef struct SourceRange_payload {
  TranslationUnit tu;
  CXSourceRange cxsr;
} *SourceRange;

#pragma endregion

typedef Token *FixedArray_Token;

typedef int32_t ErrorCode;

typedef struct Cursor_IterResult_closure_payload {
  IterResult (*code)(struct Cursor_IterResult_closure_payload *context, Cursor);
  char free_variables[];
  // https://en.wikipedia.org/wiki/Flexible_array_member
} *Cursor_IterResult_closure;
struct VisitChildrenWrapperContext {
  Cursor_IterResult_closure clo; // borrow
  TranslationUnit tu;            // borrow
};

#pragma region Enums
typedef int32_t CallingConv;
typedef int32_t CursorKind;
typedef int32_t TypeKind;
typedef int32_t LanguageKind;
typedef int32_t LinkageKind;
typedef int32_t VisibilityKind;
typedef int32_t AvailabilityKind;
typedef int32_t CXX_AccessSpecifier;
typedef int32_t StorageClass;
#pragma endregion

#pragma region finalizer
void illusory0x0_clang_Index_finalize(void *_self) {
  Index self = _self;
  clang_disposeIndex(self->cxidx);
}
void illusory0x0_clang_TranslationUnit_finalize(void *_self) {
  TranslationUnit self = _self;
  clang_disposeTranslationUnit(self->cxtu);
  moonbit_decref(self->midx);
}

void illusory0x0_clang_Token_finalize(void *_self) {
  Token self = _self;
  if (self->tu) {
    moonbit_decref(self->tu); // last used
  }
}

void illusory0x0_clang_TargetInfo_finalize(void *_self) {
  TargetInfo self = _self;
  clang_TargetInfo_dispose(self->cxti);
  if (self->tu) {
    moonbit_decref(self->tu); // last used
  }
}

void illusory0x0_clang_Cursor_finalize(void *_self) {
  Cursor self = _self;
  if (self->tu) {
    moonbit_decref(self->tu);
  }
}

void illusory0x0_clang_Type_finalize(void *_self) {
  Type self = _self;
  if (self->tu) {
    moonbit_decref(self->tu);
  }
}

void illusory0x0_clang_SourceLocation_finalize(void *_self) {
  SourceLocation self = _self;
  if (self->tu) {
    moonbit_decref(self->tu);
  }
}

void illusory0x0_clang_SourceRange_finalize(void *_self) {
  SourceRange self = _self;
  if (self->tu) {
    moonbit_decref(self->tu);
  }
}
#pragma endregion

#pragma region callee owned calling convention
// callee owned calling convention
//
// Dont't `decref` object(contains `TranslationUnit`) before call this function
Token illusory0x0_clang_CXToken_to_Token(TranslationUnit self, CXToken cxtok) {
  Token res = moonbit_make_external_object(illusory0x0_clang_Token_finalize,
                                           sizeof(struct Token_payload));
  res->tu = self;
  res->cxtok = cxtok;
  return res;
}

// callee owned calling convention
//
// Dont't `decref` object(contains `TranslationUnit`) before call this function
Cursor illusory0x0_clang_CXCursor_to_Cursor(TranslationUnit self,
                                            CXCursor cxcrs) {
  Cursor res = moonbit_make_external_object(illusory0x0_clang_Cursor_finalize,
                                            sizeof(struct Cursor_payload));
  res->tu = self; // store
  res->cxcrs = cxcrs;
  return res;
}

// callee owned calling convention
//
// Dont't `decref` object(contains `TranslationUnit`) before call this function
//
// https://github.com/llvm/llvm-project/issues/138881
Bytes illusory0x0_clang_CXString_to_moonbit_Bytes(CXString self) {
  const char *cs = clang_getCString(self);
  int len = strlen(cs);
  Bytes res = moonbit_make_bytes(len, 0);
  memcpy(res, cs, len);
  clang_disposeString(self);
  return res;
}

// callee owned calling convention
//
// Dont't `decref` object(contains `TranslationUnit`) before call this function
Type illusory0x0_clang_CXType_to_Type(TranslationUnit self, CXType cxty) {
  Type res = moonbit_make_external_object(illusory0x0_clang_Type_finalize,
                                          sizeof(struct Type_payload));
  res->tu = self; // store
  res->cxty = cxty;
  return res;
}

// callee owned calling convention
//
// Dont't `decref` object(contains `TranslationUnit`) before call this function
SourceLocation
illusory0x0_clang_CXSourceLocation_to_SourceLocation(TranslationUnit self,
                                                     CXSourceLocation cxsl) {
  SourceLocation res =
      moonbit_make_external_object(illusory0x0_clang_SourceLocation_finalize,
                                   sizeof(struct SourceLocation_payload));
  res->tu = self; // store
  res->cxsl = cxsl;
  return res;
}

// callee owned calling convention
//
// Dont't `decref` object(contains `TranslationUnit`) before call this function
SourceRange illusory0x0_clang_CXSourceRange_to_SourceRange(TranslationUnit self,
                                                           CXSourceRange cxsl) {
  SourceRange res =
      moonbit_make_external_object(illusory0x0_clang_SourceLocation_finalize,
                                   sizeof(struct SourceRange_payload));
  res->tu = self; // store
  res->cxsr = cxsl;
  return res;
}

#pragma endregion

Index illusory0x0_clang_Index_new(Bool excludeDeclarationsFromPCH,
                                  Bool displayDiagnostics) {
  Index self = moonbit_make_external_object(illusory0x0_clang_Index_finalize,
                                            sizeof(struct Index_payload));
  self->cxidx =
      clang_createIndex(excludeDeclarationsFromPCH, displayDiagnostics);
  return self;
}

TranslationUnit

illusory0x0_clang_Index_parse(Index self, Bytes source_filename,
                              FixedArray_Bytes command_line_args,
                              int32_t option, ErrorCode *out_ec) {
  TranslationUnit res =
      moonbit_make_external_object(illusory0x0_clang_TranslationUnit_finalize,
                                   sizeof(struct TranslationUnit_payload));
  res->midx = self; // store

  *out_ec = clang_parseTranslationUnit2(
      self->cxidx, (void *)source_filename, (void *)command_line_args,
      Moonbit_array_length(command_line_args), NULL, 0, option, &res->cxtu);
  moonbit_decref(source_filename);   // last used
  moonbit_decref(command_line_args); // last used
  return res;
}

Cursor illusory0x0_clang_TranslationUnit_cursor(TranslationUnit self) {
  CXCursor cxcrs = clang_getTranslationUnitCursor(self->cxtu);
  return illusory0x0_clang_CXCursor_to_Cursor(self, cxcrs);
}

CursorKind illusory0x0_clang_Cursor_kind(Cursor self) {
  enum CXCursorKind res = self->cxcrs.kind;
  moonbit_decref(self); // last used;
  return res;
}

Bytes illusory0x0_clang_Cursor_spelling(Cursor self) {
  CXString s = clang_getCursorSpelling(self->cxcrs);
  Bytes res = illusory0x0_clang_CXString_to_moonbit_Bytes(s);
  moonbit_decref(self);
  return res;
}

Bytes illusory0x0_clang_Cursor_display_name(Cursor self) {
  CXString s = clang_getCursorDisplayName(self->cxcrs);
  Bytes res = illusory0x0_clang_CXString_to_moonbit_Bytes(s);
  moonbit_decref(self);
  return res;
}

// don't directly return res, although abi is compatible
enum CXChildVisitResult IterResult_to_CXChildVisitResult(IterResult ir) {
  if (ir == IterContinue) {
    return CXChildVisit_Continue;
  } else {
    return CXChildVisit_Break;
  }
}

enum CXChildVisitResult
illusory0x0_clang_Cursor_visit_children_f_wrapper(CXCursor _child,
                                                  CXCursor _, // ignore parent
                                                  CXClientData client_data) {
  struct VisitChildrenWrapperContext *ctx = client_data;
  moonbit_incref(ctx->tu); // passing
  Cursor child = illusory0x0_clang_CXCursor_to_Cursor(ctx->tu, _child);
  Cursor_IterResult_closure clo = ctx->clo;

  moonbit_incref(clo); // before calling closure
  IterResult res = clo->code(clo, child);
  return IterResult_to_CXChildVisitResult(res);
}

IterResult
illusory0x0_clang_Cursor_visit_children(Cursor self,
                                        Cursor_IterResult_closure f) {

  struct VisitChildrenWrapperContext ctx = {.tu = self->tu, .clo = f};

  int32_t res = clang_visitChildren(
      self->cxcrs, illusory0x0_clang_Cursor_visit_children_f_wrapper, &ctx);

  moonbit_decref(self); // last used
  moonbit_decref(f);    // lasst used
  if (res == 0) {
    return IterContinue;
  } else {
    return IterEnd;
  }
  return IterEnd;
}

Type illusory0x0_clang_Cursor_type_(Cursor self) {
  moonbit_incref(self->tu); // passing
  Type res = illusory0x0_clang_CXType_to_Type(self->tu,
                                              clang_getCursorType(self->cxcrs));
  moonbit_decref(self); // last used
  return res;
}

Type illusory0x0_clang_Cursor_typedef_decl_underlying_type(Cursor self) {
  moonbit_incref(self->tu); // passing
  Type res = illusory0x0_clang_CXType_to_Type(
      self->tu, clang_getTypedefDeclUnderlyingType(self->cxcrs));
  moonbit_decref(self); // last used
  return res;
}

Type illusory0x0_clang_Cursor_enum_decl_integer_type(Cursor self) {
  moonbit_incref(self->tu); // passing
  Type res = illusory0x0_clang_CXType_to_Type(
      self->tu, clang_getEnumDeclIntegerType(self->cxcrs));
  moonbit_decref(self); // last used
  return res;
}

int64_t illusory0x0_clang_Cursor_enum_constant_decl_value(Cursor self) {
  int64_t res = clang_getEnumConstantDeclValue(self->cxcrs);
  moonbit_decref(self); // last used
  return res;
}

uint64_t
illusory0x0_clang_Cursor_enum_constant_decl_unsigned_value(Cursor self) {
  uint64_t res = clang_getEnumConstantDeclUnsignedValue(self->cxcrs);
  moonbit_decref(self); // last used
  return res;
}

Bytes illusory0x0_clang_Type_spelling(Type self) {
  CXString cxstr = clang_getTypeSpelling(self->cxty);
  moonbit_decref(self); // last used
  Bytes res = illusory0x0_clang_CXString_to_moonbit_Bytes(cxstr);
  return res;
}

TypeKind illusory0x0_clang_Type_kind(Type self) {
  enum CXTypeKind res = self->cxty.kind;
  moonbit_decref(self); // last used
  return res;
}

Bytes illusory0x0_clang_Type_kind_spelling(TypeKind self) {
  CXString cxs = clang_getTypeKindSpelling(self);
  Bytes res = illusory0x0_clang_CXString_to_moonbit_Bytes(cxs);
  return res;
}

Bytes illusory0x0_clang_Cursor_kind_spelling(CursorKind self) {
  CXString cxs = clang_getCursorKindSpelling(self);
  Bytes res = illusory0x0_clang_CXString_to_moonbit_Bytes(cxs);
  return res;
}

TargetInfo illusory0x0_clang_TranslationUnit_target_info(TranslationUnit self) {
  TargetInfo res = moonbit_make_external_object(
      illusory0x0_clang_TargetInfo_finalize, sizeof(struct TargetInfo_payload));
  res->tu = self; // store
  res->cxti = clang_getTranslationUnitTargetInfo(self->cxtu);
  return res;
}

Bytes illsuory0x0_clang_TargetInfo_triple(TargetInfo self) {
  CXString cxs = clang_TargetInfo_getTriple(self->cxti);
  moonbit_decref(self); // last used
  Bytes res = illusory0x0_clang_CXString_to_moonbit_Bytes(cxs);
  return res;
}

int32_t illusory0x0_clang_TargetInfo_pointer_width(TargetInfo self) {
  int32_t res = clang_TargetInfo_getPointerWidth(self->cxti);
  moonbit_decref(self); // last used
  return res;
}

LanguageKind illusory0x0_clang_Cursor_language(Cursor self) {
  LanguageKind res = clang_getCursorLanguage(self->cxcrs);
  moonbit_decref(self); // last used
  return res;
}

Cursor illusory0x0_clang_Cursor_semantic_parent(Cursor self) {

  CXCursor cxcrs = clang_getCursorSemanticParent(self->cxcrs);
  moonbit_incref(self->tu); // passing
  Cursor res = illusory0x0_clang_CXCursor_to_Cursor(self->tu, cxcrs);
  moonbit_decref(self); // last used
  return res;
}

Cursor illusory0x0_clang_Cursor_lexical_parent(Cursor self) {
  CXCursor cxcrs = clang_getCursorLexicalParent(self->cxcrs);
  moonbit_incref(self->tu); // passing
  Cursor res = illusory0x0_clang_CXCursor_to_Cursor(self->tu, cxcrs);
  moonbit_decref(self); // last used
  return res;
}

Cursor illusory0x0_clang_Cursor_null() {
  return illusory0x0_clang_CXCursor_to_Cursor(NULL, clang_getNullCursor());
}

Bool illusory0x0_int_to_Bool(int32_t val) {
  if (val == 0) {
    return False;
  } else {
    return True;
  }
}

Bool illusory0x0_clang_Cursor_is_null(Cursor self) {
  int32_t res = clang_Cursor_isNull(self->cxcrs);
  moonbit_decref(self); // last used
  return illusory0x0_int_to_Bool(res);
}

LinkageKind illusory0x0_clang_Cursor_linkage(Cursor self) {
  enum CXLinkageKind res = clang_getCursorLinkage(self->cxcrs);
  moonbit_decref(self); // last used
  return res;
}

VisibilityKind illusory0x0_clang_Cursor_visibility(Cursor self) {
  enum CXVisibilityKind res = clang_getCursorVisibility(self->cxcrs);
  moonbit_decref(self); // last used
  return res;
}

AvailabilityKind illusory0x0_clang_Cursor_availability(Cursor self) {
  enum CXAvailabilityKind res = clang_getCursorAvailability(self->cxcrs);
  moonbit_decref(self); // last used
  return res;
}

Type illsuory0x0_clang_Type_canonical(Type self) {
  moonbit_incref(self->tu); // passing
  Type res = illusory0x0_clang_CXType_to_Type(
      self->tu, clang_getCanonicalType(self->cxty));

  moonbit_decref(self); // last used
  return res;
}
Bool illusory0x0_clang_Type_is_const_qualified(Type self) {
  int32_t res = clang_isConstQualifiedType(self->cxty);
  moonbit_decref(self); // last used
  return illusory0x0_int_to_Bool(res);
}

Cursor illsuory0x0_clang_Cursor_canonical(Cursor self) {
  moonbit_incref(self->tu); // passing
  Cursor res = illusory0x0_clang_CXCursor_to_Cursor(
      self->tu, clang_getCanonicalCursor(self->cxcrs));

  moonbit_decref(self); // last used
  return res;
}

Bool illusory0x0_clang_Cursor_is_macro_function_like(Cursor self) {
  int32_t res = clang_Cursor_isMacroFunctionLike(self->cxcrs);
  moonbit_decref(self); // last used
  return illusory0x0_int_to_Bool(res);
}

Bool illusory0x0_clang_Cursor_is_macro_builtin(Cursor self) {
  int32_t res = clang_Cursor_isMacroBuiltin(self->cxcrs);
  moonbit_decref(self); // last used
  return illusory0x0_int_to_Bool(res);
}

Bool illusory0x0_clang_Cursor_is_function_inlined(Cursor self) {
  int32_t res = clang_Cursor_isFunctionInlined(self->cxcrs);
  moonbit_decref(self); // last used
  return illusory0x0_int_to_Bool(res);
}

Bool illusory0x0_clang_Type_is_volatile_qualified(Type self) {
  int32_t res = clang_isVolatileQualifiedType(self->cxty);
  moonbit_decref(self); // last used
  return illusory0x0_int_to_Bool(res);
}

Bool illusory0x0_clang_Type_is_restrict_qualified(Type self) {
  int32_t res = clang_isRestrictQualifiedType(self->cxty);
  moonbit_decref(self); // last used
  return illusory0x0_int_to_Bool(res);
}

int32_t illusory0x0_clang_Type_address_space(Type self) {
  int32_t res = clang_getAddressSpace(self->cxty);
  moonbit_decref(self); // last used
  return illusory0x0_int_to_Bool(res);
}

Bytes illusory0x0_Type_typedef_name(Type self) {
  CXString cxs = clang_getTypedefName(self->cxty);
  moonbit_decref((self)); // last used;

  Bytes res = illusory0x0_clang_CXString_to_moonbit_Bytes(cxs);
  return res;
}

Type illusory0x0_clang_Type_pointee(Type self) {
  moonbit_incref(self->tu); // passing
  Type res = illusory0x0_clang_CXType_to_Type(self->tu,
                                              clang_getPointeeType(self->cxty));
  moonbit_decref(self); // last used;
  return res;
}

Type illusory0x0_clang_Type_unqualified(Type self) {
  moonbit_incref(self->tu); // passing
  Type res = illusory0x0_clang_CXType_to_Type(
      self->tu, clang_getUnqualifiedType(self->cxty));
  moonbit_decref(self); // last used;
  return res;
}

CallingConv illusory0x0_clang_Type_calling_conv(Type self) {
  int32_t res = clang_getFunctionTypeCallingConv(self->cxty);
  moonbit_decref(self); // last used;
  return res;
}

int32_t illusory0x0_clang_Type_arity(Type self) {
  int32_t res = clang_getNumArgTypes(self->cxty);
  moonbit_decref(self); // last used
  return res;
}

Type illusory0x0_clang_Type_argument(Type self, int32_t i) {
  moonbit_incref(self->tu); // passing
  Type res = illusory0x0_clang_CXType_to_Type(self->tu,
                                              clang_getArgType(self->cxty, i));
  moonbit_decref(self); // last used
  return res;
}

Type illusory0x0_clang_Type_result(Type self) {
  moonbit_incref(self->tu); // passing
  Type res = illusory0x0_clang_CXType_to_Type(self->tu,
                                              clang_getResultType(self->cxty));
  moonbit_decref(self); // last used
  return res;
}

int64_t illusory0x0_clang_Type_sizeof(Type self) {
  int64_t res = clang_Type_getSizeOf(self->cxty);
  moonbit_decref(self); // last used
  return res;
}

int64_t illusory0x0_clang_Type_offsetof(Type self, Bytes member) {
  int64_t res = clang_Type_getOffsetOf(self->cxty, (const char *)member);
  moonbit_decref(self);   // last used
  moonbit_decref(member); // last used
  return res;
}

CXX_AccessSpecifier illusory0x0_clang_cursor_cxx_access_specifier(Cursor self) {
  CXX_AccessSpecifier res = clang_getCXXAccessSpecifier(self->cxcrs);
  moonbit_decref(self);
  return res;
}

StorageClass illusory0x0_clang_cursor_storage_class(Cursor self) {
  StorageClass res = clang_Cursor_getStorageClass(self->cxcrs);
  moonbit_decref(self);
  return res;
}

int32_t illusory0x0_clang_cursor_overloaded_decls_num(Cursor self) {
  int32_t res = clang_getNumOverloadedDecls(self->cxcrs);
  moonbit_decref(self);
  return res;
}
Cursor illusory0x0_clang_Cursor_overloaded_decls(Cursor self, int32_t index) {
  CXCursor cxcrs = clang_getOverloadedDecl(self->cxcrs, index);
  moonbit_incref(self->tu); // passing
  Cursor res = illusory0x0_clang_CXCursor_to_Cursor(self->tu, cxcrs);
  moonbit_decref(self);
  return res;
}

SourceLocation illusory0x0_clang_Cursor_source_location(Cursor self) {
  CXSourceLocation loc = clang_getCursorLocation(self->cxcrs);

  moonbit_incref(self->tu);
  SourceLocation res =
      illusory0x0_clang_CXSourceLocation_to_SourceLocation(self->tu, loc);

  moonbit_decref(self);
  return res;
}

SourceLocation illusory0x0_clang_SourceLocation_null() {
  SourceLocation res = illusory0x0_clang_CXSourceLocation_to_SourceLocation(
      NULL, clang_getNullLocation());
  return res;
}

#pragma region op_equal
Bool illusory0x0_clang_SourceLocation_op_equal(SourceLocation lhs,
                                               SourceLocation rhs) {
  int32_t res = clang_equalLocations(lhs->cxsl, rhs->cxsl);
  moonbit_decref(lhs);
  moonbit_decref(rhs);
  return illusory0x0_int_to_Bool(res);
}

Bool illusory0x0_clang_SourceRange_op_equal(SourceRange lhs, SourceRange rhs) {
  int32_t res = clang_equalRanges(lhs->cxsr, rhs->cxsr);
  moonbit_decref(lhs);
  moonbit_decref(rhs);
  return illusory0x0_int_to_Bool(res);
}
Bool illusory0x0_clang_Type_op_equal(Type lhs, Type rhs) {
  int32_t res = clang_equalTypes(lhs->cxty, rhs->cxty);
  moonbit_decref(lhs); // last used
  moonbit_decref(rhs); // last used
  return illusory0x0_int_to_Bool(res);
}

Bool illusory0x0_clang_Cursor_op_equal(Cursor lhs, Cursor rhs) {
  int32_t res = clang_equalCursors(lhs->cxcrs, rhs->cxcrs);
  moonbit_decref(lhs); // last used
  moonbit_decref(rhs); // last used
  return illusory0x0_int_to_Bool(res);
}
#pragma endregion

SourceRange illusory0x0_clang_Cursor_extent(Cursor self) {
  CXSourceRange range = clang_getCursorExtent(self->cxcrs);
  moonbit_incref(self->tu);
  SourceRange res =
      illusory0x0_clang_CXSourceRange_to_SourceRange(self->tu, range);
  moonbit_decref(self);
  return res;
}

FixedArray_Token
illusory0x0_clang_TranslationUnit_tokenize(TranslationUnit self,
                                           SourceRange range) {
  CXToken *cxtoks;
  uint32_t toks_len;

  clang_tokenize(self->cxtu, range->cxsr, &cxtoks, &toks_len);

  FixedArray_Token res =
      (FixedArray_Token)moonbit_make_ref_array(toks_len, NULL);

  for (uint32_t i = 0; i < toks_len; ++i) {
    moonbit_incref(self); // passing
    Token tok = illusory0x0_clang_CXToken_to_Token(self, cxtoks[i]);
    res[i] = tok; // store
  }

  clang_disposeTokens(self->cxtu, cxtoks, toks_len);
  // `clang_disposeTokens` just destroy Tokens **itself**, doesn't destroy
  // Tokens pointees.
  // https://github.com/llvm/llvm-project/blob/main/clang/tools/libclang/CIndex.cpp#L7814-L7817
  moonbit_decref(self);  // last used
  moonbit_decref(range); // last used
  return res;
}

Bytes illusory0x0_clang_Token_spelling(Token self) {
  CXString cxs = clang_getTokenSpelling(self->tu->cxtu, self->cxtok);

  Bytes res = illusory0x0_clang_CXString_to_moonbit_Bytes(cxs);
  moonbit_decref(self); // last used
  return res;
}

Cursor illusory0x0_clang_Type_type_declaration(Type self) {
  CXCursor cxcrs = clang_getTypeDeclaration(self->cxty);

  moonbit_incref(self->tu); // passing
  Cursor res = illusory0x0_clang_CXCursor_to_Cursor(self->tu, cxcrs);
  moonbit_decref(self);
  return res;
}
