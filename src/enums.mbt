///|
pub(all) enum LanguageKind {
  Invalid = 0
  C
  ObjC
  CPlusPlus
} derive(Show, Eq)

///|
pub(all) enum LinkageKind {
  Invalid = 0
  NoLinkage
  Internal
  UniqueExternal
  External
} derive(Show, Eq)

///|
pub(all) enum VisibilityKind {
  Invalid = 0
  Hidden
  Protected
  Default
} derive(Show, Eq)

///|
pub(all) enum AvailabilityKind {
  Available = 0
  Deprecated
  NotAvailable
  NotAccessible
} derive(Show, Eq)

///|
pub(all) enum CallingConv {
  Default = 0
  C = 1
  X86StdCall = 2
  X86FastCall = 3
  X86ThisCall = 4
  X86Pascal = 5
  AAPCS = 6
  AAPCS_VFP = 7
  X86RegCall = 8
  IntelOclBicc = 9
  X86_64Win64 = 10
  X86_64SysV = 11
  X86VectorCall = 12
  Swift = 13
  PreserveMost = 14
  PreserveAll = 15
  AArch64VectorCall = 16
  SwiftAsync = 17
  AArch64SVEPCS = 18
  M68kRTD = 19
  Invalid = 100
  CXCallingConv_Unexposed = 200
} derive(Show, Eq)

///|
pub(all) enum ErrorCode {
  Success = 0
  Failure_ = 1
  Crashed = 2
  InvalidArguments = 3
  ASTReadError = 4
} derive(Show, Eq)

///|
pub(all) enum CXX_AccessSpecifier {
  InvalidAccessSpecifier
  Public
  Protected
  Private
} derive(Show, Eq)

///|
enum StorageClass {
  Invalid
  None
  Extern
  Static
  PrivateExtern
  OpenCLWorkGroupLocal
  Auto
  Register
} derive(Show, Eq)
