# test case for hwaccel

### 1. decode-only 

a). VAAPI: GPU decoder with VAAPI format output(for HW decoder performance test, 1080P input, (don't move the Frame to host CPU))
```
ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi -i input.mp4 -an -f null
```

b). QSV: GPU decoder with QSV format, than download to CPU (GPU decoding, then dump the YUV with NV12 format to host CPU)
```
ffmpeg -hwaccel qsv -c:v h264_qsv -i input.mp4 -vf hwdownload,format=nv12 output.yuv
```

### 2. HW decode + SW encode

a). VAAPI 
- GPU decoding with VAAPI format output (1080P input)
- Scale in GPU (scale_vaapi)
- Copy the Frame from GPU to CPU with NV12 format (hwdowload: GPU => CPU)
- encoding in CPU with libx264

```
ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi -i input.mp4 -vf 'scale_vaapi=w=640:h=360,hwdownload,format=nv12' -c:v libx264 -crf 20 output.mp4
```

b). QSV

- GPU decoding with QSV format output (1080P input)
- Copy the Frame from GPU to CPU with NV12 format (hwdowload: GPU => CPU)
- encoding in CPU with libx264

```
ffmpeg -hwaccel qsv -c:v h264_qsv -i input.mp4 -vf hwdownload,format=nv12 c:v libx264 -crf 20 output.mp4
```

### 3. HW decoder + HW encoder

a). VAAPI

```
ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi -i input.mp4 -c:v h264_vaapi -b:v 2M -maxrate 2M output.mp4
```

b). QSV

```
ffmpeg -hwaccel qsv -c:v h264_qsv -i input.mp4 -c:v h264_qsv -b:v 5M output.mp4
```


### 4. SW decoder + HW encoder (hwupload)

a). VAAPI
- SW decode with nv12 format output
- load NV12 frame to GPU with hwupload (CPU => GPU)
- encode with VAAPI in GPU

```
ffmpeg -vaapi_device /dev/dri/renderD128 -i input.mp4 -vf 'format=nv12,hwupload' -c:v h264_vaapi -qp 18 output.mp4
```

b). QSV

- init HW device 
- setting filter hw device
- load YUV to GPU with hwupload (CPU => GPU)
- encode with QSV in GPU

```
ffmpeg -init_hw_device qsv=hw -filter_hw_device hw -f rawvideo -pix_fmt yuv420p -s:v 1920x1080 -i input.yuv -vf hwupload=extra_hw_frames=64,format=qsv -c:v h264_qsv -b:v 5M output.mp4
```


### 5. FFmpeg HW API test case

a).  [doc/examples/hw_decode.c](https://github.com/FFmpeg/FFmpeg/blob/master/doc/examples/hw_decode.c)  (HW decoding, then copy the HW Frame to CPU), I think for hwdownload case, you can use this example as start point

b).  [doc/examples/vaapi_transcode.c](https://github.com/FFmpeg/FFmpeg/blob/master/doc/examples/vaapi_transcode.c)

c).  [doc/examples/vaapi_encode.c](https://github.com/FFmpeg/FFmpeg/blob/master/doc/examples/vaapi_encode.c)

### 6.  HWdevice

```

av_hwdevice_ctx_create()  ,then attach the hwdevice_ctx to AVCodecContext
 |
 +---->  ret = device_ctx->internal->hw_type->device_create(device_ctx, device, opts, flags);
 |
 +-----> ret = av_hwdevice_ctx_init (device_ref); // ctx->internal->hw_type->device_init()

```

in  [doc/examples/hw_decode.c](https://github.com/FFmpeg/FFmpeg/blob/master/doc/examples/hw_decode.c) 


``` c
static int hw_decoder_init(AVCodecContext *ctx, const enum AVHWDeviceType type)
{
    int err = 0;

    if ((err = av_hwdevice_ctx_create(&hw_device_ctx, type,
                                      NULL, NULL, 0)) < 0) {
        fprintf(stderr, "Failed to create specified HW device.\n");
        return err;
    }
    ctx->hw_device_ctx = av_buffer_ref(hw_device_ctx);
    
    return err;
}
```