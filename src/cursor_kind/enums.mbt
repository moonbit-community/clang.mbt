///|
pub type CursorKind = Int

///|
pub const UnexposedDecl : CursorKind = 1

///|
pub const StructDecl : CursorKind = 2

///|
pub const UnionDecl : CursorKind = 3

///|
pub const ClassDecl : CursorKind = 4

///|
pub const EnumDecl : CursorKind = 5

///|
pub const FieldDecl : CursorKind = 6

///|
pub const EnumConstantDecl : CursorKind = 7

///|
pub const FunctionDecl : CursorKind = 8

///|
pub const VarDecl : CursorKind = 9

///|
pub const ParmDecl : CursorKind = 10

///|
pub const ObjCInterfaceDecl : CursorKind = 11

///|
pub const ObjCCategoryDecl : CursorKind = 12

///|
pub const ObjCProtocolDecl : CursorKind = 13

///|
pub const ObjCPropertyDecl : CursorKind = 14

///|
pub const ObjCIvarDecl : CursorKind = 15

///|
pub const ObjCInstanceMethodDecl : CursorKind = 16

///|
pub const ObjCClassMethodDecl : CursorKind = 17

///|
pub const ObjCImplementationDecl : CursorKind = 18

///|
pub const ObjCCategoryImplDecl : CursorKind = 19

///|
pub const TypedefDecl : CursorKind = 20

///|
pub const CXXMethod : CursorKind = 21

///|
pub const Namespace : CursorKind = 22

///|
pub const LinkageSpec : CursorKind = 23

///|
pub const Constructor : CursorKind = 24

///|
pub const Destructor : CursorKind = 25

///|
pub const ConversionFunction : CursorKind = 26

///|
pub const TemplateTypeParameter : CursorKind = 27

///|
pub const NonTypeTemplateParameter : CursorKind = 28

///|
pub const TemplateTemplateParameter : CursorKind = 29

///|
pub const FunctionTemplate : CursorKind = 30

///|
pub const ClassTemplate : CursorKind = 31

///|
pub const ClassTemplatePartialSpecialization : CursorKind = 32

///|
pub const NamespaceAlias : CursorKind = 33

///|
pub const UsingDirective : CursorKind = 34

///|
pub const UsingDeclaration : CursorKind = 35

///|
pub const TypeAliasDecl : CursorKind = 36

///|
pub const ObjCSynthesizeDecl : CursorKind = 37

///|
pub const ObjCDynamicDecl : CursorKind = 38

///|
pub const CXXAccessSpecifier : CursorKind = 39

///|
pub const FirstDecl : CursorKind = UnexposedDecl

///|
pub const LastDecl : CursorKind = CXXAccessSpecifier

///|
pub const FirstRef : CursorKind = 40

///|
pub const ObjCSuperClassRef : CursorKind = 40

///|
pub const ObjCProtocolRef : CursorKind = 41

///|
pub const ObjCClassRef : CursorKind = 42

///|
pub const TypeRef : CursorKind = 43

///|
pub const CXXBaseSpecifier : CursorKind = 44

///|
pub const TemplateRef : CursorKind = 45

///|
pub const NamespaceRef : CursorKind = 46

///|
pub const MemberRef : CursorKind = 47

///|
pub const LabelRef : CursorKind = 48

///|
pub const OverloadedDeclRef : CursorKind = 49

///|
pub const VariableRef : CursorKind = 50

///|
pub const LastRef : CursorKind = VariableRef

///|
pub const FirstInvalid : CursorKind = 70

///|
pub const InvalidFile : CursorKind = 70

///|
pub const NoDeclFound : CursorKind = 71

///|
pub const NotImplemented : CursorKind = 72

///|
pub const InvalidCode : CursorKind = 73

///|
pub const LastInvalid : CursorKind = InvalidCode

///|
pub const FirstExpr : CursorKind = 100

///|
pub const UnexposedExpr : CursorKind = 100

///|
pub const DeclRefExpr : CursorKind = 101

///|
pub const MemberRefExpr : CursorKind = 102

///|
pub const CallExpr : CursorKind = 103

///|
pub const ObjCMessageExpr : CursorKind = 104

///|
pub const BlockExpr : CursorKind = 105

///|
pub const IntegerLiteral : CursorKind = 106

///|
pub const FloatingLiteral : CursorKind = 107

///|
pub const ImaginaryLiteral : CursorKind = 108

///|
pub const StringLiteral : CursorKind = 109

///|
pub const CharacterLiteral : CursorKind = 110

///|
pub const ParenExpr : CursorKind = 111

///|
pub const UnaryOperator : CursorKind = 112

///|
pub const ArraySubscriptExpr : CursorKind = 113

///|
pub const BinaryOperator : CursorKind = 114

