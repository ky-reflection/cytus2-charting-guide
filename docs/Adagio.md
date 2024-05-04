# 概览：流程介绍与准备工作

## 制谱流程

偶遇一首激发了你创作欲的乐曲，到谱面完成、上架[Cytoid社区](https://cytoid.io)，有哪些步骤？

- 获取音频，测定BPM，处理音频，以得到正确的文件格式和长度。
- 准备一张合适的曲绘，记录音频和曲绘的metadata(作者、发布路径等)。
- 使用制谱器创作谱面。*~~这听起来很轻松~~*
- 打包和发布谱面。

## 环境

在这里，我会列出你可能需要的大部分软件，你需要提前准备好这些软件以及其运行环境，并对软件的使用有一定程度的了解。

几乎所有相关软件的使用文档或教程视频都能够在互联网上获取。一部分软件资源可以在Cytoid官方群群文件找到。

我会在附录中举例介绍一些软件的使用方法和注意事项，可供参考。

### 音频处理

免费开源的[Audacity](https://www.audacityteam.org/) 或Fl Studio、Adobe Audition等，可以使用[格式工厂](http://www.pcfreetime.com/formatfactory/CN/index.html)辅助格式转换。

### BPM测定

[MixMeister BPM Analyzer](https://www.mixmeister.com/bpm-analyzer.html) 或其他可以测定BPM的软件、网站（如TimingAnlyz、[BPM查询器](https://vocalremover.org/zh/key-bpm-finder)） 。

### 制谱软件

**Cylheim** （从[Microsoft Store](https://www.microsoft.com/zh-cn/p/cylheim/9pcczswg973k)或[Github](https://github.com/Horiztar/Cylheim-Windows/releases)获取，使用方法参见[wiki](https://github.com/Horiztar/Cylheim-Windows/wiki)和[视频教程](https://www.bilibili.com/video/BV1Ly4y1m7Np)）

![image-20230316114102079](Adagio.assets/image-20230316114102079.png)

## 音频处理

### 格式

获取的音频文件通常为MP3或FLAC格式，推荐在制作谱面和打包时使用OGG格式的音频文件。

WAV格式的音频同样适用于制作谱面，但由于其较高的空间占用，不建议在打包发布时使用。基于同样的理由，打包时应避免使用高码率的音频。

!!! warning "关于MP3格式"
    请注意，MP3格式的音频文件很可能导致延迟变化，在Cylheim和Cytoid中的表现不稳定，**请勿使用**。

### BPM

在CytusⅡ谱面中，速度和乐曲的BPM（beats per minute）强相关，其值通常为BPM的$2^n$​​倍。你可以使用MixMeister BPM Analyzer测定乐曲BPM，也可以通过其他途径寻找参照。某些网站会提供乐曲的BPM信息（如[sdvx.in](https://sdvx.in/)），还可以通过BMS格式的谱面获取BPM（推荐[BMS SEARCH](https://bmssearch.net/)和[iBMSC](https://www.cs.mcgill.ca/~ryang6/iBMSC/)）。

你也可以手动测量BPM，具体操作是在音频处理软件中测算乐曲小节的长度，然后换算到对应的BPM值。

如果乐曲中存在变化的BPM，你可以查找其他音游相关谱面的BPM表，或者手动测量。

请不要使用错误或误差较大的BPM制作谱面。

!!! info "BPM及相关概念"
    这里引用了[Cytus II 谱面格式详解](https://cytoid.wiki/zh/charting/chart-json.html)的部分内容。
    
    - BPM ：beats per minute，每分钟节拍数。
    - Tick ：Cytus II 谱面采用的重要单位，用于对元素进行时间定位。
    - TimeBase ：时基，表示一拍的 Tick 长度，默认为480。
    - Tempo ：速度，表示一拍的持续时间。Cytus II 谱面中记录当前速度的属性。
        - Tempo 和 BPM 存在转换关系 
        $$ \text{Tempo}=60,000,000 \div \text{BPM}$$
        其中 60,000,000 指的是一分钟的微秒长度。
    - 换算
        - Tick 不能独立决定时间尺度，它需要结合时基和速度进行计算。
        - 通过例子来理解：假设从第 0 Tick 开始，TimeBase 是 480 ，Tempo 是 500,000 ，那么我们试求第 1,200 Tick 对应的时间：
        $$ 1,200\div480 \times 500,000 = 1,250,000 \text{ μs} = 1,250 \text{ ms}$$
        结果是 1,250 毫秒。
        - 对该计算再进行解释：根据前文提到 TimeBase 含义，$1,200 \div 480 = 2.5$ ，即第 1,200 Tick 对应第 2.5 拍。再结合 Tempo 每拍时长，就能通过 $2.5\times500,000$ 求出该 Tick 求出对应时间。

### 重拍对齐

如果你对CytusⅡ的谱面有所认识，你会意识到谱面和乐曲的小节是相关的，页面边缘对应小节线。
你需要正确处理音频，**让乐曲的第一个重拍落在页面边缘**。这个步骤也叫对齐**起拍点**。

每个页面的时间为
$$
t=\frac {120} {Scanline\ speed} \rm s
$$

${Scanline\ speed}$为当前扫描线速度。你需要在音频处理软件中定位第一个重拍的位置，通过在开头增加或减少空白的方式，使得第一个重拍的时间为$t$的整数倍（至少两倍）。

- 乐曲的第一个音可能是弱拍，不是完整小节的开始（参阅：[弱起小节](https://zhuanlan.zhihu.com/p/89747708)），你需要向后寻找一个可参考的重拍，可以考虑节奏鲜明的鼓。同理，如果你在乐曲的开头找不到良好的参照，也可以向后寻找重拍。计算时需要留意第一个音的位置。
  CytusⅡ扫描线出现动画需要一整页来播放，请确保你的第一个音（或第一个note）在第二页或之后。
- **不推荐**调整页长或速度来代替音频处理的做法。
- Cylheim自带的延迟调整仅供播放预览使用，不写入谱面属性，使用它来调整延迟会导致最终产出的谱面有严重的延迟问题。
- 导出音频时请注意格式。

> 如何理解公式$t=\frac {120} {Scanline\ speed}\rm s$？
> 对于初学者，Scanline speed可能不是一个显然的值。这里需要区分的概念是**线速**${Scanline\ speed}$和**速度**$Tempo$。Tempo与BPM相关，和**页长**一起决定了前者。
> 如果你已经阅读过Cylheim的教程，你会意识到Cylheim中对变拍、半速导致的线速变化应该使用改变**页长**$Page\ size$​来处理。当页长为默认值960 tick时，扫描线速度为当前BPM对应的正常值。当页长加倍时，线速减半，而BPM不变。如果你的谱面以半速开始，你填入的Scanline speed应该为BPM的两倍。（四拍子正常线速的情况下，一拍对应480tick，一页对应两拍）
> 对于并非四拍子的乐曲，以三拍子为例，常用的页长将是720tick和1440tick。此时换算线速可能存在困难，不过你可以将线速、页长和时间的关系与速度、位移和时间类比，进行相应的计算。这里我提供另一个可以使用的算式：
> $$
> \frac{60\times拍}{bpm}秒
> $$
> 在重拍前留空这一数值或其整数倍的空白是合适的。

$$
Scanline\ speed=\frac{BPM}{Page\ size}\times960
$$



### 剪歌

音游曲的长度一般介于90秒和180秒，过长或过短的音频会影响谱面的创作和游玩体验。
不同于音频处理（调整空白长度使得起拍点对齐页面边缘），剪歌时你可以剪去一些段落，在不影响乐曲结构的情况下减少长度。重复段或复现的段落都可以作为剪歌的切入点，也可以通过叠加过渡音轨的方式减弱拼接感。
剪歌是相对困难的，需要你对乐曲有一定理解，这里我不详细展开。
可供参考的实例有：Arcaea对Tempestissimo的处理（[cut](https://www.bilibili.com/video/BV1tt4y1C7BG/)	[uncut](https://www.bilibili.com/video/BV1Yy4y1v7jC/)）

### 其他注意事项

- 打包发布时需要一段15秒左右的预览音频，建议截取较突出的段落，可以加上淡入和淡出。
- 不是所有的乐曲都适合CytusⅡ谱面的表现形式，请自行甄别。
- 请**避开**有版权问题的乐曲，如Cytus、Cytus Ⅱ收录曲、Arcaea版权曲等。如果你已经完成了谱面，请不要在社区公开。
- 部分曲师不允许使用他们的作品进行自制。
- 再次强调，不要使用码率过高的音频和无损格式。

## 曲绘

- 为你的谱面选择一张背景图，推荐4：3或16：9的长宽比，分辨率适中。
- 可以是单曲/专辑封面，也可以是题材相关的内容。
- 记录画师、曲绘URL等信息。
- 图片格式应为JPG或PNG，分辨率适中。

## 开始制谱

检查你的工程文件夹，现在你应该有一份对齐了起拍点、有BPM信息的OGG格式音频，有一张曲绘，可能有一份预览音频。
你可以进入Cylheim，按照教程中介绍的方法创建一个项目，添加一个谱面，填写相关信息。

有关文件处理的讲解到此结束，我们可以开始写谱了。