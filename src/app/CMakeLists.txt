project(app)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_compile_options(
  -Wall
  -Wextra
  -Wpedantic
  -Wduplicated-branches
  -Wduplicated-cond
  -Wnull-dereference
  -Wmissing-declarations
  -Wuninitialized
  -Werror
  -O2
)

find_package(iceoryx_posh CONFIG REQUIRED)
include(IceoryxPlatform)

add_executable(app
  main.cpp
)

target_link_libraries(app iceoryx_posh::iceoryx_posh )
