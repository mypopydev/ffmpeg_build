# Aspect Ratio 简介

## 1. 介绍几个缩写
- **DAR** : (`Display Aspect Ratio`) ：The aspect ratio of an image or video is defined as the ratio of its  width to its height. It is expressed in the form of a ratio, such as  16:9, or as a single value, in this case 16 ÷ 9 = 1.778. This is the  aspect ratio of a Widescreen TV, which has a width that is 1.778 times  that of its height. Older types of TV, referred to as Standard TV, used  an aspect ratio of 4:3 = 1.333. In other words, video is displayed on TV with a **DAR** (Display Aspect Ratio) of 16:9 or 4:3. 

- **PAR** : (`Pixel Aspect Ratio` or `Picture Aspect Ratio`) :  expressed as a fraction of horizontal (x) pixel size divided by vertical (y) pixel size. The `pixel aspect ratio` for square pixels is 1/1. In most cases, the PAR will be set equal to 1.0 and the frame (Resize)  set to match the screen of the target device. However, for conversions  relating to TV, things are different. For example, the values of Aspect  Ratio (AR) used in movies for standard TV are as follows. For PAL, the video frames are normally 720x576 pixels, i.e., have a  Frame AR of 5:4 (= 720 ÷ 576) and need a Pixel AR of 64:45 (= 1.4222...) to achieve a display of 16:9 and a PAR of 16:15 (1.0666...) for a  display in 4:3. For NTSC, the frames are 720x480, with a Frame AR = 3:2  and, thus, require a Pixel AR of 32:27 (= 1.185185...) to achieve a  display of 16:9 and a PAR of 8:9 (0.888...) for 4:3. Thus, we have:
   \* for PAL, its FAR = 5:4 and PAR = 16:15 (~1.07) for a 4:3 display or 64:45 (~1.42) for a 16:9 display
   \* for NTSC, its FAR = 3:2 and PAR = 8:9 (~0.89) or 32:27 (~1.19).

  A pixel is a pixel, it is a small block of color information. However, some playback devices have different shaped pixels than others. **Computer monitors** have `square pixels` and hence everything that is designed for display on a monitor should have a PAR of 1. **TVs** however have `rectangular pixels` which have a different PAR depending on the format (NTSC or PAL).
  
  
  | `square pixels`                                                | `rectangular pixels`                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
  | ![](/home/barry/Sources/ffmpeg_build/images/220px-PAR-1to1.svg.png) | ![](/home/barry/Sources/ffmpeg_build/images/220px-PAR-2to1.svg.png) |


- **SAR** : (`Storage Aspect Ratio` or `Sample Aspect Ratio`) `Sample Aspect Ratio` equal to `Pixel Aspect Ratio`, `Storage Aspect Ratio` equal to `Pixel Aspect Ratio` 

- **FAR** : (`Frame Aspect Ratio` = `Storage Aspect Ratio`, the dimensions of the video frame by *pixel number*) : For example, in Europe and Australia, the PAL system is used. It has a  frame of 720 pixels wide by 576 high（1.25 or 5:4）. In the USA, the NTSC system is  used, with frames being 720 by 480 pixels （1.50 or 3:2 ）

  **DAR = FAR x PAR** or **DAR = SAR x PAR**

Q:  how to playing PAL frames on a 16:9 screen?

Q: Aspect Ratio 和 Screen resolution 是什么关系?

## 2. 考虑缩放(scale or resize)和crop

## 3. FFmpeg 中的处理

## 4. 什么地方存储了 Aspect Ration (Codec bit stream or Container)

