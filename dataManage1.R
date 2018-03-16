# dataManage1
# 기초 데이터 관리

# 리더쉽에 관한 조사결과
# 성별에 따라 메니저의 리더쉽이 관계있나?
# 국적도 중요한 요인인가?
# 질문에 대한 평점은 1~5 까지 설정

manager <- c(1, 2, 3, 4, 5)
date <- c('10/24/14', '10/28/14', '10/01/14', '10/12/14', '05/01/14')
country <- c('US', 'US', 'UK', 'UK', 'UK')
gender <- c('M', 'F', 'F', 'M', 'F')
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors=F)

leadership

# 1) 새로운 속성(컬럼) 추가 : 다섯개의 평점을 결합
# 데이터 프레임에 새로운 열을 추가하려면
# $ 연산자 사용 or transform() 함수를 이용
mydata <- data.frame( x1 = c(2, 2, 6, 4),
                     x2 = c(3, 4, 2, 8) )

mydata

# sumx <- x1 + x2 # 총합 안됨
# meanx <- (x1 + x2) /2  # 평균 안됨

sumx <- mydata$x1 + mydata$x2 # 총합
sumx
meanx <- (mydata$x1 + mydata$x2) / 2  # 평균
meanx

# 데이터 프레임에 새로운 열 추가 : $
mydata$sumx <- mydata$x1 + mydata$x2 # 총합
mydata$meanx <- (mydata$x1 + mydata$x2) / 2  # 평균
mydata

# 새로운 열 추가 attach /detach 사용 (확인요)
rm(mydata)

mydata <- data.frame( x1 = c(2, 2, 6, 4),
                      x2 = c(3, 4, 2, 8) )

attach(mydata)
  mydata$sumx <- x1 + x2
  mydata$meanx <- (x1 + x2) / 2
detach(mydata)

mydata
rm(mydata)

mydata <- data.frame( x1 = c(2, 2, 6, 4),
                      x2 = c(3, 4, 2, 8) )

# 새로운 열 추가 : transform() 사용
mydata <- transform(mydata,
                    sumx = x1 + x2,
                    meanx = (x1 + x2) / 2)

mydata
rm(mydata)
mydata

# 2) 변수(컬럼)값 재작성
# 기존의 변수나 값을 기준으로 새로운 변수값을 생성
# 연속값을 가지는 변수를 3개의 카테고리로 나눔
# 잘못 작성된 값을 바른 값으로 대체
# 조건에 따라 통과/탈락 변수 생성
# ~20 약관
# ~30 청년
# ~40 블혹
# ~50 지천명
# ~60 이순
# ~70 고희
# ~80 산수
# ~90 졸수
# 99 백수

leadership$age_cate[leadership$age == 99] <- '백수'
leadership$age_cate[leadership$age <= 98] <- '졸수'
leadership$age_cate[leadership$age <= 89] <- '산수'
leadership$age_cate[leadership$age <= 79] <- '고희'
leadership$age_cate[leadership$age <= 69] <- '이순'
leadership$age_cate[leadership$age <= 59] <- '지천명'
leadership$age_cate[leadership$age <= 49] <- '블혹'
leadership$age_cate[leadership$age <= 39] <- '청년'
leadership$age_cate[leadership$age <= 29] <- '약관'
leadership

# within 을 이용해서 간결하게 작성
leadership <- within( leadership, {
  age_cate[age == 99] <- '백수'
  age_cate[age < 99] <- '졸수'
  age_cate[age < 90] <- '산수'
  age_cate[age < 80] <- '고희'
  age_cate[age < 70] <- '이순'
  age_cate[age < 60] <- '지천명'
  age_cate[age < 50] <- '블혹'
})

leadership

# 3) 컬럼명 변경 - 변수명이 맘에 안든다면 바꾸자!
fix(leadership) # 데이터 편집기를 이용
leadership

names(leadership) # 데이터 프레임의 이름출력
names(leadership)[2] <- 'newDate'
names(leadership)[6:10] <- c('q1', 'q2', 'q3', 'q4', 'q5')

# plyr 페키지를 이용해서 이름을 바꿔보자 : rename
install.packages('plyr')
library('plyr')
leadership <- rename( leadership, c(manager='managerID', newDate='examDate', country='nation') )

leadership

# 2018.02.28
# 4) 결측값(누락된 값) 처리
# 누락, 오류, 부적절한 데이터를 보안 - NA
# is.na()는 누락값 여부 확인

x <- c(1,2,3,NA)
is.na(x) # NA여부 확인, TRUE로 출력

is.na(leadership[,6:10]) # 설문조사항목에 대해 누락값 조사

# 누락값은 비교불가능 -> 비교연산자 사용불가
# 분석에서 누락값은 제외하는 것이 좋음

y <- x[1] + x[2] + x[3] + x[4]
# NA가 포함된 벡터에 산술연산을 하면?
z <- sum(x)

# na.rm=T 를 사용해서 누락값 제외
z <- sum(x, na.rm=T)

