## Python 图像处理

#### 相关包

- PIL
- Pillow

## PIL

### 1. Image 模块

`PIL` 模块中的 `Image` 子模块提供了对图像处理的方法

```python
from PIL import Image
```

使用 `open` 方法将一个图片文件读取到内存中，返回一个 `PIL.Image.Image` 对象

#### 1. PIL.Image 方法

- `Image.open(fp, mode="r")`
- `Image.new(mode, size, color=0)` : `mode` 为色彩模式，`size` 是一个tuple `(width, height)`

#### 2. PIL.Image.Image 对象方法

- `getpixel((x, y))` : 获取指定位置上的像素点，返回一个tuple，记录像素点的色值
- `save(filename)` : 将图像保存为图片，一般是使用 `Image.new` 创建的图像对象进行保存

#### 3. PIL.Image.Image 对象属性

- `size` : 文件的长宽像素大小, (width, height)
- `mode` : 图片的色彩模式
- `info`
- `format` : 文件格式

### 2. ImageDraw 模块

`PIL` 模块中的 `ImageDraw ` 子模块提供绘制2D图像的相关方法

```python
from PIL import ImageDraw 
```

`ImageDraw` 模块中的 `Draw` 类用于创建绘图对象进行绘图，它只提供了绘制图像的相关方法，图像的载体需要是一个 `Image` 对象

#### 1. ImageDraw方法

- `ImageDraw.Draw(img, mode=None)`

#### 2. Draw 对象方法

- `line(self, xy, fill=None, width=0, joint=None)` : 绘制线条的方法
  - `xy` : list ，按顺序将两个元素作为 (x, y) 的组合







## Link

#### [The Python Imaging Library Handbook](<http://www.effbot.org/imagingbook/>)

#### [Pillow Documentation](<https://pillow.readthedocs.io/en/stable/#>)

#### [Pillow Official](<https://python-pillow.org/>)

