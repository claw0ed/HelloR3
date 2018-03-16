# 시계열
# 관측계열이 1년 또는 계절마다, 월마다 주기적으로
# 같은 패턴을 그리는 것을 '계절성을 갖다'도 한다
# 보통 기온/강수랭 같은 기후데이터나
# 산업생산, 수입 및 수출과 관련된 데이터는 이런 패턴을 가짐

# 시계열에서 계절성 말고 다른 특징은
# 패턴을 그리되 시간에 따라 움직이는 경우 존재 - 추세
# 따라서, 시계열은 계절성과 추세성, 그리고 잡음으로 구성
# 이렇게 겹쳐 있으면 잘 구분이 가지 않기 때문에
# 주로 그래프 사용

# 이러한 특성때문에 시계열은 확률적 현상을 관측하여
# 얻은 값 계열이라 한다 (일정한 간격으로 배치된 값)

# 김치판매량에 대한 시계열 예측하기 - 수요예측
kimchi <- read.csv('c:/Java/kimchi.csv')
head(kimchi) # str(kimchi)

attach(kimchi)
plot(대형마트수량, type='l',
     xlab='주', ylab='금액') # 50주 주기로 판매량 증가 - 주기성 존재

plot(백화점수량, type='l',
     xlab='주', ylab='금액') # 50주 주기로 판매량 증가 - 주기성 존재

plot(수퍼수량, type='l',
     xlab='주', ylab='금액') # 50주 주기로 판매량 증가 - 주기성 존재

plot(편의점수량, type='l',
     xlab='주', ylab='금액') # 50주 주기로 판매량 증가 - 주기성 존재

# 각각의 그래프를 한번에 표시
library(zoo) # 시계열 패키지
dates <- as.Date(as.character(주마지막일자),
                 format='%Y%m%d')
all_sales <- data.frame(
  cbind(대형마트수량, 백화점수량, 수퍼수량, 편의점수량))

z_sales <- zoo(all_sales, dates)
plot(z_sales, screen=1, xlab='날짜', ylab='판매량',
     col=c('red', 'orange', 'blue', 'purple'))

plot(z_sales, screen=c(1,4), xlab='날짜', ylab='판매량',
     col=c('red', 'orange', 'blue', 'purple'))

# 마지막 년도를 기준으로 잘라서 추세를 그래프로 확인
sale2015 <- subset(kimchi, 주마지막일자 >= '20150101' & 주마지막일자 <= '20151231')
tail(sale2015)

sales2015 <- data.frame(cbind(주마지막일자, 대형마트수량, 백화점수량, 수퍼수량, 편의점수량))

plot(sale2015)

plot(sales2015)

sales2015 <- data.frame(cbind(대형마트수량, 백화점수량, 수퍼수량, 편의점수량))

z_sales2015 <- zoo(sales2015, sales2015[2]) # 안됨

plot(z_sales2015, screen=1, xlab='날짜', ylab='판매량',
     col=c('red', 'blue')) # 안됨

# 마지막 년도를 기준으로 잘라서 추세를 그래프로 확인 (다시작성)
big_sales <- zoo(대형마트수량, dates)
kimchi2015 <- read.csv('c:/Java/kimchi2.csv')
k_sales <- zoo(kimchi2015$SALES,
               as.Date(as.character(kimchi2015$LAST_WK),
               format='%Y%m%d'))

# merge_2015 <- merge(k_sale=window(big_sales,
#                     start='2015-01-01', end='2015-12-31'),
#                     k_sales, all=F)
merge_2015 <- merge(k_sale=window(big_sales,
                    start='2015-01-01', end='2015-12-31'),
                    all=F)
head(merge_2015)
plot(merge_2015)
# 대형마트 김치판매량과 반찬가게 판매량의 추세를 비교하는 그래프


# 각 그래프간의 상관 관계를 알아봄
# 각 요소가 서로 영행을 미치는지?
# 미친다면 수학적으로 얼마나 되는지?
ccf(k_sales, window(big_sales),
    start='2015-01-01', end='2015-12-31',
    main='판내량 상관관계')
# 두 매장 판매량의 상관관계는
# 초반 5주후부터 증가 - 마트판매량이 증가하면 다른 매장 판매량 역시 증가

# 대형마트 판매량을 기준으로 시간에
# 따른 변화량 확인 - 차분 (현재값 - 이전값)
plot(diff(big_sales))

# 현재의 매출은 과거의 매출과 상관관계가 있나?
# 자기상관관계 함수 acf
acf(big_sales)

# 유의미한 자기상관수 : 11

# 그럼, 이러한 자기상관이 김치 시계열에 존재하는건지?
# 자기상관에 대한 검증 실시 : p값 조사
# 시차에 대해 조사된 통계량의 '자기상관은 0이다' 라는
# 귀무가설을 검증
Box.test(big_sales) # Box-Pierce 검증
Box.test(big_sales, type='Ljung-Box') # Box-Ljung 검증 

# 이동평균법으로 시계열 그래프를 좀더 브드럽게 표시
# 데이터들을 몇개씩 묶어서 평균을 내어 세로운 값을 구함
# 이동평균으로 새로운 값을 구하려면 복잡한 선들이 좀 더
# 부드럽게 표시된다 - 대략적인 패턴 파악 쉬움
plot(big_sales)
par(mfrow=c(2,2))
roll2 <- rollapply(big_sales, 2, mean)
roll4 <- rollapply(big_sales, 4, mean)
roll6 <- rollapply(big_sales, 6, mean)
roll8 <- rollapply(big_sales, 8, mean)
plot(roll2);plot(roll4);plot(roll2);plot(roll8);

# 이동평균의 묶음width수는 얼마가 좋을까?
# acf를 통해 구한 자기상관수를 사용하자
par(mfrow=c(1,1))
roll11 <- rollapply(big_sales, 11, mean)
plot(roll11)

# 예측값 계산 - 시계열 모형 생성 : ARIMA 모델
# R에서는 auto.arima 라는 만능함수를 사용
# frequency 속성은 주기를 의미 : 52주 - 1년
# seasonal 속성은 계절성을 의미 : 봄/여름/가을/겨울
# forecast 함수를 사용해서 예측값 계산
install.packages('forecast')
library(forecast)
fit1 <- auto.arima(ts(log(big_sales), frequency=52))
plot(forecast(fit1))

# fit1 <- auto.arima(ts(log(big_sales), frequency=52))

fit2 <- auto.arima(ts(log(big_sales), frequency=52), seasonal=T)
plot(forecast(fit2))

# 생성된 모형으로 값 예측
v <- predict(fit2, n.ahead=10)
# 향후 10주동안 마트 판매량 예측

