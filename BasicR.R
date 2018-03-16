# 간단한 실행 테스트
# 주석 삽입은 ctrl + shift + c
# 한줄 실행은 ctrl + enter
print('Hello, R!!')
print('안녕~ R!!')

# 여러줄 걸쳐 입력하기
print(
  "Hello, R, again"
)

# sample R script
# 나이 age 와, 몸무게 weight 의 상관관계 파악
age <- c(1,3,5,2,11,9,3,9,12,3)
# 벡터형식을 이용해 데이터를 정의하고 변수 age에 대입
weight <- c(4.4,5.3,7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1)
age # 입력된 값 확인
weight

mean(weight) #산술평균 : mean
sd(weight) # 표준편차 (평균에서 얼마나 떨어져 있나?) : sd
cor(age, weight)
# 상관계수 : cor
# 두 사건간의 연관성(관계) 조사 :
# 두 변수간의 선형적 관계 파악
# 예) GDP와 기대수명, 키와 몸무게간 관계

plot(age, weight) # 그래프 작성 : plot

# 간단한 그래프 데모
demo() # 데모 가능 목록 출력
demo('graphics') # 그래프 데모 시연
 
# 도움말 함수
help.start()

help('q') # q()
?q  # q()에 대한 도움말 출력2

q() # R 종료

help.search('q') # 특정 단어를 포함하는 도움말 검색
RSiteSearch('q') # 온라인(웹) 상에서 도움말 검색
apropos('q', mode='function') # 특정단어가 포함된 함수를 찾아줌

data() # 현재 설치된 패키지 상의 이용가능한 모든 자료집합을 나열
vignette() # 이용가능한 모든 소품문을 나열 (패키지에 대한 장문 안내서)

# 작업공간 관련 함수
getwd() # 현재 작업 디렉토리 출력
setwd("c:/java") # 새로운 작업 디렉토리를 설정

ls() # 현재 작업공간의 모든 객체를 출력
rm() # 하나이상의 객체를 제거
rm(age)
rm(weight)
ls()

options() # 현재 작업공간에서 사용가능한 설정에 대한 정보 제공

history() # 명령어 목록 출력
history(5) # 끝에서 n개의 명령어 출력
savehistory('c:/Java/.Rhistory') # 명령어 히스토리를 저장 (.Rhistory)
loadhistory('c:/Java/.Rhistory') # 명령어 히스토리를 불러서 메모리에 적재

age <- c(1,3,5,2,11,9,3,9,12,3)
save(age, file='c:/java/age.data') # 특정객체를 파일에 저장
rm(age)
age
load('c:/java/age.data') # 파일을 작업공간으로 읽어드림
age

setwd('c:/java')
dir.create('xyz') # 특정 디렉토리 생성

# sample R script 2
setwd('c:/java/xyz')
options('digits') # 소숫점 출력 자리수 (기본=7)
options(digits = 3)
options('digits')
x <- runif(20) # 20개의 임의의 난수 생성
x
summary(x)
hist(x)

.libPaths() # 패키지 설치정보 확인

installed.packages() # 설치되어 있는 패키지 확인

library(help='datasets') # 특정 패키지에 대한 정보 확인
library('datasets') # 특정 패키지를 매모리에 올림
HairEyeColor

install.packages('rJava') # 특정 패키지를 설치

update.packages() # 패키지 업데이트 하기

install.packages('rJava')

help.start()

install.packages('vcd')
install.packages('zoo')

library(help='vcd')

library('vcd')
help('Arthritis')

Arthritis

example('Arthritis')
