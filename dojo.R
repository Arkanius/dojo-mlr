## Etapa 1 - Coletando os Dados
data <- read.csv("./bc_data.csv", stringsAsFactors = TRUE)

str(data)
head(data)

## Etapa 2 - limpando dados
data = data[-1]

## Etapa 3 - Normalização
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

normalizedData = as.data.frame(lapply(data[1:569, 2:31], normalize))
str(normalizedData)
class(normalizedData)
head(normalizedData)

## Etapa 4 - Preparação dos dados para criação do modelo
# Pode-se limpar na mão pois o dataset já esta "randomizado"
trainingData = normalizedData[1:469, ]
testData = normalizedData[470:569, ]


# ou usar o caTools, o resultado deve ser o mesmo
library(caTools)

# set.seed(101)
# sample <- sample.split(normalizedData$radius_mean, SplitRatio = 0.70)

# head(trainingData)
# trainingData <- subset(normalizedData, sample = TRUE)
# head(trainingData)

# testData <- subset(normalizedData, sample = FALSE)


# trainingLabelsData = data[1:469, 1]
# testLabelsData = data[470:569, 1]


## Etapa 5 - Treinamento do modelo
library(class)

model <- knn(
  train = trainingData,
  test = testData,
  cl = trainingLabelsData,
  k = 21
)

head(trainingData)
head(testData)
head(trainingLabelsData)
head(model)

## Etapa 6 - Resultado do modelo
library(gmodels)
?CrossTable

CrossTable(x = testLabelsData, y = model, prop.chisq = FALSE)