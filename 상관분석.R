# 상관분석

# 2개의 변수 x, y 가 있을 때
# 이 두 변수가 서로 어떤 관계에 있는지 파악하는 경우 존재

# 키x가 클수록 몸무게y도 증가하는가?
# 교육x을 많이 받으면 소득y이 증가하는가
# 광고x를 많이 하면 판매량y이 커지는가?

# 이처럼 두 변수가 서로 어떤 관계에 있는지 파악 - 상관분석
# 두 변수의 상관관계응 산점도로 나타내고
# 점들이 흩어져 있는 모습을 보고 관계를 파악
# 기울기에 따라 양/음의 상관관계로 분류

# 한편, 상관분석은 서로가 어떤관계에 있는지 파악할수가 있지만,
# 서로의 인과관계는 파악할 수 없다
# 즉, 여름이 다가오면 빙과류가 많이 팔린다
# 여름이 다가오면 모기가 점점 많아진다
# 하지만, 모기가 많아져서 빙과류가 많이 팔리나?
# 이것은 서로 직접적인 관련은 없다
# 단지, 여름이라는 변수가 큰 영향을 미쳤을 뿐이다

# 간혹 다른상황에서 서로 직접적인 영향을
# 주고 받는 경우도 존재

cor()

# 회사에서 신제품이 출시 되었을때
# 안내메일을 발송하는 횟수와 제품판매량 사이 관계 조사
# 제품판매량 : 3, 5, 8, 11, 13
# 안내메일발송수 : 1, 2, 3, 4, 5
x <- c(3, 5, 8, 11, 13)
y <- c(1, 2, 3, 4, 5)

cor(x, y) # 상관계수

plot(x, y)
# 산점도 함 그려보세요

cor(x, y) # 상관계수
# -0.7 ~ -1.0 : 강한 음적 선형관계
# -0.3 ~ -0.7 : 뚜렸한 음적 선형관계
# -0.1 ~ -0.3 : 약한 음적 선형관계
# -0.1 ~ 0.1 : 거의 무시해도 좋음
# 0.1 ~ 0.3 : 약한 양적 선형관계
# 0.3 ~ 0.7 : 뚜렸한 양적 선형관계
# 0.7 ~ 1.0 : 강한 양적 선형관계

# iris 에서 꽃받침, 꽃잎의 너비/길이에 대한 상관계수 계산
cor(iris$Sepal.Width, iris$Sepal.Length)
cor(iris[, 1:4])

airquality # 공기 오염도 데이터
airs <- airquality[, c(1:4)]

cor(airs) # 결측값 때문에 잘못된 값 출력
airs <- na.omit(airs)
cor(airs)

plot(airs$Ozone)
abline(airs$Ozone, 1:150)
abline(airs$Ozone/150, 1:150)

plot(airs$Solar.R)
plot(airs$Wind)
plot(airs$Temp)
# ---------------------------------------------------------
library(ggplot2)
qplot(Ozone, Solar.R, data=airs, geom=c('point', 'smooth'))
# ---------------------------------------------------------
plot(airs) # 산점도 작성

pairs(airs, panel=panel.smooth)

# 2018.03.08
# 상관계수
# 상관분석은 두변수가 서로 어떤 관계인지를 파악

# 예를 들어, 둘 다 같은 양의 상관관계라 하더라도
# 점들이 모여있는 모습(밀도)이 다를 수도 있기 때문에
# 서로 얼마나 다른지 정도를 알수 있는 방법이 필요
# 그림으로 파악이 되어도 수학적 표기 역시 필요

# 따라서, 통계에서는 추가로 숫자를 사용해서 밀도 표현
# 이 밀도를 표현한 숫자가 상관계수라 함
# 보통 -1 ~ +1 까지만 사용해서 밀도를 표현함

# 한편, 상관분석은 변수에 따라 치우침이 다른 경우 발생
# 즉, 치우침이 상대적으로 작아서 상관계수가 크게 나오거나
# 상관계수가 작은데 치우침이 크게 나오는 경우도 발생
# 따라서, 위 기준에 맞지 않는 상황 발생
# 보조적으로 가설검증으로 결과 해석 필요

cor.test()


