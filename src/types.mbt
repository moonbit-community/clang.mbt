///|
type Index

///|
suberror ParseError {
  ParseError(ErrorCode)
} derive(Debug, Eq)

///|
type TranslationUnit

///|
type Cursor

///|
type TargetInfo

///|
type Type

///|
pub type TypeKind = Int

///|
pub type CursorKind = Int

///|
type SourceLocation

///|
type SourceRange

///|
type Token
