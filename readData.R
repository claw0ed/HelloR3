#readData.R

# 데이터를 외부로부터 가져오는 방법
# 1. 키보드로 입력 - edit(), fix()
# 작은 데이터 집합을 사용해야하는 경우 유용

smalldata <- data.frame( age=numeric(0), weight=numeric(0.0) )
smalldata <- edit(smalldata)
smalldata

# R 의 데이터 타입 : numeric, character, logical
manager <- data.frame( id=numeric(0), date=character(0), country=character(0), gender=character(0), age=numeric(0), q1=numeric(0), q2=numeric(0), q3=numeric(0), q4=numeric(0), q5=numeric(0) )
manager <- edit(manager)
manager

# 텍스트형태로 입력 - read.table()  함수를 사용
txtdata <- '
age weight
1 0.7
2 1.3
3 2.1
'

txtdata

smalldata <- read.table(header=T, text=txtdata)
smalldata

# 구분된 텍스트 파일에서 데이터 읽어오기
# read.table(파일명, 옵션)
sales <- read.table('c:/Java/sales.txt', sep=',', header=F)
# 컬럼이름을 의미하는 헤더가 없어서 임의의 컬럼명이 자동부여
sales <- read.table('c:/Java/sales.txt', sep=',', header=F, colClasses=c('character', 'numeric', 'numeric'))
# 파일로 읽어들이는 데이터의 자료유형 설정 - colClasses
# 읽어들이는 데이터의 유형과 정의한 자료유형은 일치해야 함
str(sales)
sales

?read.table

# students.txt
std <- read.table('c:/Java/students.txt', sep='\t', header=T)
str(std)
std

# stations.csv
stat <- read.table('c:/Java/stations.csv', sep=',', header=F)
str(stat)
stat

# SummerMedallists.txt
medal <- read.table('c:/Java/SummerMedallists.txt', sep='\t', header=T)
str(medal)
medal

# csv 파일 읽기
# read.csv(파일명, 옵션들...)

?read.csv
?read.csv2

stat = read.csv('c:/Java/stations.csv', sep=',', header=F)
stat = read.csv('c:/Java/stations.csv', sep=',', header=F, na.strings='')
str(stat)
stat

# 엑셀로 데이터 읽어오기
install.packages('readxl')
library('readxl')
medal <- read_excel('c:/Java/SummerMedallists.xlsx', sheet=1)
str(medal)
medal

# 또 다른 패키지 (xlsx)
Sys.setenv(JAVA_HOME='C:/Java/jdk1.8.0_152')
install.packages('rJava')
install.packages('xlsx')
library('xlsx')
medal <- read.xlsx('c:/Java/SummerMedallists.xlsx', sheetIndex=1)
str(medal)
medal

# html, xml 파일 읽어오기
install.packages('XML')
library('XML')
library('methods')
xmldata <- xmlParse('c:/Java/emp.xml')
xmldata
empdata <- xmlToDataFrame('c:/Java/emp.xml')
empdata

# JSON 형식으로 데이터 읽기
install.packages('jsonlite')
library('jsonlite')
install.packages('httr')
library('httr')

# jsondata <- fromJSON('c:/Java/primer-dataset.json') # 조금 이따가
jsondata <- fromJSON('https://api.github.com/users/hadley/repos')
str(jsondata)
names(jsondata) # JSON 데이터의 키를 출력

# 대용량 파일 읽어오기 fill=T 비어있는 열 채우기
zip <- read.table('c:/Java/서울특별시-2017.10.csv', sep=',', stringsAsFactors=F, header=T, fill=T)
head(zip)
str(zip)
zip

zip2 <- read.csv('c:/Java/서울특별시-2017.10.csv', sep=',', stringsAsFactors=F, header=T)
head(zip2)
str(zip2)
zip2

?read.table

install.packages('data.table')
library('data.table')

?fread

fread('c:/Java/서울특별시-2017.10.csv', sep=',', header=T, stringsAsFactors=F)

# 관계형 데이터베이스
# R에서는 RDBMS에서 데이터를 읽어올수 있는 다양한 환경 지원
# R <- MySQL
install.packages('RMySQL')
library('RMySQL')

mysqlconn = dbConnect(MySQL(), user='claw0ed', password='Abcdef_12', dbname='claw0ed', host='192.168.220.128')
str(mysqlconn)

dbListTables(mysqlconn) # 테이블목록 출력

empdata <- dbSendQuery(mysqlconn, 'select * from employees')
emp <- fetch(empdata)
# emp = dbGetQuery(mysqlconn, 'select * from employees')
str(emp)
emp

dbWriteTable(mysqlconn, '테이블명', 객체명, overwrite=T) # 데이터를 MySQL 테이블에 덮어쓰기

dbDisconnect(mysqlconn)

# R <- Oracle
Sys.setenv(JAVA_HOME='C:/Java/jdk1.8.0_152')
install.packages('DBI', dep=T)
install.packages('RJDBC', dep=T)
library('DBI')
library('RJDBC')
library('rJava')

drv <- JDBC('oracle.jdbc.OracleDriver', classPath='D:/Bigdata/JDBC/ojdbc7.jar')
oraconn <- dbConnect(drv, 'jdbc:oracle:thin:@192.168.220.128:1521:xe', 'hr', 'hr')

emp <- dbGetQuery(oraconn, 'select * from employees')
str(emp)

dbDisconnect(oraconn)

emp