# 공분산
# 치우침을 활용해서 상관계수를 구하는데
# 통계에서 치우침을 표현하는 대표적인 기호는 분산
# 분산을 이용해서 상관계수를 구하기도 하지만 복잡!

# var()


# 한편, 상관분석은 기본적으로 변수가 2개 이므로
# 치우침은 2개의 변수에 의해 발생
# 따라서, 각각의 분산외에도 두 변수의 공통된 치우침도
# 알아야 하는데 두 변수의 공통된 치우침을 공분산이라 함

# cov()


# 실업자수unemploy와 개인의 소비 지출pce의 상관관계 분석
library(ggplot2)
economics
?economics
str(economics)

cor(economics$unemploy, economics$pce) # 상관계수 : 양의 상관관계 존재
# 즉, x값이 증가하면 y값이 증가 (비례)
cor.test(economics$unemploy, economics$pce)
# 상관계수에 대한 가설검증

plot(economics$unemploy, economics$pce, type='l')

# Pearson's product-moment correlation
#
# data:  economics$unemploy and economics$pce
# t = 18.605, df = 572, p-value < 2.2e-16
#                                 0.00000000000000022 <- 5% 보다 작다 무시해도됨
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  0.5603164 0.6625460
# sample estimates:
#       cor 
# 0.6139997 

# 실업자수unemploy와 개인저축률psavert의 상관관계 분석
cor(economics$unemploy, economics$psavert) # 상관계수 : 음의 상관관계 존재
# 즉, x값이 증가하면 y값이 감소 (반비례)
cor.test(economics$unemploy, economics$psavert)

# Pearson's product-moment correlation
# 
# data:  economics$unemploy and economics$psavert
# t = -9.0529, df = 572, p-value < 2.2e-16
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  -0.4235742 -0.2802891
# sample estimates:
#        cor 
# -0.3540073

plot(economics$unemploy, economics$psavert, type='l')


# Cars93 데이터에서 고속도로연비와 차체중량의 상관관계 분석
library(MASS)
Cars93 # str(Cars93) - MPG.highway, Weight
 
plot(MPG.highway~Weight, data=Cars93) # 음의 상관관계 확인
abline(lm(MPG.highway~Weight, data=Cars93), col='red')

attach(Cars93)
cor(MPG.highway, Weight)
cov(MPG.highway, Weight)
detach(Cars93)

# 상관행렬
# 여러 변수(2개이상)의 상관관계를 한번에 알아보고자
# 하는 경우 모든 변수에 대한 상관관계를 알려주는
# 상관 행렬을 이용

cor()
corrplot()

# 자동차 각 요소에 개한 상관관계를 분석 - mtcars 이용
head(mtcars)

cor_cars <- cor(mtcars) # 상관행렬 생성
cor_cars <- round(cor(mtcars), 2) # 소수점 조정
cor_cars # 각 항목에 대한 상관계수를 파악 어려움

install.packages('corrplot')
library(corrplot)
corrplot(cor_cars) # 상관행렬을 열 그래프로 시각화
                   # 파란색 - 양 상관관계
                   # 빨간색 - 음 상관관계

?corrplot

corrplot(cor_cars, method='shade')
corrplot(cor_cars, method='ellipse')

# 놀이동산 만족도에 대한 상관관계 분석
# 주말이용여부, 동반자녀수, 공원까지 거리, 기구만족도,
# 게임만족도, 대기시간 만족도, 청결도 만족도, 전체만족도

# 놀이동산에 대한 만족도.csv
parks <- read.table('c:/Java/놀이동산에 대한 만족도.csv', sep=',', header=T)
str(parks)
parks

# 그래프 확인
plot(parks$overall~parks$rides)

attach(parks)
plot(overall~rides) # 놀이기구/전체만족도 상관관계
plot(overall~clean) # 청결도/전체만족도 상관관계
# detach(parks)

# 공분산
cov(overall, rides)

# 상관계수
cor(overall, rides)

# 상관계수 가설검증 ()
cor.test(overall, rides)

# 전체 만족도와 세부만족도에 개한 상관관계 분석
plot(parks[, 4:8]) # 산포도 작성

cor_parks <- cor(parks[, 4:8])
corrplot(cor_parks, method='ellipse') # 상관행렬 그래프

