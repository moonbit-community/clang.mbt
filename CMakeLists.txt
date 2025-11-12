cmake_minimum_required(VERSION 3.10)
project(project_name VERSION 0.1.0 LANGUAGES C CXX)


set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(C_WARNING_FLAG "-Werror=incompatible-pointer-types -Werror=enum-conversion")
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${C_WARNING_FLAG}")
file(TO_CMAKE_PATH "$ENV{LLVM_HOME}" LLVM_HOME)
file(TO_CMAKE_PATH "$ENV{MOON_BIN}" MOON_BIN)

include_directories(${LLVM_HOME}/include)
include_directories(${MOON_BIN}/../include)

# link_directories(${LLVM_HOME}/lib)

add_library(clang_mbt STATIC src/stub.c)
# target_link_libraries(clang_mbt PRIVATE clang)
