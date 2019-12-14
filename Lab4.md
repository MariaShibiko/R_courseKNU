Лабораторна робота № 4. Зчитування даних з реляційних баз даних. Дані для цієї лабораторної роботи взяті з «https://www.kaggle.com/benhamner/nips-2015-papers» Для виконання лабораторної необхідно завантажити файл бази даних SQLite за посиланням: «https://www.dropbox.com/s/pf2htfcrdoqh3ii/database.sqlite?dl=0». В цьому файлі містяться дані по доповідям на Neural Information Processing Systems (NIPS) яка є однією з ведучих конференцій по машинному навчанню в світі. База даних складається з наступних таблиць: Papers This file contains one row for each of the 403 NIPS papers from this year's conference. It includes the following fields     Id - unique identifier for the paper (equivalent to the one in NIPS's system)     Title - title of the paper     EventType - whether it's a poster, oral, or spotlight presentation     PdfName - filename for the PDF document     Abstract - text for the abstract (scraped from the NIPS website)     PaperText - raw text from the PDF document (created using the tool pdftotext) Authors This file contains id's and names for each of the authors on this year's NIPS papers.     Id - unique identifier for the author (equivalent to the one in NIPS's system)     Name - author's name PaperAuthors This file links papers to their corresponding authors.     Id - unique identifier     PaperId - id for the paper     AuthorId - id for the author 
 ```R
library(RSQLite)
library(DBI)
```

В результаті виконання лабораторної роботи необхідно створити фрейми даних:
1. Назва статті (Title), тип виступу (EventType). Необхідно вибрати тільки статті
с типом виступу Spotlight. Сортування по назві статті.
```R

conn <- dbConnect(RSQLite::SQLite(), "database.sqlite")
task1 <- dbSendQuery(conn, "SELECT title, eventtype FROM Papers WHERE eventtype='Spotlight' ORDER BY title;")
result1 <- dbFetch(task1,15)
dbClearResult(task1)
dbDisconnect(conn)
result1
```
Title EventType
1  A Tractable Approximation to Optimal Point Process Filtering: Application to Neural Encoding Spotlight
2                                    Accelerated Mirror Descent in Continuous and Discrete Time Spotlight
3                        Action-Conditional Video Prediction using Deep Networks in Atari Games Spotlight
4                                                                      Adaptive Online Learning Spotlight
5                          Asynchronous Parallel Stochastic Gradient for Nonconvex Optimization Spotlight
6                                                 Attention-Based Models for Speech Recognition Spotlight
7                                                       Automatic Variational Inference in Stan Spotlight
8                                   Backpropagation for Energy-Efficient Neuromorphic Computing Spotlight
9                       Bandit Smooth Convex Optimization: Improving the Bias-Variance Tradeoff Spotlight
10                         Biologically Inspired Dynamic Textures for Probing Motion Perception Spotlight
11                        Closed-form Estimators for High-dimensional Generalized Linear Models Spotlight
12             Collaborative Filtering with Graph Information: Consistency and Scalable Methods Spotlight
13                           Color Constancy by Learning to Predict Chromaticity from Luminance Spotlight
14                                                Data Generation as Sequential Decision Making Spotlight
15                      Decoupled Deep Neural Network for Semi-supervised Semantic Segmentation Spotlight

2. Ім’я автора (Name), Назва статті (Title). Необхідно вивести всі назви статей
для автора «Josh Tenenbaum». Сортування по назві статті.
```R
conn <- dbConnect(RSQLite::SQLite(), "database.sqlite")
task2 <- dbSendQuery(conn, "SELECT aut.name, pap.title FROM authors aut JOIN PaperAuthors papaut ON aut.Id=papaut.AuthorId JOIN Papers pap ON pap.Id=papaut.paperid WHERE Name='Josh Tenenbaum' ORDER by Title;")
result2 <- dbFetch(task2)
dbClearResult(task2)
dbDisconnect(conn)
result2

Name                                                                                             Title
1 Josh Tenenbaum                                                       Deep Convolutional Inverse Graphics Network
2 Josh Tenenbaum Galileo: Perceiving Physical Object Properties by Integrating a Physics Engine with Deep Learning
3 Josh Tenenbaum                                                Softstar: Heuristic-Guided Probabilistic Inference
4 Josh Tenenbaum                                                        Unsupervised Learning by Program Synthesis
```
3. Вибрати всі назви статей (Title), в яких є слово «statistical». Сортування по
назві статті.

```R
conn <- dbConnect(RSQLite::SQLite(), "database.sqlite")
task3 <- dbSendQuery(conn, "SELECT title from Papers where title LIKE '%statistical%' ORDER by Title;")
result3 <- dbFetch(task3)
dbClearResult(task3)
dbDisconnect(conn)
result3

       Title
1 Adaptive Primal-Dual Splitting Methods for Statistical Learning and Image Processing
2                                Evaluating the statistical significance of biclusters
3                  Fast Randomized Kernel Ridge Regression with Statistical Guarantees
4     High Dimensional EM Algorithm: Statistical Optimization and Asymptotic Normality
5                Non-convex Statistical Optimization for Sparse Tensor Graphical Model
6            Regularized EM Algorithms: A Unified Framework and Statistical Guarantees
7                            Statistical Model Criticism using Kernel Two Sample Tests
8                         Statistical Topological Data Analysis - A Kernel Perspective
```
conn <- dbConnect(RSQLite::SQLite(), "database.sqlite")
task4 <- dbSendQuery(conn, "SELECT aut.name, count(pap.title) NumPapers FROM Authors aut JOIN PaperAuthors papaut ON aut.id=papaut.authorid JOIN papers pap ON pap.id=papaut.PaperId GROUP by name ORDER by NumPapers DESC;")
result4 <- dbFetch(task4, 15)
dbClearResult(task4)
dbDisconnect(conn)
result4
  Name NumPapers
1  Pradeep K. Ravikumar         7
2               Han Liu         6
3        Lawrence Carin         6
4   Inderjit S. Dhillon         5
5               Le Song         5
6     Zoubin Ghahramani         5
7        Christopher Re         4
8      Csaba Szepesvari         4
9           Honglak Lee         4
10       Josh Tenenbaum         4
11    Michael I. Jordan         4
12       Percy S. Liang         4
13         Prateek Jain         4
14        Ryan P. Adams         4
15          Shie Mannor         4
```