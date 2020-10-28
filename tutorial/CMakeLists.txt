
file(GLOB SRCS "*.cpp")

foreach(var ${SRCS})
    string(REGEX REPLACE ".*/" "" SRC ${var})
    string(REGEX REPLACE "\.cpp" "" TGT ${SRC})
    add_executable(${TGT} ${SRC})
    target_link_libraries(${TGT} zkpp zkpp-server)
endforeach()