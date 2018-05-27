#!/bin/sh

set -x
if [ -n "$1" ]; then
    export export INSTALL_DIR=$1
else
    export INSTALL_DIR="/home/barry/Sources/umd_dev/install"
fi

export VAAPI_PREFIX="${INSTALL_DIR}"
#export LIBYAMI_PREFIX="${YAMI_ROOT_DIR}/libyami"
ADD_PKG_CONFIG_PATH="${VAAPI_PREFIX}/lib/pkgconfig/"
ADD_LD_LIBRARY_PATH="${VAAPI_PREFIX}/lib/"
ADD_PATH="${VAAPI_PREFIX}/bin/"

PLATFORM_ARCH_64=`uname -a | grep x86_64`
if [ -n "$PKG_CONFIG_PATH" ]; then
    export PKG_CONFIG_PATH="${ADD_PKG_CONFIG_PATH}:$PKG_CONFIG_PATH"
elif [ -n "$PLATFORM_ARCH_64" ]; then
    export PKG_CONFIG_PATH="${ADD_PKG_CONFIG_PATH}:/usr/lib/pkgconfig/:/usr/lib/x86_64-linux-gnu/pkgconfig/"
else 
    export PKG_CONFIG_PATH="${ADD_PKG_CONFIG_PATH}:/usr/lib/pkgconfig/:/usr/lib/i386-linux-gnu/pkgconfig/"
fi

export LD_LIBRARY_PATH="${ADD_LD_LIBRARY_PATH}:$LD_LIBRARY_PATH"

export PATH="${ADD_PATH}:$PATH"
export LIBVA_DRIVERS_PATH=${INSTALL_DIR}/lib/dri/
export LIBVA_DRIVER_NAME=iHD

echo "*======================current configuration============================="
echo "* VAAPI_PREFIX:               $VAAPI_PREFIX"
#echo "* LIBYAMI_PREFIX:             ${LIBYAMI_PREFIX}"
echo "* LD_LIBRARY_PATH:            ${LD_LIBRARY_PATH}"
echo "* PATH:                       $PATH"
echo "*========================================================================="

echo "* libva & libva-utils:      git clean -dxf && ./autogen.sh --prefix=\$VAAPI_PREFIX && make -j8 && make install"
echo "* ffmpeg:     git clean -dxf && ./configure --prefix=\$VAAPI_PREFIX && make -j8 && make install"
#echo "* libyami & utils:    git clean -dxf && ./autogen.sh --prefix=\$LIBYAMI_PREFIX && make -j8 && make install"
set +x
