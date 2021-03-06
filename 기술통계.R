# 기술통계

# 모집단 vs 표본
# 전국 대학생 수가 350만명이라 할 때,
# 전국 대학생의 학업만족도를 조사한다고 하자
# 350만명 학생 모두를 조사해야 하나? (시간/비용문제발생)

# 포탄 100만개를 생산했다
# 불량 포탄을 조사하기 위해 포탄을 터뜨려야하는데
# 모두 다 떠뜨려서 조사해야 하나? (상품가치 훼손)

# 모집단 : 조사하고자 하는 대상 전체

# 표본 : 전체를 다 조사하지 않고 일부 선별한 대상들

# 표본의 양이 많을수록 데이터의 신뢰도는 증가

# 모수

# 기술통계의 대표적인 내용
# min, max, 평균, 표준편차, 분산

# 평균 vs 표준편차, 분산
# 세상의 일은 쉽게 예측 하기 어려움
# 정답이라 생각하는 것도 시간/상황에 따라 변함 - 오차발생
# 이러한 오차에 대비하기 위해 오차예측을 함

# 오차 - 정답에서 벗어난 정도 (치우침 정도)
# 통계는 이러한 치우침을 분석하고 관리하는 분야
# 치우침을 표현하는 대표적인 척도 : 표준편차, 분산

# 그럼, 치우침의 기준점이 필요 - 통계에서는 평균을 사용
# 그외에도 최빈값, 중앙값등이 있음

# 편차와 분산
# 편차 : 평균에서 데이터값 사이
# 그런데, 데이터가 여러개 존재할 경우 : 편차들의 합 계산
# 한편, 수학적계산을 통해 편차들의 합을 구하려면 문제발생
# 평균 기준 왼쪽 영역 값들은 - 로 인식

# 원하는 값을 구하기 위해 (즉, - 를 + 로 변환)
# 제곱 계산을 시행 - 편차합 계산전에 미리 제곱으로 +로 바꿈

# 그래서, 표준편차 있음에도 분산을 많이 사용

# 분산 : 편차들의 제곱합
# 표준편차 : 편차에 제곱을 해서 계산
#            실제 값에서 다소 멀어져 있음
#            따라서, 값을 다시 가까워지게 만들기 위해
#            분산에 루트를 씌움

# 기술통계 관련 함수
mtcars
length(mtcars)
nrow(mtcars)
ncol(mtcars)

iris

# 데이터 탐색
str(mtcars) # 데이터 구조, 변수 등등 확인
length(mtcars) # 데이터 객체의 요소(:원소) 갯수
head(mtcars) + tail(mtcars) # 상하위 6개 관측치 보기
install.packages('car')
library(car)
some(mtcars) # 무작위 관측치 보기
names(mtcars) # 데이터 변수 이름
class(mtcars) # 데이터 원소의 속성

# 데이터 요약
min(mtcars$mpg) # 최소값
max(mtcars$mpg) # 최대값
mean(mtcars$mpg) # 평균
median(mtcars$mpg) # 중앙값
sd(mtcars$mpg) # 표준편차
var(mtcars$mpg) # 분산
range(mtcars$mpg) # 범위
quantile(mtcars$mpg) # 사분위수

summary(mtcars$mpg) # 최소/최대, 평균, 중앙값, 사분위값 출력

attach(mtcars)
min(mpg) # 최소값
max(mpg) # 최대값
mean(mpg) # 평균
median(mpg) # 중앙값
sd(mpg) # 표준편차
var(mpg) # 분산
range(mpg) # 범위
quantile(mpg) # 사분위수
summary(mpg) # 최소/최대, 평균, 중앙값, 사분위값 출력
detach(mtcars)

summary(mtcars) # 최소/최대, 평균, 중앙값, 사분위값 출력

# apply(데이터, 행/열, 함수) # 집계함수를 이용한 데이터 요약
apply(mtcars, 2, mean) # 집계함수를 이요한 데이터 요약
apply(mtcars, 2, min)

# 분포형태와 대칭정도 파악
# 중심화 경향, 처짐 정도

# 왜도 - 분포의 좌/우/비대칭 정도
# 좌우대칭 : 왜도 0
# 좌대칭(왼쪽으로 치우침) : 왜도가 0보다 큼
# 우대칭(오른쪽으로 치우침) : 왜도가 0보다 작음
hist(mtcars$mpg)
hist(mtcars$disp)

hist(mtcars$mpg, freq=F)
lines(density(mtcars$mpg), col='red', lwd=2)

hist(mtcars$disp, freq=F)
lines(density(mtcars$disp), col='red', lwd=2)

install.packages('fBasics')
library(fBasics)

skewness(mtcars$mpg) # 연비에 대한 왜도 측정
skewness(mtcars$disp)

library(MASS)
with(Cars93, tapply(Price, Type, skewness))
# Cars93 데이터 중에서 차종별 가격에 대한 왜도 측정

# 첨도
# 관측값이 정규분포(3)보다 뽀쪽한지 여부 측정
# 정규분포와 동일 : 첨도 0
# 정규분포보다 뽀쪽 : 첨도가 0보다 큼
# 정규분포보다 납작 : 첨도가 0보다 작음
kurtosis(mtcars$mpg)
kurtosis(mtcars$disp)

with(Cars93, tapply(Price, Type, kurtosis))
# Cars93 데이터 중에서 차종별 가격에 대한 첨도 측정

# 산술통계량 - 통계량과 함께 그래프도 함께 봐야 함 
# 중심화경향
  # 평균, 중앙값, 최빈값

# 퍼짐정도
  # 분산, 표준편차, 범위, 최대/최소, 사/백분위

# 대칭정도
  # 왜도, 첨도, 분위수

# 분위수, 사분위수
# 모집단 또는 표본의 전체 요소를 정렬한 후
# 일정한 비율로 나눈 것을 의미 (등분)
# 다양한 분위수가 존재(1000분위, 20분위, 12분위, 5분위)
# 하지만, 주로 100분위수와 4분위수가 많이 사용

# 일(1~10)별 출근 소요시간에 대한 분위수 계산
data <- c(30,29,32,28,32,29,27,32,29,32)

# 4분위수
quantile(data)

# 100분위수
quantile(data, 0.1) # 10분위수
quantile(data, 0.95) # 95분위수
quantile(data, 0.50) # 50분위수
quantile(data, 0.05) # 5분위수

# 분위수를 그래프로 표시 (데이터의 특정분포여부 확인)
qqnorm(data)
qqline(data)

# 기술통계 시각화
# 산점도(산포도)
# 막대그래프
# 원그래프
# 히스토그램
# 상자수염 그래프

# 줄기-잎 그래프
# 통계자료를 표형태와 그래프형태의 혼합된 형태
stem(Cars93$MPG.highway) # 시내에서의 연비
stem(Cars93$MPG.city) # 고속도로에서의 연비

str(faithful) # 미국 옐로우스톤 공원의 간혈천
              # (Old Faithful geyser) 분화 발생 데이터
faithful

stem(faithful$eruptions) # 시간당 분화 횟수

faithful$eruptions
