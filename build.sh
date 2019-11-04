#!/bin/bash

BUILD_OPTS="-j6 "
# module_gdnative_enabled=no \
# module_hdr_enabled=no \
# module_jsonrpc_enabled=no \
# module_mbedtls_enabled=no \
# module_webm_enabled=no \
# module_webp_enabled=no \
# module_webrtc_enabled=no \
# module_arkit_enabled=no \
# module_websocket_enabled=no"

BUILD_OPTS_EXPORT="$BUILD_OPTS disable_3d=yes module_gdscript_enabled=no"

pushd $(dirname $0) > /dev/null

echo "Build temporary binary"
scons $BUILD_OPTS p=windows tools=yes module_mono_enabled=yes mono_glue=no
echo "Generate glue sources"
./bin/godot.windows.tools.64.mono --generate-mono-glue modules/mono/glue

### Build binaries normally
echo "Editor...."
scons $BUILD_OPTS p=windows target=release_debug tools=yes module_mono_enabled=yes vsproj=yes
echo "Templates"
#scons $BUILD_OPTS_EXPORT p=windows target=debug tools=no module_mono_enabled=yes
#scons $BUILD_OPTS_EXPORT p=windows target=release tools=no module_mono_enabled=yes

popd > /dev/null