///|
pub const CompoundAssignOperator : CursorKind = 115

///|
pub const ConditionalOperator : CursorKind = 116

///|
pub const CStyleCastExpr : CursorKind = 117

///|
pub const CompoundLiteralExpr : CursorKind = 118

///|
pub const InitListExpr : CursorKind = 119

///|
pub const AddrLabelExpr : CursorKind = 120

///|
pub const StmtExpr : CursorKind = 121

///|
pub const GenericSelectionExpr : CursorKind = 122

///|
pub const GNUNullExpr : CursorKind = 123

///|
pub const CXXStaticCastExpr : CursorKind = 124

///|
pub const CXXDynamicCastExpr : CursorKind = 125

///|
pub const CXXReinterpretCastExpr : CursorKind = 126

///|
pub const CXXConstCastExpr : CursorKind = 127

///|
pub const CXXFunctionalCastExpr : CursorKind = 128

///|
pub const CXXTypeidExpr : CursorKind = 129

///|
pub const CXXBoolLiteralExpr : CursorKind = 130

///|
pub const CXXNullPtrLiteralExpr : CursorKind = 131

///|
pub const CXXThisExpr : CursorKind = 132

///|
pub const CXXThrowExpr : CursorKind = 133

///|
pub const CXXNewExpr : CursorKind = 134

///|
pub const CXXDeleteExpr : CursorKind = 135

///|
pub const UnaryExpr : CursorKind = 136

///|
pub const ObjCStringLiteral : CursorKind = 137

///|
pub const ObjCEncodeExpr : CursorKind = 138

///|
pub const ObjCSelectorExpr : CursorKind = 139

///|
pub const ObjCProtocolExpr : CursorKind = 140

///|
pub const ObjCBridgedCastExpr : CursorKind = 141

///|
pub const PackExpansionExpr : CursorKind = 142

///|
pub const SizeOfPackExpr : CursorKind = 143

///|
pub const LambdaExpr : CursorKind = 144

///|
pub const ObjCBoolLiteralExpr : CursorKind = 145

///|
pub const ObjCSelfExpr : CursorKind = 146

///|
pub const OMPArraySectionExpr : CursorKind = 147

///|
pub const ObjCAvailabilityCheckExpr : CursorKind = 148

///|
pub const FixedPointLiteral : CursorKind = 149

///|
pub const OMPArrayShapingExpr : CursorKind = 150

///|
pub const OMPIteratorExpr : CursorKind = 151

///|
pub const CXXAddrspaceCastExpr : CursorKind = 152

///|
pub const ConceptSpecializationExpr : CursorKind = 153

///|
pub const RequiresExpr : CursorKind = 154

///|
pub const CXXParenListInitExpr : CursorKind = 155

///|
pub const LastExpr : CursorKind = CXXParenListInitExpr

///|
pub const FirstStmt : CursorKind = 200

///|
pub const UnexposedStmt : CursorKind = 200

///|
pub const LabelStmt : CursorKind = 201

///|
pub const CompoundStmt : CursorKind = 202

///|
pub const CaseStmt : CursorKind = 203

///|
pub const DefaultStmt : CursorKind = 204

///|
pub const IfStmt : CursorKind = 205

///|
pub const SwitchStmt : CursorKind = 206

///|
pub const WhileStmt : CursorKind = 207

///|
pub const DoStmt : CursorKind = 208

///|
pub const ForStmt : CursorKind = 209

///|
pub const GotoStmt : CursorKind = 210

///|
pub const IndirectGotoStmt : CursorKind = 211

///|
pub const ContinueStmt : CursorKind = 212

///|
pub const BreakStmt : CursorKind = 213

///|
pub const ReturnStmt : CursorKind = 214

///|
pub const GCCAsmStmt : CursorKind = 215

///|
pub const AsmStmt : CursorKind = GCCAsmStmt

///|
pub const ObjCAtTryStmt : CursorKind = 216

///|
pub const ObjCAtCatchStmt : CursorKind = 217

///|
pub const ObjCAtFinallyStmt : CursorKind = 218

///|
pub const ObjCAtThrowStmt : CursorKind = 219

///|
pub const ObjCAtSynchronizedStmt : CursorKind = 220

///|
pub const ObjCAutoreleasePoolStmt : CursorKind = 221

///|
pub const ObjCForCollectionStmt : CursorKind = 222

///|
pub const CXXCatchStmt : CursorKind = 223

///|
pub const CXXTryStmt : CursorKind = 224

///|
pub const CXXForRangeStmt : CursorKind = 225

///|
pub const SEHTryStmt : CursorKind = 226

///|
pub const SEHExceptStmt : CursorKind = 227

///|
pub const SEHFinallyStmt : CursorKind = 228

