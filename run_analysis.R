library(magrittr)
library(dplyr)
library(tidyr)

#We read features.txt. We will use it to provide column names for the datasets
features<- read.table("C:/Users/jgomez/Desktop/Cursos 2024/UCI HAR Dataset/features.txt")

#We read the subjects_test.txt and the subjects_train.txt. We bind them together
subjects_test <-read.table("C:/Users/jgomez/Desktop/Cursos 2024/UCI HAR Dataset/test/subject_test.txt") %>% 
   rename("subject_number" = "V1")
subjects_train <-read.table("C:/Users/jgomez/Desktop/Cursos 2024/UCI HAR Dataset/train/subject_train.txt") %>% 
   rename("subject_number" = "V1")
subjects <- rbind(subjects_train, subjects_test)


train<-read.table("C:/Users/jgomez/Desktop/Cursos 2024/UCI HAR Dataset/train/X_train.txt", col.names = features$V2)
train_y <-read.table("C:/Users/jgomez/Desktop/Cursos 2024/UCI HAR Dataset/train/Y_train.txt") 
train_y$V1<-setNames(activity_labels$V2, c('1', '2', '3', '4', '5', '6'))[train_y$V1]
train_label <- cbind(train_y, train)

test <-read.table("C:/Users/jgomez/Desktop/Cursos 2024/UCI HAR Dataset/test/X_test.txt", col.names = features$V2)
#We read the labels and rename them
activity_labels <-read.table("C:/Users/jgomez/Desktop/Cursos 2024/UCI HAR Dataset/activity_labels.txt")
test_y <-read.table("C:/Users/jgomez/Desktop/Cursos 2024/UCI HAR Dataset/test/Y_test.txt") 
test_y$V1<-setNames(activity_labels$V2, c('1', '2', '3', '4', '5', '6'))[test_y$V1]
test_label <- cbind(test_y, test)

total<-rbind( train_label, test_label)

total_2 <- cbind(subjects, total) %>%  rename("Activity" = "V1")

#We select only the columns with means or std
my_patterns <- c("mean()", "std()", "subject", "Activity")
total_3 <- total_2[, grepl(paste(my_patterns, collapse='|'), names(total_2))]

# We define a new data frame and calculate the mean of each variable for each activity and each subject
new_df <- total_3 %>% pivot_longer(cols= 3:81, names_to = "variable", values_to = "value") %>% group_by(subject_number, 
                                                                                                        Activity, variable) %>% 
   summarise(mean=mean(value))
