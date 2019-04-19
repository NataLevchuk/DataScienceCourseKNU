'''r
#Lab5

getwd()
setwd("C:/Users/507-3/Desktop/rprog_data_specdata")


first<-read.csv("C:/Users/507-3/Desktop/rprog_data_specdata/specdata/001.csv")
allfiles<-list.files(path="specdata", pattern=".csv", full.names=TRUE)
allfiles

#Task1

#Написати функцію pmean, яка обчислює середнє значення (mean) забруднення сульфатами
#або нітратами серед заданого переліка моніторів. Ця функція приймає три аргументи:
#«directory», «pollutant», «id». Directory – папка, в якій розміщені дані, pollutant – вид забруднення,
#id – перелік моніторів. Аргумент id має значення за замовчуванням 1:332.
#Функція повинна ігнорувати NA значення

pmean <- function(directory, pollutant, id=1:332){
    allfiles <- list.files(path=directory, pattern=".csv", full.names=TRUE)
    nodata <- numeric()
    
    for (i in id){
        data <- read.csv(allfiles[i])
        nodata <- c(nodata, data[[pollutant]])
    }
    
    mean(nodata, na.rm = TRUE)
}

pmean("specdata", "sulfate", 1:10)
[1] 4.064128

pmean("specdata", "sulfate", 55)
[1] 3.587319

pmean("specdata", "nitrate")
[1] 1.702932



#Task2
#Написати функцію complete, яка виводить кількість повних спостережень
#(the number of completely observed cases) для кожного файлу. Функція приймає два
#аргументи: «Directory» та «id» та повертає data frame, в якому перший стовпчик – ім’я файлу,
#а другий – кількість повних спостережень.


complete <- function(directory, id=1:332){
    allfiles <- list.files(path=directory, pattern=".csv", full.names=TRUE)
    nodata <- numeric()
    
    for (i in id){
        data <- read.csv(allfiles[i])
        nodata <- c(nodata, sum(complete.cases(data)))
    }
    
    data.frame(id, nodata)
}



complete("specdata", 1)
id nodata
1  1    117

complete("specdata", c(2, 4, 8, 10, 12))
id nodata
1  2   1041
2  4    474
3  8    192
4 10    148
5 12     96
> 
    
complete("specdata", 50:60)
id nodata
1  50    459
2  51    193
3  52    812
4  53    342
5  54    219
6  55    372
7  56    642
8  57    452
9  58    391
10 59    445
11 60    448


#Task3

#Написати функцію corr, яка приймає два аргументи: directory (папка, де знаходяться файли спостережень)
#та threshold (порогове значення, за замовчуванням дорівнює 0) та обчислює кореляцію між сульфатами
#та нітратами для моніторів, кількість повних спостережень для яких більше порогового
#значення. Функція повинна повернути вектор значень кореляцій. Якщо ні один монітор
#не перевищує порогового значення, функція повинна повернути numeric вектор довжиною 0.
#Для обчислення кореляції між сульфатами та нітратами використовуйте вбудовану функцію
#«cor» з параметрами за замовчуванням.

corr <- function(directory, threshold = 0) {
    id = 1:332
    filename <- list.files(directory, full.names = TRUE)
    
    result <-vector("numeric", length=0)
    
    for(i in seq(filename)) {
        airquality <- read.csv(filename[i])
        good <- complete.cases(airquality)
        airquality <- airquality[good, ]
        if (nrow(airquality) > threshold) {
            
            correlation <- cor(airquality[["sulfate"]], airquality[["nitrate"]])
            result <- append(result, correlation)
            
        }
    }
    result
}

cr <- corr("specdata", 150)
head(cr)
[1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667 -0.07588814
summary(cr)
Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.21060 -0.04999  0.09463  0.12530  0.26840  0.76310 


cr <- corr("specdata", 400)
head(cr)
[1] -0.01895754 -0.04389737 -0.06815956 -0.07588814  0.76312884 -0.15782860

summary(cr)
Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.17620 -0.03109  0.10020  0.13970  0.26850  0.76310 


cr <- corr("specdata", 5000)
head(cr)
numeric(0)

summary(cr)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 

length(cr)
[1] 0

'''