///|
pub const MSAsmStmt : CursorKind = 229

///|
pub const NullStmt : CursorKind = 230

///|
pub const DeclStmt : CursorKind = 231

///|
pub const OMPParallelDirective : CursorKind = 232

///|
pub const OMPSimdDirective : CursorKind = 233

///|
pub const OMPForDirective : CursorKind = 234

///|
pub const OMPSectionsDirective : CursorKind = 235

///|
pub const OMPSectionDirective : CursorKind = 236

///|
pub const OMPSingleDirective : CursorKind = 237

///|
pub const OMPParallelForDirective : CursorKind = 238

///|
pub const OMPParallelSectionsDirective : CursorKind = 239

///|
pub const OMPTaskDirective : CursorKind = 240

///|
pub const OMPMasterDirective : CursorKind = 241

///|
pub const OMPCriticalDirective : CursorKind = 242

///|
pub const OMPTaskyieldDirective : CursorKind = 243

///|
pub const OMPBarrierDirective : CursorKind = 244

///|
pub const OMPTaskwaitDirective : CursorKind = 245

///|
pub const OMPFlushDirective : CursorKind = 246

///|
pub const SEHLeaveStmt : CursorKind = 247

///|
pub const OMPOrderedDirective : CursorKind = 248

///|
pub const OMPAtomicDirective : CursorKind = 249

///|
pub const OMPForSimdDirective : CursorKind = 250

///|
pub const OMPParallelForSimdDirective : CursorKind = 251

///|
pub const OMPTargetDirective : CursorKind = 252

///|
pub const OMPTeamsDirective : CursorKind = 253

///|
pub const OMPTaskgroupDirective : CursorKind = 254

///|
pub const OMPCancellationPointDirective : CursorKind = 255

///|
pub const OMPCancelDirective : CursorKind = 256

///|
pub const OMPTargetDataDirective : CursorKind = 257

///|
pub const OMPTaskLoopDirective : CursorKind = 258

///|
pub const OMPTaskLoopSimdDirective : CursorKind = 259

///|
pub const OMPDistributeDirective : CursorKind = 260

///|
pub const OMPTargetEnterDataDirective : CursorKind = 261

///|
pub const OMPTargetExitDataDirective : CursorKind = 262

///|
pub const OMPTargetParallelDirective : CursorKind = 263

///|
pub const OMPTargetParallelForDirective : CursorKind = 264

///|
pub const OMPTargetUpdateDirective : CursorKind = 265

///|
pub const OMPDistributeParallelForDirective : CursorKind = 266

///|
pub const OMPDistributeParallelForSimdDirective : CursorKind = 267

///|
pub const OMPDistributeSimdDirective : CursorKind = 268

///|
pub const OMPTargetParallelForSimdDirective : CursorKind = 269

///|
pub const OMPTargetSimdDirective : CursorKind = 270

///|
pub const OMPTeamsDistributeDirective : CursorKind = 271

///|
pub const OMPTeamsDistributeSimdDirective : CursorKind = 272

///|
pub const OMPTeamsDistributeParallelForSimdDirective : CursorKind = 273

///|
pub const OMPTeamsDistributeParallelForDirective : CursorKind = 274

///|
pub const OMPTargetTeamsDirective : CursorKind = 275

///|
pub const OMPTargetTeamsDistributeDirective : CursorKind = 276

///|
pub const OMPTargetTeamsDistributeParallelForDirective : CursorKind = 277

///|
pub const OMPTargetTeamsDistributeParallelForSimdDirective : CursorKind = 278

///|
pub const OMPTargetTeamsDistributeSimdDirective : CursorKind = 279

///|
pub const BuiltinBitCastExpr : CursorKind = 280

///|
pub const OMPMasterTaskLoopDirective : CursorKind = 281

///|
pub const OMPParallelMasterTaskLoopDirective : CursorKind = 282

///|
pub const OMPMasterTaskLoopSimdDirective : CursorKind = 283

///|
pub const OMPParallelMasterTaskLoopSimdDirective : CursorKind = 284

///|
pub const OMPParallelMasterDirective : CursorKind = 285

///|
pub const OMPDepobjDirective : CursorKind = 286

///|
pub const OMPScanDirective : CursorKind = 287

///|
pub const OMPTileDirective : CursorKind = 288

///|
pub const OMPCanonicalLoop : CursorKind = 289

///|
pub const OMPInteropDirective : CursorKind = 290

///|
pub const OMPDispatchDirective : CursorKind = 291

///|
pub const OMPMaskedDirective : CursorKind = 292

///|
pub const OMPUnrollDirective : CursorKind = 293

///|
pub const OMPMetaDirective : CursorKind = 294

///|
pub const OMPGenericLoopDirective : CursorKind = 295

