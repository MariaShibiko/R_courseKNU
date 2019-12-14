Лабораторна робота № 1. Завантаження та зчитування даних.
1. За допомогою download.file() завантажте любий excel файл з порталу
http://data.gov.ua та зчитайте його (xls, xlsx – бінарні формати, тому
 встановить mode = “wb”. Виведіть перші 6 строк отриманого фрейму даних.
                                     
 ```R
auditorsurl <- 'https://data.gov.ua/dataset/2fba6fe5-a069-42ef-93b5-f4af2f42abd9/resource/8901dbc0-544f-4247-92ce-2b3caca76b8b/download/auditor-07032019.xlsx'
destfile = 'auditors.xlsx'
download.file(auditorsurl, destfile, mode = 'wb')
         

library(readxl)
auditors <- read_xlsx('auditors.xlsx')
head(auditors)

# A tibble: 6 x 6
`№ з/п` name            series_number_of_the_… location                                number_date_of_de… note               
<dbl> <chr>           <chr>                  <chr>                                   <chr>              <chr>              
1       1 Шматков Григор… ЕА № 001               49023, м. Дніпропетровськ, вул. С.Кова… № 325, 24.06.2008  Продовжено  (Прото…
2       2 Волоско-Демків… ЕА № 011               04201, м. Київ, вул. Рокосовського, 10… № 515, 08.10.2008  Продовжено  (Прото…
3       3 Гакаленко Окса… ЕА № 025               69008, м. Запоріжжя, вул. Експресівськ… № 591, 08.11.2008… Продовжено  (Прото…
4       4 Куруленко Свят… ЕА № 033               03035, м.Київ, вул.Урицького,35, тел. … № 533, 30.12.2005… Продовжено  (Прото…
5       5 Барський Русла… ЕА № 037               65029, м. Одеса, вул. Князівська, 21/3… № 533, 30.12.2005… Продовжено  (Прото…
6       6 Ієвлєва Ольга … ЕА № 043               61166, м. Харків, вул. Бакуліна, 6, те… № 74, 22.02.2006 … Продовжено  (Прото…
                                                                                                                                                                                                                                                                                                                                                           
```
2. За допомогою download.file() завантажте файл getdata_data_ss06hid.csv за
посиланням
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv та
завантажте дані в R. Code book, що пояснює значення змінних
знаходиться за посиланням
https://www.dropbox.com/s/dijv0rlwo4mryv5/PUMSDataDict06.pdf?dl=0
Необхідно знайти, скільки property мають value $1000000+
  
  ```R
getdata_data_ss06hidURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
destfile = 'getdata_data_ss06hid.csv'
download.file(getdata_data_ss06hidURL, destfile, mode = 'wb')

getdata_data_ss06hid <- read.csv('getdata_data_ss06hid.csv')

length(which(getdata_data_ss06hid$VAL==24))
[1] 53
```
3. Зчитайте xml файл за посиланням
http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
Скільки ресторанів мають zipcode 21231?

```R
library(XML)
restURL <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
doc <- xmlTreeParse(restURL, useInternal=TRUE)
rest <- xmlRoot(doc)
zipcode <- xpathSApply(doc, "//zipcode", xmlValue)

length(which(zipcode==21231))                                                                                                                         
[1] 127
```

                                                                                                                         
                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
