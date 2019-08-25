# R 进行数据库操作
# install.packages('RMySQL')  # 安装 RMySQL 包
library(RMySQL)
conn <- dbConnect(MySQL(), dbname = "r_study", username="akigaze", password="akigaze", host="127.0.0.1", port=3306)
# dbConnect() 创建连接，其中host和port参数可以省略使用默认值
users <- dbGetQuery(conn, "SELECT * FROM r_user")
# dbGetQuery() 通过指定数据库连接，执行SQL语句
dbDisconnect(conn) # 关闭数据库连接
users