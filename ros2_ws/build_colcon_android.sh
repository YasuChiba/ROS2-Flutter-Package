cd `dirname $0`


export PYTHON3_EXEC="$( which python3 )"
export PYTHON3_LIBRARY="$( ${PYTHON3_EXEC} -c 'import os.path; from distutils import sysconfig; print(os.path.realpath(os.path.join(sysconfig.get_config_var("LIBPL"), sysconfig.get_config_var("LDLIBRARY"))))' )"
export PYTHON3_INCLUDE_DIR="$( ${PYTHON3_EXEC} -c 'from distutils import sysconfig; print(sysconfig.get_config_var("INCLUDEPY"))' )"

export install_dir=${PWD}/install/${ANDROID_ABI}
export build_dir=${PWD}/build/${ANDROID_ABI}

echo "androidABI: ${ANDROID_ABI}"
echo "cmakeFindRootPath: ${CMAKE_FIND_ROOT_PATH}"
echo "installDir: ${install_dir}"
echo "ndk: ${ANDROID_NDK}"
echo "ccc: ${CMAKE_LIBRARY_PATH};${ANDROID_NDK}/sources/cxx-stl/llvm-libc++/libs/${ANDROID_ABI}/"
echo "ANDROID_FUNCTION_LEVEL_LINKING: ${ANDROID_FUNCTION_LEVEL_LINKING}"
echo "ANDROID_PLATFORM: ${ANDROID_PLATFORM}"
echo "ANDROID_STL: ${ANDROID_STL}"

#-DCMAKE_BUILD_TOOL=${CMAKE_BUILD_TOOL} \
#-DCMAKE_GENERATOR=${CMAKE_GENERATOR} \
#-DCMAKE_MAKE_PROGRAM=${CMAKE_MAKE_PROGRAM}
colcon build \
    --install-base ${install_dir} \
    --build-base ${build_dir} \
    --merge-install \
    --packages-ignore rcl_logging_spdlog \
    --cmake-clean-cache \
    --cmake-args \
    --no-warn-unused-cli \
    -DCMAKE_COMMAND=${CMAKE_COMMAND} \
    -DPYTHON_EXECUTABLE=${PYTHON3_EXEC} \
    -DPYTHON_LIBRARY=${PYTHON3_LIBRARY} \
    -DPYTHON_INCLUDE_DIR=${PYTHON3_INCLUDE_DIR} \
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
    -DANDROID=${ANDROID} \
    -DANDROID_FUNCTION_LEVEL_LINKING=${ANDROID_FUNCTION_LEVEL_LINKING} \
    -DANDROID_NATIVE_API_LEVEL=${ANDROID_PLATFORM} \
    -DANDROID_TOOLCHAIN_NAME=${ANDROID_TOOLCHAIN_NAME} \
    -DANDROID_STL=${ANDROID_STL} \
    -DANDROID_ABI=${ANDROID_ABI} \
    -DANDROID_NDK=${ANDROID_NDK} \
    -DTHIRDPARTY=ON  \
    -DCOMPILE_EXAMPLES=OFF \
    -DCMAKE_FIND_ROOT_PATH="${CMAKE_FIND_ROOT_PATH};${install_dir}" \
    -DBUILD_TESTING=OFF \
    -DRCL_LOGGING_IMPLEMENTATION=rcl_logging_noop \
    -DTRACETOOLS_DISABLED=ON
