# 변수 - 알파벳, 숫자, _, . 으로 구성
# 첫 글자는 문자나 . 으로 시작할 것
a <- 1
b1 <- 2
.x <- 3
.x
# 3c <- 4 # 잘못된 변수명
# .4 <- 5 # 잘못된 변수명

# 변수할당 <-(추천!), <<-, = 이렇게 사용

# 변수명을 입력하면 값을 출력
a
b1
.x

# 데이터집합 : 행(관측값, 레코드, 사례), 열(변수, 필드, 속성)로 이루어진 2차원 배열

# R 에서 데이터를 생성하려면 스칼라, 벡터, 베열, 데이터프레임, 리스트 등의 다양한 자료구조를 사용
# R 에서 다룰수 있는 데이터 유형은 숫자, 문자, 논리, 복소수 등이 있음

# 벡터 : 숫자, 문자, 논리형 데이터들로 구성된 1차원 배열
# 스칼라 : 요소가 하나만 존재하는 벡터
# 벡터안의 자료는 반드시 단일 유형이어야 함

a <- 3 # 스칼라 유형
b <- 4.5
c <- a + b # 산술연산자 사용가능
d <- 'hello, world' # 문자형은 '', "" 로 묶어야 함

e <- c(1,2,3,4,5,-9,-8,-7,-6)
f <- c('one' ,'two' ,'three' ,'가' ,'나' ,'다')
g <- c(TRUE ,FALSE ,T ,F) # 논리값 (false ,true) 는 안됨@
h <- c("9", 8, "7") # 벡터는 단일 유형만 저장가능
i <- c(1, "2", 3) # 여러 유형 입력시 자동으로 형변환 일어남
j <- c(9, 8, 7, c(1, 2, 3)) # 벡터를 중첩으로 저장하면? - 1차원으로 자동변환
k <- 1:10 # 숫자 데이터의 경우 '시작값:끝값' 형테로 값 생성 가능
l <- seq(1, 10) #(시작, 끝, 간격) 함수
m <- seq(1, 10, 2)
n <- rep(1:2, 3) # rep(값, 반복) 함수
o <- rep(1:2, each=5)

e[3] # []를 이용해서 벡터/스칼라의 요소를 출력
e[-3] # 위치값이 음수라면? - 해당 요소(값)를 제외
e[c(1, 5, 7)] # 무작위 위치값을 벡터에 저장해서 검색
e[2:6] # 위치값을 범위로 지정 - '시작값:끝값'

?seq

seq(0, 1, length.out = 11)
seq(stats::rnorm(20)) # effectively 'along'
seq(1, 9, by = 2)     # matches 'end'
seq(1, 9, by = pi)    # stays below 'end'
seq(1, 6, by = 3)
seq(1.575, 5.125, by = 0.05)
seq(17) # same as 1:17, or even better seq_len(17)

seq(0, 1, by=0.001) # 두 명령어 간의 차이점은 무엇인가?
seq(0, 1, length.out=1000)

rep(1:10, each=3)
rep(1:10, time=3)

length(m)

# 비교 연산자 : <, >, != ==
ex <- c(1,3,5,7,9, NA) # 데이터 값이 존재하지 않을 경우 NA로 설정
ans <- ex < 5 # 연산자는 벡터의 각 원소간 연산을 지원
print(ans)

# 산술 연산자 : + - * %% %/%
ex - 5
ex %% 5 # 나머지 구함
ex %/% 5 # 정수 나누기 (나머지 버림)

# 논리 연산자 : &, |, !, &&, ||
c(T, F) & c(F, T) # 벡터의 각 원소간 연산 처리
c(T, F) && c(F, T) # 단일 논리값을 계산 (단축식 평가 지원)

ex[0] # 벡터의 위차값은 0이 아닌 1부터 시작
is.na(ex[6]) # 요소가 NA인지 검사

x <- NULL # 변수를 선언할 뿐 초기화하지 않는 경우 NULL 사용
is.null(x)
is.null(1)
is.null(NA)

# matrix : 벡터의 2차원 배열 - 동일한 유형의 원소들로 구성
# 1행은 숫자, 2행은 문자, 같은 구성 불가
# matrix(벡커, nrow=숫자, ncol=숫자)

a <- matrix(c(1,2,3,4,5,6,7,8,9), nrow=3)
b <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3)
a <- matrix(c(1,2,3,4,5,6,7,8,9), nrow=9)
b <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=9)

c <- matrix(1:20, nrow=5, ncol=4)


cells <- c(1, 35, 67, 99)
rnames <- c('r1','r2')
cnames <- c('c1','c2')
d <- matrix(cells, nrow=2, ncol=2, byrow=T, dimnames=list(rnames, cnames))
# byrow=true 행우선
d <- matrix(cells, nrow=2, ncol=2, byrow=F, dimnames=list(rnames, cnames))
# byrow=false 열우선

# 행렬의 각 요소는 '행렬이름[행, 열]' 로 접근 가능
# imnames() 으로 행과 이름에 이름을 부여했다면 그 이름으로 접근 가능

d['r1'] # 1행만 출력
d[,'c2'] # 2열만 출력
d[1,]
d[,2]
d[2,2] # 2행2열 출력

dim(d) # 행렬의 차원을 출력
ncol(d) # 행렬의 열 기준 차원 출력
nrow(d) # 행렬의 행 기준 차원 출력

solve(d) # 역행렬
t(d) # 전치행렬

# array : n 차원 행렬
# array(벡터, 차원, 행렬이름)

