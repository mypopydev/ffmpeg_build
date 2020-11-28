# Aspect Ratio 简介

## 1. 介绍几个缩写

三个Apsect Ratio

- 描述显示：
- 描述图像：图像的宽高比，以Pixel为单位
- 描述单个Pixel：正方形 or 长方形

- **DAR** : (`Display Aspect Ratio`) ：The aspect ratio of an image or video is defined as the ratio of its  width to its height. It is expressed in the form of a ratio, such as  16:9, or as a single value, in this case 16 ÷ 9 = 1.778. This is the  aspect ratio of a Widescreen TV, which has a width that is 1.778 times  that of its height. Older types of TV, referred to as Standard TV, used  an aspect ratio of 4:3 = 1.333. In other words, video is displayed on TV with a **DAR** (Display Aspect Ratio) of 16:9 or 4:3. 

   ![comp_vs_mobile](/home/barry/Sources/ffmpeg_build/images/comp_vs_mobile.png)

- **PAR** : (`Pixel Aspect Ratio` or `Picture Aspect Ratio`, `Picture aspect ratio` is also called `Display Aspect Ratio` (DAR).) :  `Pixel Aspect Ratio` expressed as a fraction of horizontal (x) pixel size divided by vertical (y) pixel size. The `pixel aspect ratio` for square pixels is 1/1. In most cases, the PAR will be set equal to 1.0 and the frame (Resize)  set to match the screen of the target device. However, for conversions  relating to TV, things are different. For example, the values of Aspect  Ratio (AR) used in movies for standard TV are as follows. For PAL, the video frames are normally 720x576 pixels, i.e., have a  Frame AR of 5:4 (= 720 ÷ 576) and need a Pixel AR of 64:45 (= 1.4222...) to achieve a display of 16:9 and a PAR of 16:15 (1.0666...) for a  display in 4:3. For NTSC, the frames are 720x480, with a Frame AR = 3:2  and, thus, require a Pixel AR of 32:27 (= 1.185185...) to achieve a  display of 16:9 and a PAR of 8:9 (0.888...) for 4:3. Thus, we have:
   \* for PAL, its FAR = 5:4 and PAR = 16:15 (~1.07) for a 4:3 display or 64:45 (~1.42) for a 16:9 display
   \* for NTSC, its FAR = 3:2 and PAR = 8:9 (~0.89) or 32:27 (~1.19).

  A pixel is a pixel, it is a small block of color information. However, some playback devices have different shaped pixels than others. **Computer monitors** have `square pixels` and hence everything that is designed for display on a monitor should have a PAR of 1. **TVs** however have `rectangular pixels` which have a different PAR depending on the format (NTSC or PAL).
  
  
  | `square pixels`                                                | `rectangular pixels`                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
  | ![](/home/barry/Sources/ffmpeg_build/images/220px-PAR-1to1.svg.png) | ![](/home/barry/Sources/ffmpeg_build/images/220px-PAR-2to1.svg.png) |


- **SAR** : (`Storage Aspect Ratio` or `Sample Aspect Ratio`) `Sample Aspect Ratio` equal to `Pixel Aspect Ratio`, `Storage Aspect Ratio` equal to `Picture Aspect Ratio` TODO

- **FAR** : (`Frame Aspect Ratio` = `Storage Aspect Ratio`, the dimensions of the video frame by *pixel number*) : For example, in Europe and Australia, the PAL system is used. It has a  frame of 720 pixels wide by 576 high（1.25 or 5:4）. In the USA, the NTSC system is  used, with frames being 720 by 480 pixels （1.50 or 3:2 ）

  **DAR = FAR x PAR** or **DAR = SAR x PAR**

Q:  How to playing PAL frames on a 16:9 screen?

Q: Aspect Ratio 和 Screen resolution 是什么关系?

## 2. 考虑缩放(scale or resize)和crop

Here’s a quick breakdown of all the ideal aspect ratios for major social media platforms:

- **Facebook:** 16:9 or 9:16 (max upload 4k - 3840 x 2160)
- **Instagram:** 16:9 or 9:16 (max upload 1080p)
- **Twitter:** 16:9 (max upload 1080p)
- **Snapchat:** 9:16 (1080 x 1920)
- **YouTube:** 16:9 (max upload 4k - 3840 x 2160)

https://docs.microsoft.com/en-us/windows/win32/medfound/picture-aspect-ratio

Scale + PAD

Sometimes the video image does not have the same shape as the display area. For example, a 4:3 video might be shown on a widescreen (16×9)  television. In computer video, the video might be shown inside a window  that has an arbitrary size. In that case, there are three ways the image can be made to fit within the display area:

