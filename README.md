

#### Related git repos

libva/libva-utils/media-driver/gmmlib/ffmpeg

1. git clone https://github.com/intel/libva.git

2. git clone https://github.com/intel/libva-utils.git

3. git clone https://github.com/intel/media-driver.git

4. git clone https://github.com/intel/gmmlib.git

5. git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg

####  FATE

If you want to run FATE on your machine you need to have the samples in place. You can get the samples via the build target fate-rsync. Use this command from the top-level source directory:

make fate-rsync SAMPLES=fate-suite/