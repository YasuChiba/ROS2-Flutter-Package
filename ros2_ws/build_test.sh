

colcon build \
    --merge-install \
    --packages-ignore rcl_logging_spdlog \
    --cmake-args \
    -DTHIRDPARTY=ON  \
    -DCOMPILE_EXAMPLES=OFF \
    -DBUILD_TESTING=OFF \
    -DRCL_LOGGING_IMPLEMENTATION=rcl_logging_noop