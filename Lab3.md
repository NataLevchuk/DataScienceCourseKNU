# Lab 3.
#Task1
#Функція add2(x, y), яка повертає суму двох чисел.

```{r}

add2<-function(x,y){
  x+y
}
x<-2
y<-3
add2(x,y)

[1] 5

```

#Task2
#Функція above(x, n), яка приймає вектор та число n, та повертає всі
елементі вектору, які більше n. По замовчуванню n = 10.

```{r}

above<-function(x,n=10)[x>n]
x<-c(1,5,7,8,12)
above(x)

[1] 12

```

#Task3
#Функція my_ifelse(x, exp, n), яка приймає вектор x, 
рівнює всі його елементи за допомогою exp з n, та повертає елементи вектору, які відповідають умові expression. Наприклад, my_ifelse(x, “>”, 0) повертає всі елементи x, які більші 0. Exp може дорівнювати “<”, “>”, “<=”, “>=”, “==”. Якщо exp не співпадає ні з одним з цих виразів, повертається вектор x.

```{r}

my_ifelse <- function(x, exp, n) {
  if(exp=="==") {res=x[x==n]}
  else if (exp=="<") {res=x[x<n]}
  else if (exp==">") {res=x[x>n]}
  else if (exp==">=") {res=x[x>=n]}
  else if (exp=="<=") {res=x[x<=n]}
  else res=x
  res
}

x<-c(1,2,3,5,7)
my_ifelse(x,">",3)
[1] 5 7

my_ifelse(x,"==",10)
numeric(0)

my_ifelse(x,">=",5)
[1] 5 7

```

#Task4
# Функція columnmean(x, removeNA), яка розраховує середнє
значення (mean) по кожному стовпцю матриці, або data frame. Логічний параметр removeNA вказує, чи видаляти NA значення. По замовчуванню він дорівнює TRUE.

```{r}

columnmean<-function(x, removeNA=TRUE){
  n<-ncol(x)
  v<-numeric(n)  
  for (i in 1:n){
    v[i]<-mean(x[,i], na.rm=removeNA)
  }
  v
}

x<-matrix(1:6, nrow=2, ncol=3)
columnmean(x)
[1] 1.5 3.5 5.5

```