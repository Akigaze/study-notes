## [Python Excel](http://www.python-excel.org/)

相关包：**[xlrd](<https://xlrd.readthedocs.io/en/latest/>)** , **xlwt**

## 1 xlrd

**xlrd** 模块主要用于读取excel文件的信息和数据，使用的文件类型有：`xls` `xlsx`

#### 1.1 引用模块

```python
import xlrd
```

#### 1.2 打开Excel工作簿(Workbook)

函数：`xlrd.open_workbook()`

返回值：`Book` 对象

参数：

- filename=None
- logfile=<_io.TextIOWrapper name='<stdout>' mode='w' encoding='UTF-8'>
- verbosity=0
- use_mmap=1
- file_contents=None
- encoding_override=None
- formatting_info=False
- on_demand=False
- ragged_rows=False

#### 1.3 获取工作表(Sheet)

一个Excel文件可能包含多个工作表，所以要选择某一个进行操作

工作表的类是 `Sheet` ，可以通过 `Book` 对象获得

- `.sheet_by_index(index)` : 根据索引获取
- `.sheet_by_name("name")` : 根据工作表名称获取
- `.sheets()` : 获得所有工作表对象的一个list
- `.sheet_names()` : 获取所有工作表名称的list
- `.nsheets` : 获取工作表的数量

#### 1.4 获取工作表信息

通过 `Sheet` 对象，可以获取工作表的信息

- `.name` : 获取表名

- `.nrow` `.ncol` : 行数，列数

- `.row_values(index, start_colx=0, end_colx=None)` : 获取整行数据，返回一个list

- `.col_values(index, start_rowx=0, end_rowx=None)` : 获取整列数据，返回一个list
- `.cell(rowx, colx)` : 获取指定单元格的 `Cell` 对象
- `.cell_type(rowx, colx)` `.cell_value(rowx, colx)` : 获取某个单元格的数据类型或值

- `.row(index)` `.col(index)` : 获取一行的`Cell` 列表，或一列的`Cell` 列表
- `.col_slice(colx, start_rowx=0, end_rowx=None)` `row_slice(rowx, start_colx=0, end_colx=None)`
- `.row_types(index, start_colx=0, end_colx=None)` `.col_types(colx, start_rowx=0, end_rowx=None)`

#### 1.5 单元格对象(Cell)

单元格对应的类是 `Cell` ，一个 `Cell` 对象有三个属性：

- `value` : 对应单元格的值

- `ctype` : 对应单元格数据的类型，是一个int，可以通过 `xlrd` 对象获取相对于的常量，mapping关系如下：

  | Type symbol     | Type number | Python value                                                 |
  | --------------- | ----------- | ------------------------------------------------------------ |
  | XL_CELL_EMPTY   | 0           | empty string ''                                              |
  | XL_CELL_TEXT    | 1           | a Unicode string                                             |
  | XL_CELL_NUMBER  | 2           | float                                                        |
  | XL_CELL_DATE    | 3           | float                                                        |
  | XL_CELL_BOOLEAN | 4           | int; 1 means TRUE, 0 means FALSE                             |
  | XL_CELL_ERROR   | 5           | int representing internal Excel codes; for a text representation, refer to the supplied dictionary error_text_from_code |
  | XL_CELL_BLANK   | 6           | empty string ''. Note: this type will appear only when open_workbook(..., formatting_info=True) is used. |

- `xf_index` : 当 打开的Excel表的 ``formatting_info`  参数为 `False` 时，该值为 `None`

# Link

#### [Python操作excel的几种方式--xlrd、xlwt、openpyxl](<http://wenqiang-china.github.io/2016/05/13/python-opetating-excel/>)

