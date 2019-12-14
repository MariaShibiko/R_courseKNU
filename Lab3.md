Лабораторна робота № 3. Зчитування даних з WEB. В цій лабораторній роботі необхідно зчитати WEB сторінку з сайту IMDB.com зі 100 фільмами 2017 року виходу за посиланням «http://www.imdb.com/search/title?count=100&release_date=2017,2017&title_ty pe=feature».  Необхідно створити data.frame «movies» з наступними даними: номер фільму (rank_data), назва фільму (title_data), тривалість (runtime_data). Для виконання лабораторної рекомендується використати бібліотеку «rvest». CSS селектори для зчитування необхідних даних: rank_data: «.text-primary», title_data: «.lister-item-header a», runtime_data: «.text-muted .runtime». Для зчитування url використовується функція read_html, для зчитування даних по CSS селектору – html_nodes і для перетворення зчитаних html даних в текст - html_text. Рекомендується перетворити rank_data та runtime_data з тексту в 
числові значення. При формуванні дата фрейму функцією data.frame рекомендується використати параметр «stringsAsFactors = FALSE». В результаті виконання лабораторної роботи необхідно відповісти на запитання: 
  1. Виведіть перші 6 назв фільмів дата фрейму.

```R
library(rvest)
library(stringr)
film_file <- read_html('http://www.imdb.com/search/title?count=100&release_date=2017,2017&title_type=feature')

rank_data <- html_nodes(film_file, '.text-primary')
title_data <- html_nodes(film_file, '.lister-item-header a')
runtime_data <- html_nodes(film_file, '.text-muted .runtime')

rank_text <- html_text(rank_data, trim = TRUE)
title_text <- html_text(title_data, trim = TRUE)
runtime_text <- html_text(runtime_data, trim = TRUE)

rank_data <- as.integer(rank_text)
title_data <- title_text
runtime_data <- str_remove(runtime_text, 'min')
runtime_data <- as.integer(runtime_data)

movies <- data.frame(rank_data, title_data, runtime_data, stringsAsFactors = FALSE)
head(movies, 6)
```
rank_data                              title_data runtime_data
1         1 Зоряні війни: Епізод 8 - Останні Джедаї          152
2         2              Джуманджі: Поклик джунглів          119
3         3                           Тор: Рагнарок          130
4         4                                    Воно          135
5         5            Той, хто біжить по лезу 2049          164
6         6                    Найвеличнiший шоумен          105

2. Виведіть всі назви фільмів с тривалістю більше 120 хв
```R
df2<-subset(movies$title_data, runtime_data > 120)
df2
[1] "Зоряні війни: Епізод 8 - Останні Джедаї"  "Тор: Рагнарок"                           
[3] "Воно"                                     "Той, хто біжить по лезу 2049"            
[5] "Пострiл в безодню"                        "Call Me by Your Name"                    
[7] "Вартові Галактики 2"                      "Король Артур: Легенда меча"              
[9] "Логан: Росомаха"                          "Форма води"                              
[11] "Красуня i Чудовисько"                     "Kingsman: Золоте кiльце"                 
[13] "Людина-павук: Повернення додому"          "Чужий: Заповiт"                          
[15] "Диво-Жiнка"                               "Джон Уiк 2"                              
[17] "Усi грошi свiту"                          "Пірати Карибського моря: Помста Салазара"
[19] "Валерiан i мiсто тисячi планет"           "Гра Моллi"                               
[21] "Трансформери: Останнiй лицар"             "Мати!"                                   
[23] "Зменшення"                                "Примарна нитка"                          
[25] "Saban's Могутнi рейнджери"                "Форсаж 8"                                
[27] "Темнi часи"                               "Вiйна за планету мавп"                   
[29] "Вбивство священного оленя"                "Only the Brave"                          
[31] "1+1: Нова iсторiя"                        "Сiм сестер"                              
[33] "Вороги"                                   "Метелик"                                 
[35] "Brawl in Cell Block 99" 
```
3. Скільки фільмів мають тривалість менше 100 хв.
```R
df2<-subset(movies$title_data, runtime_data < 100)
df2
[1] "A Christmas Prince"      "Анна й Апокалiпсис"      "Тебе нiколи тут не було" "Ледi Бьорд"             
[5] "The Babysitter"          "Pitch Perfect 3"         "Sweet Virginia"          "Щасливий день смертi"   
[9] "Та сама зiрка"           "Time Trap"               "Темна вежа"              "Воно приходить уночi"   
[13] "Ритуал"
```

