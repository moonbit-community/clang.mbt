///|
pub(all) enum LanguageKind {
  Invalid = 0
  C
  ObjC
  CPlusPlus
} derive(Debug, Eq)

///|
pub(all) enum LinkageKind {
  Invalid = 0
  NoLinkage
  Internal
  UniqueExternal
  External
} derive(Debug, Eq)

///|
pub(all) enum VisibilityKind {
  Invalid = 0
  Hidden
  Protected
  Default
} derive(Debug, Eq)

///|
pub(all) enum AvailabilityKind {
  Available = 0
  Deprecated
  NotAvailable
  NotAccessible
} derive(Debug, Eq)

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
} derive(Debug, Eq)

///|
pub(all) enum ErrorCode {
  Success = 0
  Failure = 1
  Crashed = 2
  InvalidArguments = 3
  ASTReadError = 4
} derive(Debug, Eq)

///|
pub(all) enum CXX_AccessSpecifier {
  InvalidAccessSpecifier
  Public
  Protected
  Private
} derive(Debug, Eq)

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
} derive(Debug, Eq)

///|
fn[T : Debug] show_debug(value : T, logger : &Logger) -> Unit {
  logger.write_object(to_repr(value))
}

///|
pub impl Show for LanguageKind with output(self, logger) {
  show_debug(self, logger)
}

///|
pub impl Show for LinkageKind with output(self, logger) {
  show_debug(self, logger)
}

///|
pub impl Show for VisibilityKind with output(self, logger) {
  show_debug(self, logger)
}

///|
pub impl Show for AvailabilityKind with output(self, logger) {
  show_debug(self, logger)
}

///|
pub impl Show for CallingConv with output(self, logger) {
  show_debug(self, logger)
}

///|
pub impl Show for ErrorCode with output(self, logger) {
  show_debug(self, logger)
}

///|
pub impl Show for CXX_AccessSpecifier with output(self, logger) {
  show_debug(self, logger)
}

///|
impl Show for StorageClass with output(self, logger) {
  show_debug(self, logger)
}
