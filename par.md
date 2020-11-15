# Aspect Ratio 简介

## 1. 介绍几个缩写
- **DAR** : (`Display Aspect Ratio`) ：The aspect ratio of an image or video is defined as the ratio of its  width to its height. It is expressed in the form of a ratio, such as  16:9, or as a single value, in this case 16 ÷ 9 = 1.778. This is the  aspect ratio of a Widescreen TV, which has a width that is 1.778 times  that of its height. Older types of TV, referred to as Standard TV, used  an aspect ratio of 4:3 = 1.333. In other words, video is displayed on TV with a **DAR** (Display Aspect Ratio) of 16:9 or 4:3. 

- **PAR** : (`Pixel Aspect Ratio`) : 

- **SAR** : (`Storage Aspect Ratio` or `Sample Aspect Ratio`) `Sample Aspect Ratio` equal to `PAR`,

- **FAR** : (`Frame Aspect Ratio` = `Storage Aspect Ration`, the dimensions of the video frame by *pixel number*) : For example, in Europe and Australia, the PAL system is used. It has a  frame of 720 pixels wide by 576 high（1.25 or 5:4）. In the USA, the NTSC system is  used, with frames being 720 by 480 pixels （1.50 or 3:2 ）

  **DAR = FAR x PAR**

Q:  how to playing PAL frames on a 16:9 screen?