y
z

# NA가 있는 관측지를 아예 제거 - na.omit()
na.omit(leadership)

# 5) 날짜 데이터 다루기
# 현재 날짜/시간 출력 - Sys.Date(), Sys.time()
Sys.Date() # 년월일
Sys.time() # 날짜,  시간
date() # 날짜, 시간, 요일

# 날짜 데이터 입력할때는 보통 문자형식을 사용
# 경우에 따라 날짜로 검색하거나 계산해야 할 필요가 존재
# 따라서, 문자형식을 날짜 형식으로 변환해야 함
# as.Date() : 기번형식은 yyy-mm-dd
mydate <- c('2007-10-05', '2018-03-01')
mydate
class(mydate)
mydates <- as.Date( mydate )
mydates
class(mydates)


# 기본형식이 아닌 다른 형식의 날짜 데이터는
# 형식 지정자를 사용해서 변환 해야 함
-------------------------------------------------------------------------
manager <- c(1, 2, 3, 4, 5)
date <- c('10/24/14', '10/28/14', '10/01/14', '10/12/14', '05/01/14')
country <- c('US', 'US', 'UK', 'UK', 'UK')
gender <- c('M', 'F', 'F', 'M', 'F')
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors=F)
leadership
-------------------------------------------------------------------------

mydate <- c('01/05/2016', '08/16/1975')
mydates <- as.Date(mydate, '%m/%d/%Y')
mydates

fmt <- '%m/%d/%y' # %y는 2자리 년도
leadership$date <- as.Date(leadership$date, fmt)
leadership

# 날짜 변형 형식지정자 : 형식지정자 %m %d %y
today <- Sys.Date()
format(today, format='%m %b %B %Y %y')
format(today, format='%A %a %d %D')

# 날짜계산
sdate <- as.Date('1990-10-13')
edate <- as.Date('2018-02-28')
mydays <- edate - sdate
mydays

difftime( edate, sdate)
difftime( edate, sdate, units='weeks' )
difftime( edate, sdate, units='hours' )
difftime( edate, sdate, units='mins' )

# 형변환
# as.numeric() : is.numeric()
# as.character() : is.character()
# as.logical() : is.logical()
#as. vector() : is.vector()
# 날짜를 문자로 변환 - as.Character()
strDate <- as.character(edate)
strDate
class(strDate)

a <- c(1,2,3)
is.numeric(a)
class(is.numeric(a))
is.vector(a)
class(is.vector(a))

a <- as.character(a)
is.numeric(a)
class(is.numeric(a))
is.character(a)
class(is.character(a))

# 데이터 정렬 - order()
leadership[order(leadership$age), ]
leadership[order(leadership$gender, leadership$age), ]
leadership[order(leadership$gender, -leadership$age), ]

# 데이터 병합 -merge(), rbind()
# 데이터가 여러 위치에 존재한다면 이것을 결합해보자

# 열 추가하기 - 수평적 결합
# 조건 : 두개의 df를 결합하려면 공통의 키가 존재해야 함 : data.frame

meage(dfA, dfB, by='ID')
meage(dfA, dfB, by=c('ID', 'country'))

# id <- c(1:4)
id <- c(3:6)
fname <- c('park', 'kim', 'jeong', 'song')
pinfo1 <- data.frame(id, fname)

id <- c(5:7)
fname <- c('lim', 'yeon', 'park')
pinfo2 <- data.frame(id, fname)

id <- c(1,2)
fname <- c('seo', 'lee')
pinfo3 <- data.frame(id, fname)

merge(pinfo1, pinfo2, by='id') # inner join
merge(pinfo1, pinfo2, by='id', all=T) # outer join
merge(pinfo1, pinfo2, by='id', all.x=T) # left outer join
merge(pinfo1, pinfo2, by='id', all.y=T) # right outer join
# 2개의 df만 marge 할 수 있음 - marge(A,B,C) 는 불가

merge(pinfo1, pinfo3, by='id')
merge(pinfo2, pinfo3, by='id') # 결합시 행갯수와 이름이 일치!

# 근데, 키가 없다면?? -> cbind() 사용
cbind(pinfo1, pinfo3)
cbind(pinfo2, pinfo3)

# 행 추가하기 -rbind()
rbind(pinfo1, pinfo3)
rbind(pinfo2, pinfo3)

# 데이터 부분집합 만들기
# df[행, 열] 표기로 원소에 접근 가능
newdata <- leadership[, c(6:10)]
newdata

myvars <- c('q1','q2','q3','q4','q5')
nawdata <- leadership[myvars] # 열이름으로 추출
nawdata

# 문자열 이어붙이기 : paste
myvars <- paste('q', 1:5, sep='') # q1, q2, q3,...
newdata <- leadership[myvars]
newdata

paste('hello', 'world', '!!')
paste('hello', 'world', '!!', sep='-')
paste('hello', 'world', '!!', sep='')

