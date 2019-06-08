## Python 图像处理

#### 相关包

- PIL
- Pillow

## PIL

`PIL` 模块中的 `Image` 子模块提供了对图像处理的方法

```python
from PIL import Image
```

使用 `open` 方法将一个图片文件读取到内存中，返回一个 `PIL.Image.Image` 对象

### 1. PIL.Image 方法

- `Image.open(fp, mode="r")`

### 2. PIL.Image.Image 对象方法

- `getpixel((x, y))` : 获取指定位置上的像素点，返回一个tuple，记录像素点的色值

### 3. PIL.Image.Image 对象属性

- `size` : 文件的长宽像素大小, (width, height)
- `mode` : 图片的色彩模式
- `info`
- `format` : 文件格式









## Link

#### [The Python Imaging Library Handbook](<http://www.effbot.org/imagingbook/>)

#### [Pillow Documentation](<https://pillow.readthedocs.io/en/stable/#>)

#### [Pillow Official](<https://python-pillow.org/>)