# (2 x 3 x 4) 3차원 행렬 생성
dim1 <- c("A1","A2")
dim2 <- c("B1","B2","B3")
dim3 <- c("C1","C2","C3","C4")
z <- array(1:24, c(2,3,4), dimnames=list(dim1, dim2, dim3))
z[1,1,1]
z[1,2,3]
z[ , ,3]
dim(z)

# 데이터 프레임 dataframe : 열마다 서로 다른 유형을 가질 수 있는 자료구조
# 다양한 변수, 관측치, 범주(팩터)를 표현하기 위한 자료구조
# data, frame(열1, 열2, 열3)

x <- c(1,2,3,4,5) # 첫번째 열 정의
y <- c('a','b','c','d','e') # 두번째 열 정의
z <- c(T, F, T, T, T) # 세번째 열 정의
s <- data.frame(x, y, z)
str(s) # 작업공간에 생성된 객체의 구조 확인
s$x # '데이터프레임이름$열이름' 형식으로 접근 가능
s[1,] # 컬럼이 차원이 1이 되면 벡터 값으로 자동 변환
s[, c('x','y')]
s[, c('x')]
s[, c('x'), drop=F] # 자동으로 벡터로 변화하는 것을 방지 하려면 drop=F 사용

x <- data.frame(x=1:1000)
head(x) # 데이터의 앞부분을 살펴봄
tail(x) # 데이터의 끝부분을 살펴봄

age <- c(1,3,5,2,11,9,3,9,12,3)
weight <- c(4.4,5.3,7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1)
age
weight

g <- "My First List"
h <- c(23, 26, 18, 39)
j <- matrix(1:10, nrow=5)
k <- c("one", "two", "three")
mylist <- list(title=g, ages=h, j, k)

mylist
mylist[[2]]
mylist[["ages"]]
mylist[2]
mylist$ages


# 2018.02.27
# 환자정보
patientID <- c(1,2,3,4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type1", "Type2", "Type1", "Type1")
status <- c("Poor", "Improved", "Excellent", "Poor")
patientdata <- data.frame(patientID, age, diabetes, status)
patientdata # 환자정보 출력
str(patientdata) # 데이터객체의 구조를 출력
patientdata[1:2] # 1, 2 속성 출력
patientdata[c('diabetes', 'status')] # 속성명으로 출력
patientdata$age # 객체에 $를 사용해서 속성명을 다를수 있음
patientdata$patientID
patientdata$diabetes
patientdata$status

# 위 사례처럼 모든 변수앞에 patientdata$ 를 사용해서
# 특정 속성을 출력하는 것은 불편
# attach(), detach(), with() 사용해서 해결 가능

# attach() : 특정 데이터프레임 명을 검색경로에 추가
# detach() : 특정 데이터프레임 명을 검색경로에 제거

attach(patientdata)
  patientID
  age
  diabetes
  status
detach(patientdata)

# with(객체명, { 속성명 })
with(patientdata, { age })
with(patientdata, {
  print(age)
  print(status)
})

# list - 하나의 이름 아래 다양한 객체들을 모아놓은 것
# 키, 값 형태로 데이터를 담아 두는 연관 배열의 일종
# list(이름1=객체1, 이름2=객체2, 이름3=객체3, ...)

sj1 <- list(name='혜교', kor=99, eng=98, mat=87)
# 단일값으로 list 를 구성
sj1
sj1[1]
sj1[[1]]
sj1['name']
sj1[['name']]

sja1 <- list(name='혜교', kem=c(99, 98, 87))
# 벡터를 list 의 원소로 구성
sja1
# 혜교의 영어점수 출력
sja1$kem[2]
sja1[['kem']] # sja1[[2]]
sja1[['kem']][2]

mixed <- list(a = sj1, b = sja1) # 리스트 자신을 리스트의 원소로 구성
mixed
# 혜교의 영어점수 출력
mixed$b[[2]][2]
mixed$b$kem[2]
mixed[['b']]
mixed[['b']][['kem']]
mixed[['b']][['kem']][2]

# sample R scripts 3
mtcars # 자동차 관련 데이터 집합
help(mtcars)

# mpg(연료소비율)에 대한 기본통계정보 summary 출력
summary(mpg) # 잘못된 표기법
summary(mtcars$mpg)
plot(mtcars$mpg, mtcars$disp) # 연료소비율과 배기량의 관계
plot(mtcars$mpg, mtcars$wt) # 연료소비율과 차량무게의 관계

# attach
attach(mtcars)
  summary(mpg)
  plot(mpg, disp)
  plot(mpg, wt)
detach(mtcars)

# with
with(mtcars, {
  summary(mpg)
  plot(mpg, disp)
  plot(mpg, wt)
})

# 팩터 - 벡터자료구조에 추가정보가 더해진 것
# 카테고리 자료형을 만들어 데이터에 의미를 부여할때 사용

a <- 1:3 # 1,2,3
a
factor(a, levels=c(1,3,5)) # 1, 3만 카테고리에 포함
factor(a, levels=c(1,3,5), labels=c('일','삼','오')) # 1, 3만 카테고리에 포함

# 설문지 답변을 factor 로 정의
# 1 : 아주 않좋음, 2 : 나쁘지 않음
# 3 : 보통, 4: 그럭저럭 좋음, 5 : 아주 좋음

mgr1_q <- c(5, 4, 5, 5, 5)
factor(mgr1_q, levels=1:5, labels=c('아주 않좋음','나쁘지 않음','보통','그럭저럭 좋음','아주 좋음'))

dev.off()

levels_q <- c(1, 2, 3, 4, 5)
labels_q <- c('아주 않좋음','나쁘지 않음','보통','그럭저럭 좋음','아주 좋음')
factor(mgr1_q, levels=levels_q, labels=labels_q)

