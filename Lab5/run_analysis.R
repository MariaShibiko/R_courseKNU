# Лабораторна робота № 5. Отримання та очистка даних.

library(dplyr)

#4. Відповідно присвоює змінним у наборі даних описові імена. 

df_labels <- read.table('UCI HAR Dataset\\features.txt', colClasses = 'character')[,2]

x_train <- read.table('UCI HAR Dataset\\train\\X_train.txt', col.names = df_labels, check.names = F)
y_train <- read.table('UCI HAR Dataset\\train\\y_train.txt', col.names = c('Activities'))
subj_train <- read.table('UCI HAR Dataset\\train\\subject_train.txt', col.names = c('Subject'))

x_test <- read.table('UCI HAR Dataset\\test\\X_test.txt', col.names = df_labels, check.names = F)
y_test <- read.table('UCI HAR Dataset\\test\\y_test.txt', col.names = c('Activities'))
subj_test <- read.table('UCI HAR Dataset\\test\\subject_test.txt', col.names = c('Subject'))

activity_labels <- read.table('UCI HAR Dataset\\activity_labels.txt', col.names = c('№','Activity'))

#1. Об’єднує навчальний та тестовий набори, щоб створити один набір даних. 

df <- cbind(rbind(x_train, x_test), rbind(y_train, y_test), rbind(subj_train, subj_test))

#2. Витягує лише вимірювання середнього значення та стандартного відхилення (mean and standard deviation) для кожного вимірювання. 

stat <- df[ , grep("-mean\\(\\)|-std\\(\\)", colnames(df))]

#3. Використовує описові назви діяльностей (activity) для найменування діяльностей у наборі даних. 

df_ <- within(stat, Activity <- factor(activity, labels = activity_labels[,2]))

colnames(df_) <- gsub("^t", "time", colnames(df_))
colnames(df_) <- gsub("^f", "frequency", colnames(df_))
colnames(df_) <- gsub("Acc", "Accelerometer", colnames(df_))
colnames(df_) <- gsub("Gyro", "Gyroscope", colnames(df_))
colnames(df_) <- gsub("Mag", "Magnitude", colnames(df_))

#5. З набору даних з кроку 4 створити другий незалежний акуратний набір даних (tidy dataset) із середнім значенням для кожної змінної для кожної діяльності та кожного суб’єкту (subject). 
final <- aggregate(x = df_[, -c(67,68)], by = list(df_[,'subject'], df_[, 'Activity']), FUN = mean)

write.csv(final, "tidy_dataset.csv", row.names=F)