///|
pub const OMPTeamsGenericLoopDirective : CursorKind = 296

///|
pub const OMPTargetTeamsGenericLoopDirective : CursorKind = 297

///|
pub const OMPParallelGenericLoopDirective : CursorKind = 298

///|
pub const OMPTargetParallelGenericLoopDirective : CursorKind = 299

///|
pub const OMPParallelMaskedDirective : CursorKind = 300

///|
pub const OMPMaskedTaskLoopDirective : CursorKind = 301

///|
pub const OMPMaskedTaskLoopSimdDirective : CursorKind = 302

///|
pub const OMPParallelMaskedTaskLoopDirective : CursorKind = 303

///|
pub const OMPParallelMaskedTaskLoopSimdDirective : CursorKind = 304

///|
pub const OMPErrorDirective : CursorKind = 305

///|
pub const OMPScopeDirective : CursorKind = 306

///|
pub const LastStmt : CursorKind = OMPScopeDirective

///|
pub const TranslationUnit : CursorKind = 350

///|
pub const FirstAttr : CursorKind = 400

///|
pub const UnexposedAttr : CursorKind = 400

///|
pub const IBActionAttr : CursorKind = 401

///|
pub const IBOutletAttr : CursorKind = 402

///|
pub const IBOutletCollectionAttr : CursorKind = 403

///|
pub const CXXFinalAttr : CursorKind = 404

///|
pub const CXXOverrideAttr : CursorKind = 405

///|
pub const AnnotateAttr : CursorKind = 406

///|
pub const AsmLabelAttr : CursorKind = 407

///|
pub const PackedAttr : CursorKind = 408

///|
pub const PureAttr : CursorKind = 409

///|
pub const ConstAttr : CursorKind = 410

///|
pub const NoDuplicateAttr : CursorKind = 411

///|
pub const CUDAConstantAttr : CursorKind = 412

///|
pub const CUDADeviceAttr : CursorKind = 413

///|
pub const CUDAGlobalAttr : CursorKind = 414

///|
pub const CUDAHostAttr : CursorKind = 415

///|
pub const CUDASharedAttr : CursorKind = 416

///|
pub const VisibilityAttr : CursorKind = 417

///|
pub const DLLExport : CursorKind = 418

///|
pub const DLLImport : CursorKind = 419

///|
pub const NSReturnsRetained : CursorKind = 420

///|
pub const NSReturnsNotRetained : CursorKind = 421

///|
pub const NSReturnsAutoreleased : CursorKind = 422

///|
pub const NSConsumesSelf : CursorKind = 423

///|
pub const NSConsumed : CursorKind = 424

///|
pub const ObjCException : CursorKind = 425

///|
pub const ObjCNSObject : CursorKind = 426

///|
pub const ObjCIndependentClass : CursorKind = 427

///|
pub const ObjCPreciseLifetime : CursorKind = 428

///|
pub const ObjCReturnsInnerPointer : CursorKind = 429

///|
pub const ObjCRequiresSuper : CursorKind = 430

///|
pub const ObjCRootClass : CursorKind = 431

///|
pub const ObjCSubclassingRestricted : CursorKind = 432

///|
pub const ObjCExplicitProtocolImpl : CursorKind = 433

///|
pub const ObjCDesignatedInitializer : CursorKind = 434

///|
pub const ObjCRuntimeVisible : CursorKind = 435

///|
pub const ObjCBoxable : CursorKind = 436

///|
pub const FlagEnum : CursorKind = 437

///|
pub const ConvergentAttr : CursorKind = 438

///|
pub const WarnUnusedAttr : CursorKind = 439

///|
pub const WarnUnusedResultAttr : CursorKind = 440

///|
pub const AlignedAttr : CursorKind = 441

///|
pub const LastAttr : CursorKind = AlignedAttr

///|
pub const PreprocessingDirective : CursorKind = 500

///|
pub const MacroDefinition : CursorKind = 501

///|
pub const MacroExpansion : CursorKind = 502

///|
pub const MacroInstantiation : CursorKind = MacroExpansion

///|
pub const InclusionDirective : CursorKind = 503

///|
pub const FirstPreprocessing : CursorKind = PreprocessingDirective

///|
pub const LastPreprocessing : CursorKind = InclusionDirective

///|
pub const ModuleImportDecl : CursorKind = 600

///|
pub const TypeAliasTemplateDecl : CursorKind = 601

///|
pub const StaticAssert : CursorKind = 602

///|
pub const FriendDecl : CursorKind = 603

///|
pub const ConceptDecl : CursorKind = 604

///|
pub const FirstExtraDecl : CursorKind = ModuleImportDecl

///|
pub const LastExtraDecl : CursorKind = ConceptDecl

///|
pub const OverloadCandidate : CursorKind = 700