![aspect-ratio01](/home/barry/Sources/ffmpeg_build/images/aspect-ratio01.png)

- Stretch the image along one axis to fit the display area. (Stretching the image to fit the display area is almost always wrong,  because it does not preserve the correct picture aspect ratio.)

- Scale the image to fit the display area, while maintaining the original picture aspect ratio.

- Crop the image.

method like:

- **Letterboxing**
Transform a video file with 16:9 aspect ratio into a video file with 4:3 aspect ration by correct letter-boxing.
```
    ffmpeg \
        -i input_file \
        -filter:v "pad=iw:iw*3/4:(ow-iw)/2:(oh-ih)/2" \
        -c:a copy \
        output_file
```
![aspect-ratio02](/home/barry/Sources/ffmpeg_build/images/aspect-ratio02.png)
- **Pillarboxing**
Transform a video file with 4:3 aspect ratio into a video file with 16:9 aspect ration by correct pillar-boxing.
```
    ffmpeg \
        -i input_file \
        -filter:v "pad=ih*16/9:ih:(ow-iw)/2:(oh-ih)/2" \
        -c:a copy \
        output_file
```
![aspect-ratio03](/home/barry/Sources/ffmpeg_build/images/aspect-ratio03.png)
- **Windowboxing**

  ![vidWindowboxing](/home/barry/Sources/ffmpeg_build/images/vidWindowboxing.jpg)

- **Pan-and-Scan**![aspect-ratio04](/home/barry/Sources/ffmpeg_build/images/aspect-ratio04.png)

## 3. FFmpeg 中的处理

FFmpeg 使用 SAR （`Sample Aspect Ratio`）和 DAR （`Display Aspect Ratio`）

## 4. 什么地方存储了 Aspect Ration (Codec bit stream or Container)

### 4.1 MP4
- tkhd box -- `Matrix` 可以用来表征rotate
- ares box
- pasp  (`Pixel Aspect Ratio`) box

### 4.2 VUI

HEVC SPEC 中关于 SAR (`Sample Aspect Ratio`) 语法元素的描述如下：

|           vui_parameters(){           | Descriptor |
| :-----------------------------------: | :--------: |
|    aspect_ratio_info_present_flag     |    u(1)    |
|  if(aspect_ratio_info_present_flag){  |            |
|           aspect_ratio_idc            |    u(8)    |
| if(aspect_ratio_idc == EXTENDED_SRA){ |            |
|               sar_width               |   u(16)    |
|              sar_height               |   u(16)    |
|                   }                   |            |
|                   }                   |            |

上面提到的 SAR 语法元素的语义如下：

- aspect_ratio_info_present_flag 值为 1，指定`aspect_ratio_idc`在码流中存在；否则该语法元素不存在。
- aspect_ratio_idc 指定亮度采样的`SAR`的值。下面的表格展示它的含义。当`aspect_ratio_idc`值为 255，表明`EXTENDED_SRA`时，`SAR`的值 等于`sar_width:sar_height`。当`aspect_ratio_idc`语法不存在时，该值可以被认为是 0。`aspect_ratio_idc`的范围是`17-254`时，未使用，并且不该出现在码流中，此时解码器可以指定为 0。
- sar_width 表示`SAR`的水平大小。
- sar_height 表示`SAR`的竖直大小。
   `sar_width`和`sar_height`等于0、或`aspect_ratio_idc`等于0时，SPEC 未定义它的行为。

| asepct_ratio_idc | Sample aspect ratio | Examples of use(informative)                     |
| :--------------: | :-----------------: | ------------------------------------------------ |
|        0         |     Unspecified     |                                                  |
|        1         |    1:1(“square”)    | 7680x4320 16:9 frame without horizontal overscan |
|        2         |        12:11        | 720x576 4:3 frame without horizontal overscan    |
|        3         |        10:11        | 720x480 4:3 frame without horizontal overscan    |
|        4         |        16:11        | 720x576 16:9 frame without horizontal overscan   |
|        …         |          …          | …                                                |
|        16        |         2:1         | 960x1080 16:9 frame without horizontal overscan  |
|      17…254      |      Reserved       |                                                  |
|       255        |    EXTENDED_SAR     |                                                  |

## 5. 横屏(landscape `=`) 竖屏(portrait `||` )的转换

We will face at two equally unacceptable situations: the video player **does not apply the rotation metatag** contained into the video, or the video player adds **two lateral black bands**:

https://www.rigacci.org/wiki/doku.php/doc/appunti/linux/video/fix_smartphone_portrait_videos

## 6. 加上Rotate metadata 又怎样

- MPEG TS 没有ratate相关参数，MP4 有，所以 remux MP4 to TS，会丢失旋转信息
- MP4 在 tkhd