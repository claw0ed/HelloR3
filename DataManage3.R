#DataManage3

# 결측치 - NA, 99999, unknown, not answer
# 누락된 값, 비어있는 값 - 함수 적용불가, 분석결과 왜곡
# 제거 또는 대체후 분석 실시
gender <- c('남', '여', '남', '남', '여')
score <- c(5, 3, 2, NA, 4)
df <- data.frame(gender, score)

# 결측치 확인
is.na(df)

# 결측치 빈도 확인
table(is.na(df))
df[3, 1] <- NA
table(is.na(df))

table(is.na(df$gender)) # 성별에서 결측치 측

#평균계산 - 결측치 포함 상태
mean(df$score) # NA로 출력
sum(df$score)

# 결측치 처리 - na.rm=T
mean(df$score, na.rm=T) # NA로 출력
sum(df$score, na.rm=T)

# 결측치 처리 - na.omit()
odf <- na.omit(df)
odf
mean(odf$score) # NA로 출력
sum(odf$score)

# MASS 라이브러리의 Car93 데이터 집합에서 결측값이 모두 몇개인지 확인
install.packages('MASS')
library(MASS)
str(Cars93)
table(is.na(Cars93))
is.na(Cars93)

# 결측치 확인 - 관측지에 결측값이 있는지 여부 검사
# 데이터 프레임의 각행에 대해 결측치를 확인
# 행에 저장된 모든 값이 결측치가 아닌 경우에만 TRUE 반환
complete.cases(Cars93)
table(complete.cases(Cars93))
Cars93[!complete.cases(Cars93), ]

# is.na vs complete.cases
# is.na는 컬럼에 대해 NA 여부 확인
# complete.cases는 행에 대해 NA 여부 확인

# 간단한 예제
iris_na <- iris
iris_na [c(10, 20, 25, 40, 32), 3] <- NA
iris_na [c(33, 100, 125), 1] <- NA

# is.na 결과는?
table(is.na(iris_na))
# is.na(iris_na)
# str(iris_na)

# complete.cases 결과는?
complete.cases(iris_na)
iris_na[!complete.cases(iris_na), ]
# table(complete.cases(iris_na))

# 결측값 처리
# 결측값이 있는 행을 제거
# 평균값 또는 임의의값으로 대체
# R에서는 DMwR 페키지를 이용해서 중앙값으로 대체
# R에서는 DMwR 페키지의 KNN 알고리즘을 이용해서
# 가중평균치로 대체
# ----------------------------------------------
gender <- c('남', '여', '남', '남', '여')
score <- c(5, 3, 2, NA, 4)
df <- data.frame(gender, score)
df[3, 1] <- NA
# ----------------------------------------------
# 임의의 값으로 대체 - 0
df
odf <- df
odf
odf$score[is.na(odf$score)] <- 0
odf

# 평균값
odf <- df
odf
omean <- mean(odf$score, na.rm=T) # NA를 제외한 평균 계산
odf$score <- ifelse(is.na(odf$score), omean, odf$score) # NA 항목에 평균 대체
odf

----------------------------------------------
# iris
iris_na <- iris
iris_na [c(10, 20, 25, 40, 32), 3] <- NA
iris_na [c(33, 100, 125), 1] <- NA
----------------------------------------------
# is.na 결과는?
table(is.na(iris_na))

# complete.cases 결과는?
complete.cases(iris_na)
iris_na[!complete.cases(iris_na), ]
----------------------------------------------
# DMwR 페키지 - 중앙값 대체
iris_na[1:4]
mapply(median, iris_na[1:4], na.rm=T)
# 위에서 구한 중앙값을 NA가 위치한 곳에 대체 - 불편
install.packages('DMwR')
library(DMwR)
iris_na <- centralImputation(iris_na[1:4])[
  c(10, 20, 25, 40, 32, 100, 125, 33), ] # 정수값

----------------------------------------------
# iris
iris
iris_na <- iris
iris_na [c(10, 20, 25, 40, 32), 3] <- NA
iris_na [c(33, 100, 125), 1] <- NA
----------------------------------------------
# DMwR 페키지 - KNN 알고리즘을 가중평균치 대체
knnImputation(iris_na[1:4])[
  c(10, 20, 25, 40, 32, 100, 125, 33), ] # 실수값

# 이상치
# 정상기준에서 벗어나면 결측 처리
# 논리적 판단 : 나이가 150을 넘어서면 (이상)극단치
#               국어점수가 100을 넘어서면 극단치
# 통계적 판단 : 평균으로부터 3표준편차 떨어진 값
#               사분위수에서 하단/상단 경계값을 벗어난 값

age <- c(10, 999, 33, 23, 121)
score <- c(200, 75, 150, 50, 88)
name <- c('a', 'b', 'c', 'd', 'e')
df2 <- data.frame(name, age, score)
df2

# 이상치 판단 - NA 대체 -> 결측치 처리
df2$age <- ifelse(df2$age > 100 | df2$age < 0, NA, df2$age)

df2$score <- ifelse(df2$score > 100, NA, df2$score)

# 논리적 판단에 의해 이상치들은 NA로 대체
df2

!complete.cases(df2[2:3])
df2_na <-  centralImputation(df2)[!complete.cases(df2[2:3]), ]
df2_na
# NA 결측치들은 평균값으로 대체

!complete.cases(df2)
df2_na <-  centralImputation(df2)[!complete.cases(df2), ] # NA 결측치들은 평균값으로 대체
df2_na

df2_na <-  knnImputation(df2)[!complete.cases(df2), ] # 데이터가 소량이라 경고 발생!!
df2_na

df2 <- rbind(na.omit(df2), df2_na)
# 기존 NA 결측치는 제거하고, 평균값으로 대체된 행과 합침
df2

# mpg 데이터 집합에서 drv(차량종류)에
# 이상치가 있는지 알아보고 적절하게 수정하세요
# 결측처리시 %in% 연산자를 사용하세요
# %in% c('f', 'r', '4')
# drv : r(후륜구동), f(전륜구동), 4(4륜구동)

library(ggplot2)
mpg # 1999년 부터 2008년까지 38가지 인기차종에 대한 연비 통계
mpgdrv <-mpg$drv
table(mpg$drv) # 이상치 판단 여부 확인
mpgdrv <- ifelse(mpgdrv %in% c('f', 'r', '4'), mpgdrv, NA)

mpgdrv_na <- knnImputation(mpgdrv)[!complete.cases(mpgdrv), ] # 가중 평균치로 대체

mpgdrv <- rbind(na.omit(mpgdrv), mpgdrv_na)

