///|
pub type TypeKind = Int

///|
pub const Invalid : TypeKind = 0

///|
pub const Unexposed : TypeKind = 1

///|
pub const Void : TypeKind = 2

///|
pub const Bool : TypeKind = 3

///|
pub const Char_U : TypeKind = 4

///|
pub const UChar : TypeKind = 5

///|
pub const Char16 : TypeKind = 6

///|
pub const Char32 : TypeKind = 7

///|
pub const UShort : TypeKind = 8

///|
pub const UInt : TypeKind = 9

///|
pub const ULong : TypeKind = 10

///|
pub const ULongLong : TypeKind = 11

///|
pub const UInt128 : TypeKind = 12

///|
pub const Char_S : TypeKind = 13

///|
pub const SChar : TypeKind = 14

///|
pub const WChar : TypeKind = 15

///|
pub const Short : TypeKind = 16

///|
pub const Int : TypeKind = 17

///|
pub const Long : TypeKind = 18

///|
pub const LongLong : TypeKind = 19

///|
pub const Int128 : TypeKind = 20

///|
pub const Float : TypeKind = 21

///|
pub const Double : TypeKind = 22

///|
pub const LongDouble : TypeKind = 23

///|
pub const NullPtr : TypeKind = 24

///|
pub const Overload : TypeKind = 25

///|
pub const Dependent : TypeKind = 26

///|
pub const ObjCId : TypeKind = 27

///|
pub const ObjCClass : TypeKind = 28

///|
pub const ObjCSel : TypeKind = 29

///|
pub const Float128 : TypeKind = 30

///|
pub const Half : TypeKind = 31

///|
pub const Float16 : TypeKind = 32

///|
pub const ShortAccum : TypeKind = 33

///|
pub const Accum : TypeKind = 34

///|
pub const LongAccum : TypeKind = 35

///|
pub const UShortAccum : TypeKind = 36

///|
pub const UAccum : TypeKind = 37

///|
pub const ULongAccum : TypeKind = 38

///|
pub const BFloat16 : TypeKind = 39

///|
pub const Ibm128 : TypeKind = 40

///|
pub const FirstBuiltin : TypeKind = Void

///|
pub const LastBuiltin : TypeKind = Ibm128

///|
pub const Complex : TypeKind = 100

///|
pub const Pointer : TypeKind = 101

///|
pub const BlockPointer : TypeKind = 102

///|
pub const LValueReference : TypeKind = 103

///|
pub const RValueReference : TypeKind = 104

///|
pub const Record : TypeKind = 105

///|
pub const Enum : TypeKind = 106

///|
pub const Typedef : TypeKind = 107

///|
pub const ObjCInterface : TypeKind = 108

///|
pub const ObjCObjectPointer : TypeKind = 109

///|
pub const FunctionNoProto : TypeKind = 110

///|
pub const FunctionProto : TypeKind = 111

///|
pub const ConstantArray : TypeKind = 112

///|
pub const Vector : TypeKind = 113

///|
pub const IncompleteArray : TypeKind = 114

///|
pub const VariableArray : TypeKind = 115

///|
pub const DependentSizedArray : TypeKind = 116

///|
pub const MemberPointer : TypeKind = 117

///|
pub const Auto : TypeKind = 118

///|
pub const Elaborated : TypeKind = 119

///|
pub const Pipe : TypeKind = 120

///|
pub const OCLImage1dRO : TypeKind = 121

///|
pub const OCLImage1dArrayRO : TypeKind = 122

///|
pub const OCLImage1dBufferRO : TypeKind = 123

///|
pub const OCLImage2dRO : TypeKind = 124

///|
pub const OCLImage2dArrayRO : TypeKind = 125

///|
pub const OCLImage2dDepthRO : TypeKind = 126

///|
pub const OCLImage2dArrayDepthRO : TypeKind = 127

///|
pub const OCLImage2dMSAARO : TypeKind = 128

///|
pub const OCLImage2dArrayMSAARO : TypeKind = 129

///|
pub const OCLImage2dMSAADepthRO : TypeKind = 130

