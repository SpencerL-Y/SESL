#
# This file is distributed under the MIT License. See LICENSE for details.
#

cmake_minimum_required(VERSION 3.4.3)
project(sesl)

if (NOT WIN32 OR MSYS OR CYGWIN)

  file(STRINGS "bin/versions" LLVM_VERSION_STR REGEX "LLVM_SHORT_VERSION=\"[0-9]+\"")
  string(REGEX MATCH "[0-9]+" LLVM_SHORT_VERSION "${LLVM_VERSION_STR}")

  find_program(LLVM_CONFIG_EXECUTABLE NAMES llvm-config-${LLVM_SHORT_VERSION} llvm-config PATHS ${LLVM_CONFIG} DOC "llvm-config")

  if (LLVM_CONFIG_EXECUTABLE STREQUAL "LLVM_CONFIG_EXECUTABLE-NOTFOUND")
    message(FATAL_ERROR "llvm-config could not be found!")
  endif()

  execute_process(
    COMMAND ${LLVM_CONFIG_EXECUTABLE} --cxxflags
    OUTPUT_VARIABLE LLVM_CXXFLAGS
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  # TODO: explain why these are required.
  string(REPLACE "-DNDEBUG" "" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
  string(REPLACE "-Wno-maybe-uninitialized" "" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
  string(REPLACE "-fuse-ld=gold" "" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
  string(REPLACE "--no-keep-files-mapped" "" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
  string(REPLACE "--no-map-whole-files" "" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
  string(REPLACE "-Wl," "" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
  string(REPLACE "-gsplit-dwarf" "" LLVM_CXXFLAGS "${LLVM_CXXFLAGS}")
  string(REGEX REPLACE "-O[0-9]" "" CMAKE_CXX_FLAGS "${LLVM_CXXFLAGS}")

  # TODO: append these one at a time; give rationale.
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-exceptions -fno-rtti -Wno-undefined-var-template")

  # Apparently avoids a problem with inconsistent visibility settings from LLVM:
  #
  # > ld: warning: direct access in function 'llvm::_'
  # >   from file '/usr/local/opt/llvm@8/lib/_'
  # >   to global weak symbol 'llvm::_'
  # >   from file 'libsmackTranslator.a(_.cpp.o)'
  # >   means the weak symbol cannot be overridden at runtime.
  # >   This was likely caused by different translation units being compiled
  # >   with different visibility settings.
  #
  # Solution found on Stack Overflow:
  # https://stackoverflow.com/questions/8685045/xcode-with-boost-linkerid-warning-about-visibility-settings
  string(APPEND CMAKE_CXX_FLAGS_DEBUG " -fvisibility=hidden")

  # TODO: explain why these are required.
  string(APPEND CMAKE_CXX_FLAGS_DEBUG " -O0")
  string(APPEND CMAKE_C_FLAGS_DEBUG " -O0")

  execute_process(
    COMMAND ${LLVM_CONFIG_EXECUTABLE} --libs
    OUTPUT_VARIABLE LLVM_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  execute_process(
    COMMAND ${LLVM_CONFIG_EXECUTABLE} --system-libs
    OUTPUT_VARIABLE LLVM_SYSTEM_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  execute_process(
    COMMAND ${LLVM_CONFIG_EXECUTABLE} --ldflags
    OUTPUT_VARIABLE LLVM_LDFLAGS
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )

else()
  set(LLVM_SRC "" CACHE PATH "LLVM source directory")
  set(LLVM_BUILD "" CACHE PATH "LLVM build directory")
  set(LLVM_BUILD_TYPE "" CACHE STRING "LLVM build type")

  if (NOT EXISTS "${LLVM_SRC}/include/llvm")
    message(FATAL_ERROR "Invalid LLVM source directory: ${LLVM_SRC}")
  endif()

  set(LLVM_LIBDIR "${LLVM_BUILD}/lib/${LLVM_BUILD_TYPE}")
  if (NOT EXISTS "${LLVM_LIBDIR}")
    message(FATAL_ERROR "Invalid LLVM build directory: ${LLVM_BUILD}")
  endif()

  ## TODO how to enable debug mode on Windows?
  # set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0")
  # set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O0")

  set(CMAKE_CXX_FLAGS "\"/I${LLVM_SRC}/include\" \"/I${LLVM_BUILD}/include\" -D_SCL_SECURE_NO_WARNINGS -wd4146 -wd4244 -wd4355 -wd4482 -wd4800")

  set(LLVM_LDFLAGS "")
  set(LLVM_LIBS "${LLVM_LIBDIR}/LLVMTransformUtils.lib" "${LLVM_LIBDIR}/LLVMipa.lib" "${LLVM_LIBDIR}/LLVMAnalysis.lib" "${LLVM_LIBDIR}/LLVMTarget.lib" "${LLVM_LIBDIR}/LLVMMC.lib" "${LLVM_LIBDIR}/LLVMObject.lib" "${LLVM_LIBDIR}/LLVMBitReader.lib" "${LLVM_LIBDIR}/LLVMCore.lib" "${LLVM_LIBDIR}/LLVMSupport.lib")

endif()

include_directories(include)
include_directories(sea-dsa/include)

add_library(
  utils STATIC
  include/utils/Devirt.h
  include/utils/MergeGEP.h
  include/utils/SimplifyInsertValue.h
  include/utils/SimplifyExtractValue.h
  include/utils/TranslatorUtil.h
  lib/utils/Devirt.cpp
  lib/utils/MergeGEP.cpp
  lib/utils/SimplifyInsertValue.cpp
  lib/utils/SimplifyExtractValue.cpp
  lib/utils/TranslatorUtil.cpp
)

add_library(smackTranslator STATIC
  include/smack/AddTiming.h
  include/smack/sesl/ast/BoogieAst.h
  include/smack/BplFilePrinter.h
  include/smack/BplPrinter.h
  include/smack/DSAWrapper.h
  include/smack/InitializePasses.h
  include/smack/Naming.h
  include/smack/Regions.h
  include/smack/SmackInstGenerator.h
      include/smack/SmackSrcNamesMapper.h
  include/smack/SmackModuleGenerator.h
  include/smack/SmackOptions.h
  include/smack/CodifyStaticInits.h
  include/smack/RemoveDeadDefs.h
  include/smack/ExtractContracts.h
  include/smack/VerifierCodeMetadata.h
  include/smack/SimplifyLibCalls.h
  include/smack/SmackRep.h
  include/smack/VectorOperations.h
  include/smack/MemSafeMarker.h
  include/smack/IntegerOverflowChecker.h
  include/smack/RewriteBitwiseOps.h
  include/smack/NormalizeLoops.h
  include/smack/RustFixes.h
  include/smack/SplitAggregateValue.h
  include/smack/Prelude.h
  include/smack/SmackWarnings.h
  include/smack/Solver.h
  include/smack/SVNaming.h
        include/smack/sesl/executor/Translator.h
        include/smack/sesl/executor/BlockExecutor.h
        include/smack/sesl/cfg/CFG.h
        include/smack/sesl/cfg/CFGState.h
        include/smack/sesl/cfg/CFGEdge.h
        include/smack/sesl/verifier/MemSafeVerifier.h
        include/smack/sesl/executor/VarEquiv.h
        include/smack/sesl/executor/VarFactory.h
        include/smack/sesl/executor/StoreSplitter.h
	      include/smack/sesl/mem_manage/MemoryManager.h
        include/smack/sesl/cfg/CFGExecutor.h
        include/smack/sesl/executor/ExecutionState.h
        include/smack/sesl/witness/ViolationPathGen.h
        include/smack/sesl/cfg/CFGUtils.h
        include/smack/sesl/cfg/ProcManager.h
        include/smack/sesl/bmc/BMCRefinedCFG.h
        include/smack/sesl/bmc/BMCVCGen.h
        include/smack/sesl/verifier/BMCMemSafeVerifier.h
        include/smack/sesl/bmc/StmtFormatter.h
        include/smack/sesl/bmc/BMCPreAnalysis.h
        include/smack/sesl/bmc/BMCVisualizer.h
        include/smack/sesl/cegar/BMCCEGARVCGen.h
        include/smack/sesl/cegar/BMCRefiner.h
        include/smack/sesl/cegar/BMCValidator.h
        include/smack/sesl/verifier/BMCCegarVerifier.h
        include/tinyxml/tinyxml2.h
  lib/smack/AddTiming.cpp
  lib/smack/sesl/ast/BoogieAst.cpp
  lib/smack/BplFilePrinter.cpp
  lib/smack/BplPrinter.cpp
  lib/smack/Debug.cpp
  lib/smack/DSAWrapper.cpp
  lib/smack/Naming.cpp
  lib/smack/Regions.cpp
  lib/smack/SmackInstGenerator.cpp
  lib/smack/SmackSrcNamesMapper.cpp
  lib/smack/SmackModuleGenerator.cpp
  lib/smack/SmackOptions.cpp
  lib/smack/CodifyStaticInits.cpp
  lib/smack/RemoveDeadDefs.cpp
  lib/smack/ExtractContracts.cpp
  lib/smack/VerifierCodeMetadata.cpp
  lib/smack/SimplifyLibCalls.cpp
  lib/smack/SmackRep.cpp
  lib/smack/VectorOperations.cpp
  lib/smack/MemSafeMarker.cpp
  lib/smack/IntegerOverflowChecker.cpp
  lib/smack/RewriteBitwiseOps.cpp
  lib/smack/NormalizeLoops.cpp
  lib/smack/RustFixes.cpp
  lib/smack/SplitAggregateValue.cpp
  lib/smack/Prelude.cpp
  lib/smack/SmackWarnings.cpp
  lib/smack/Solver.cpp
  lib/smack/SVNaming.cpp
        lib/smack/sesl/executor/Translator.cpp
        lib/smack/sesl/executor/BlockExecutor.cpp
        lib/smack/sesl/executor/ExecutionState.cpp
        lib/smack/sesl/verifier/MemSafeVerifier.cpp
        lib/smack/sesl/executor/VarEquiv.cpp
        lib/smack/sesl/executor/VarFactory.cpp
        lib/smack/sesl/executor/StoreSplitter.cpp
	      lib/smack/sesl/mem_manage/MemoryManager.cpp
        lib/smack/sesl/cfg/CFG.cpp
        lib/smack/sesl/cfg/CFGState.cpp
        lib/smack/sesl/cfg/CFGEdge.cpp
        lib/smack/sesl/cfg/CFGExecutor.cpp
        lib/smack/sesl/cfg/ProcManager.cpp
        lib/smack/sesl/cfg/CFGUtils.cpp
        lib/smack/sesl/bmc/BMCRefinedCFG.cpp
        lib/smack/sesl/witness/ViolationPathGen.cpp
        lib/smack/sesl/bmc/BMCVCGen.cpp
        lib/smack/sesl/verifier/BMCMemSafeVerifier.cpp
        lib/smack/sesl/bmc/BMCPreAnalysis.cpp
        lib/smack/sesl/bmc/StmtFormatter.cpp
        lib/smack/sesl/bmc/BMCVisualizer.cpp
        lib/smack/sesl/cegar/BMCCEGARVCGen.cpp
        lib/smack/sesl/cegar/BMCRefiner.cpp
        lib/smack/sesl/cegar/BMCValidator.cpp
        lib/smack/sesl/verifier/BMCCegarVerifier.cpp
        lib/tinyxml/tinyxml2.cpp
  )

add_executable(llvm2bpl
  tools/llvm2bpl/llvm2bpl.cpp)

# We need to include Boost header files at least for macOS
# find_package (Boost 1.55)
# if (Boost_FOUND)
#   include_directories (${Boost_INCLUDE_DIRS})
# endif ()
# We have to import LLVM's cmake definitions to build sea-dsa
# Borrowed from sea-dsa's CMakeLists.txt
find_package (LLVM ${LLVM_SHORT_VERSION} CONFIG)
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddLLVM)
include(HandleLLVMOptions)
# Add Z3 to do the symbolic execution on separation logic
find_package(Z3 REQUIRED CONFIG)
message(STATUS "Z3DIR: ${CMAKE_PREFIX_PATH}")
message(STATUS "Z3_FOUND: ${Z3_FOUND}" )
message(STATUS "Found Z3: ${Z3_VERSION_STRING}")
include_directories (${Z3_CXX_INCLUDE_DIRS})

find_package(OpenSSL REQUIRED)
message(STATUS "OPENSSL_FOUND: ${OPENSSL_FOUND}")
include_directories(${OPENSSL_INCLUDE_DIR})



# We need the release build of sea-dsa otherwise we'll see a lot of crashes in
# sv-comp benchmarks.
# The following solution is from: https://stackoverflow.com/questions/30985215/passing-variables-down-to-subdirectory-only
set(SMACK_BUILD_TYPE "${CMAKE_BUILD_TYPE}")
set(CMAKE_BUILD_TYPE "Release")
add_subdirectory(sea-dsa/lib/seadsa)
set(CMAKE_BUILD_TYPE ${SMACK_BUILD_TYPE})

# add link of separation logic library slah
set(SL_DIR ${PROJECT_SOURCE_DIR}/include)
set(SL_LIB ${PROJECT_SOURCE_DIR}/lib)
include_directories(${SL_DIR})
link_directories(${SL_LIB})

target_link_libraries(smackTranslator ${LLVM_LIBS} ${LLVM_SYSTEM_LIBS} ${LLVM_LDFLAGS} ${Z3_LIBRARIES} ${OPENSSL_LIBRARIES})
# target_link_libraries(llvm2bpl smackTranslator utils SeaDsaAnalysis ${SL_LIB}/libslah.so ${SL_LIB}/libz3.so )
target_link_libraries(llvm2bpl smackTranslator utils SeaDsaAnalysis ${SL_LIB}/libslah.so ${SL_LIB}/libz3.so )

INSTALL(TARGETS llvm2bpl
  RUNTIME DESTINATION bin
)

INSTALL(FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/bin/sesl
  ${CMAKE_CURRENT_SOURCE_DIR}/bin/sesl-svcomp.sh
  PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
  GROUP_EXECUTE GROUP_READ WORLD_EXECUTE WORLD_READ
  DESTINATION bin
)

INSTALL(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/scripts
  DESTINATION bin PATTERN "*.h" PATTERN "*.c" PATTERN "Makefile"
)

INSTALL(FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/bin/versions
  DESTINATION bin/scripts
  RENAME versions.py
)

# INSTALL(FILES
#   ${CMAKE_CURRENT_SOURCE_DIR}/share/smack/lib/smack/Cargo.toml
#   ${CMAKE_CURRENT_SOURCE_DIR}/share/smack/lib/smack/build.rs
#   DESTINATION share/smack/lib
# )

# INSTALL(FILES
#   ${CMAKE_CURRENT_SOURCE_DIR}/share/smack/lib/smack-rust.c
#   DESTINATION share/smack/lib/src
# )

# INSTALL(FILES
#   ${CMAKE_CURRENT_SOURCE_DIR}/share/smack/lib/smack.rs
#   DESTINATION share/smack/lib/src
#   RENAME lib.rs
# )
