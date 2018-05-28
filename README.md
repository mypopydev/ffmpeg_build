

#### Related git repos

libva/libva-utils/media-driver/gmmlib/ffmpeg

* git clone https://github.com/intel/libva.git libva

* git clone https://github.com/intel/libva-utils.git libva-utils

* git clone https://github.com/intel/media-driver.git media-driver

* git clone https://github.com/intel/gmmlib.git gmmlib

* git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg

####  FATE

If you want to run FATE on your machine you need to have the samples in place. You can get the samples via the build target fate-rsync. Use this command from the top-level source directory:

* make fate-rsync SAMPLES=fate-suite/

#### Dependencies

 These are packages required for compiling, but you can remove them when you are done if you prefer:

FFmpeg dependencies:

* sudo apt-get update -qq && sudo apt-get -y install \
  autoconf \
  automake \
  build-essential \
  cmake \
  git \
  libass-dev \
  libfreetype6-dev \
  libsdl2-dev \
  libtool \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  pkg-config \
  texinfo \
  wget \
  zlib1g-dev

media-driver dependencies:

* sudo apt install libdrm-dev xorg xorg-dev libx11-dev libgl1-mesa-glx libgl1-mesa-dev

####  Build and Install

1. build libva(VA-API)/libva-utils

* $ ./configure && make -j `nproc` && sudo make install

2. build media-driver

* Get gmmlib and media repo and format the workspace folder as below (suggest the workspace to be a dedicated one for media driver build):

```
<workspace>
    |- gmmlib
    |- media-driver
```

* mkdir <workspace>/build

cd <workspace>/build and run cmake like this:

* cmake ../media-driver \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DMEDIA_VERSION="2.0.0" \
    -DBUILD_ALONG_WITH_CMRTLIB=1 \
    -DBS_DIR_GMMLIB=`pwd`/../gmmlib/Source/GmmLib/ \
    -DBS_DIR_COMMON=`pwd`/../gmmlib/Source/Common/ \
    -DBS_DIR_INC=`pwd`/../gmmlib/Source/inc/ \
    -DBS_DIR_MEDIA=`pwd`/../media-driver

 * make -j `nproc` && sudo make install