///|
pub const OCLImage2dArrayMSAADepthRO : TypeKind = 131

///|
pub const OCLImage3dRO : TypeKind = 132

///|
pub const OCLImage1dWO : TypeKind = 133

///|
pub const OCLImage1dArrayWO : TypeKind = 134

///|
pub const OCLImage1dBufferWO : TypeKind = 135

///|
pub const OCLImage2dWO : TypeKind = 136

///|
pub const OCLImage2dArrayWO : TypeKind = 137

///|
pub const OCLImage2dDepthWO : TypeKind = 138

///|
pub const OCLImage2dArrayDepthWO : TypeKind = 139

///|
pub const OCLImage2dMSAAWO : TypeKind = 140

///|
pub const OCLImage2dArrayMSAAWO : TypeKind = 141

///|
pub const OCLImage2dMSAADepthWO : TypeKind = 142

///|
pub const OCLImage2dArrayMSAADepthWO : TypeKind = 143

///|
pub const OCLImage3dWO : TypeKind = 144

///|
pub const OCLImage1dRW : TypeKind = 145

///|
pub const OCLImage1dArrayRW : TypeKind = 146

///|
pub const OCLImage1dBufferRW : TypeKind = 147

///|
pub const OCLImage2dRW : TypeKind = 148

///|
pub const OCLImage2dArrayRW : TypeKind = 149

///|
pub const OCLImage2dDepthRW : TypeKind = 150

///|
pub const OCLImage2dArrayDepthRW : TypeKind = 151

///|
pub const OCLImage2dMSAARW : TypeKind = 152

///|
pub const OCLImage2dArrayMSAARW : TypeKind = 153

///|
pub const OCLImage2dMSAADepthRW : TypeKind = 154

///|
pub const OCLImage2dArrayMSAADepthRW : TypeKind = 155

///|
pub const OCLImage3dRW : TypeKind = 156

///|
pub const OCLSampler : TypeKind = 157

///|
pub const OCLEvent : TypeKind = 158

///|
pub const OCLQueue : TypeKind = 159

///|
pub const OCLReserveID : TypeKind = 160

///|
pub const ObjCObject : TypeKind = 161

///|
pub const ObjCTypeParam : TypeKind = 162

///|
pub const Attributed : TypeKind = 163

///|
pub const OCLIntelSubgroupAVCMcePayload : TypeKind = 164

///|
pub const OCLIntelSubgroupAVCImePayload : TypeKind = 165

///|
pub const OCLIntelSubgroupAVCRefPayload : TypeKind = 166

///|
pub const OCLIntelSubgroupAVCSicPayload : TypeKind = 167

///|
pub const OCLIntelSubgroupAVCMceResult : TypeKind = 168

///|
pub const OCLIntelSubgroupAVCImeResult : TypeKind = 169

///|
pub const OCLIntelSubgroupAVCRefResult : TypeKind = 170

///|
pub const OCLIntelSubgroupAVCSicResult : TypeKind = 171

///|
pub const OCLIntelSubgroupAVCImeResultSingleReferenceStreamout : TypeKind = 172

///|
pub const OCLIntelSubgroupAVCImeResultDualReferenceStreamout : TypeKind = 173

///|
pub const OCLIntelSubgroupAVCImeSingleReferenceStreamin : TypeKind = 174

///|
pub const OCLIntelSubgroupAVCImeDualReferenceStreamin : TypeKind = 175

///|
pub const OCLIntelSubgroupAVCImeResultSingleRefStreamout : TypeKind = 172

///|
pub const OCLIntelSubgroupAVCImeResultDualRefStreamout : TypeKind = 173

///|
pub const OCLIntelSubgroupAVCImeSingleRefStreamin : TypeKind = 174

///|
pub const OCLIntelSubgroupAVCImeDualRefStreamin : TypeKind = 175

///|
pub const ExtVector : TypeKind = 176

///|
pub const Atomic : TypeKind = 177

///|
pub const BTFTagAttributed : TypeKind = 178