# 변수 제외하기 : !, -, NULL
myvars <- names(leadership) %in% c('q3', 'q4')
# %in% : R 의 특수 연산자 - 특정값 포함 여부 검사
myvars

newdata <- leadership[myvars] # TRUE인 열만 출력
newdata <- leadership[!myvars] # FALSE인 열만 출력
newdata

newdata <- leadership[c(8,9)] # 8, 9열 출력
newdata
newdata <- leadership[c(-8,-9)]
newdata

leadership$q3 <- leadership$q4 <- NULL
leadership

# 관측치를 검색 후 선택

newdata <- leadership[1:3, ] #1,2,3행 출력
newdata

leadership[leadership$gender == 'M' & leadership$age > 30, ] # 성별=남자, 나이>30

attach()
detach()
with({})

-------------------------------------------------------------------------
manager <- c(1, 2, 3, 4, 5)
date <- c('10/24/14', '10/28/14', '10/01/14', '10/12/14', '05/01/14')
country <- c('US', 'US', 'UK', 'UK', 'UK')
gender <- c('M', 'F', 'F', 'M', 'F')
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors=F)
leadership
-------------------------------------------------------------------------
fmt <- '%m/%d/%y' # %y는 2자리 년도
leadership$date <- as.Date(leadership$date, fmt)
leadership

# 날짜 기간으로 검색
# 먼저, 문자형식을 날짜형식으로 변환
leadership$date <- as.Date(leadership$date, '%m/%d/%y')
stratdate <- as.Date('2014-01-01') # 검색기간도 날짜형식으로 작성
enddate <- as.Date('2014-05-31')

leadership

# which 함수 사용
which(
  leadership$date >= stratdate & leadership$date <= enddate
)

# 조건일치시 위치값 출
newdata <- leadership[which(
  leadership$date >= stratdate & leadership$date <= enddate
), ]

newdata

# mtcars 자료집합을 이용해서 which 사용하기
help('mtcars')
mtcars

# 변속기am가 자동0, 실린더cyl가 4인 자동차의 연비mpg 출력
attach(mtcars)
  which( am == 0 & cyl == 4)
  cardata <- mtcars[which(am == 0 & cyl == 4), 'mpg']
detach(mtcars)
cardata

which(
  mtcars$am == 0 & mtcars$cyl == 4
)

cardata <- mtcars[which(
  mtcars$am == 0 & mtcars$cyl == 4
), 'mpg']
cardata

# 위 사례들 보다 쉽게 부분 데이터 추출 - subset()
# 나이가 35 이상이거나 24 이하인 메니저의 1,2 문항 출력
newdata <- subset(leadership, age > 45 | age < 24, select=c(q1,q2))
newdata

# 성별이 남M이고, 나이가 25 이상인 매니저의
# 성별, 나이, q1, q2, q3, q4 문항 출력
newdata <- subset(leadership, age > 25, select=c(gender, age, q1, q2, q3, q4))
newdata <- subset(leadership, age > 25, select=c(gender:q4))
newdata <- subset(leadership, age > 25, select=gender:q4)
newdata

# 무작위 표본 추출 - sample : 비복원/복원 추출
sample(x=1:10) # 비복원 추출
sample(x=1:10, replace=T) # 복원추출

data <- c(1:10)
sample(x=data, 3)
sample(x=data, 3, replace=T)

# 행/열의 수 출력 :nrow(), ncol()
leadership[c(1,3,5), ]
nrow(leadership)
ncol(leadership)
mysample = leadership[sample(1:5 ,3), ]
mysample = leadership[sample(1:nrow(leadership) ,3), ]

mysample

# 데이터를 SQL처럼 사용하자! - sqldf
# sqldf는 SQL명령어 호출되면 자동으로 스키마 생성후
# 데이터를 테이블에 불러온 후 SQL문을 실행함
install.packages('sqldf')
library('sqldf')

remove.packages('sqldf')
remove.packages('RSQLite')

iris # 붓꽃3가지 종류에 대해 꽃받침, 꽃잎길이 정리
sqldf('select * from iris')
# 붓꽃 종을 출력 - 중복배제
sqldf('select distinct Species from iris')
unique(iris$Species)
iris[!duplicated(iris$Species),]
install.packages('dplyr')
library(dplyr)
distinct(iris$Species) # dplyr 패키지 필요!

sql <- "select count(Species) from iris where 'Petal.Width' > 0.5"
sqldf(sql)

sql <- 'select Species, avg("Sepal.Length") from iris group by "Species"'
sqldf(sql)

# 구글에서 제공하는 데이터집합 - Fruits
install.packages('googleVis')
library(googleVis)
Fruits

sqldf('select * from Fruits')
sqldf('select * from Fruits where Fruit = "Apples"')
sqldf('select * from Fruits limit 3')
sqldf('select * from Fruits order by Year')
sqldf('select sum(Sales), max(Sales) from Fruits')
sqldf('select Fruit, avg(Sales) from Fruits group by Fruit')

mtcars
