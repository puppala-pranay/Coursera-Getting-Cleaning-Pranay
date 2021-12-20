#Get Train Data

data_train <- read.table("./train/X_train.txt")
data_train_y <- read.table("./train/y_train.txt")
data_train <- cbind(data_train,data_train_y)
subject_train <- read.table("./train/subject_train.txt")
data_train <- cbind(data_train,subject_train)

#Get Test Data

data_test <- read.table("./test/X_test.txt")
data_test_y <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")
data_test <- cbind(data_test,data_test_y,subject_test)

#Combine Data - test and train 
data_total <- rbind(data_train,data_test)

#Labeling with descriptive names of data frame
features_list <- read.table("features.txt")[,2]
features_list <- c(features_list,"activity","subject")
names(data_total)<- features_list


#Extracting only mean() and std() data
features_mean <- grep("mean()",features_list)
features_std <- grep("std()",features_list)
features_req <- c(features_mean,features_std,562,563)
data_total <- data_total[,features_req]

#Replacing activity with descriptive names
activity_allotment <- function(x){
  if(x==1)return("WALKING")
  else if(x==2)return("WALKING_UPSTAIRS")
  else if(x==3)return("WALKING_DOWNSTAIRS")
  else if(x==4)return("SITTING")
  else if(x==5)return("STANDING")
  else return ("LAYING")
}
data_total$activity <- sapply(data_total$activity , activity_allotment)




## Creating new data frame with means of each variable for each subject
## and each activity
data_split_subject <- split(data_total,data_total$subject)
for(i in 1:30){
  data_split_subject[[i]] <- split(data_split_subject[[i]],data_split_subject[[i]]$activity)
}

data_final <- data.frame()

no_subjects <- 30
no_activities <- 6
no_variables <- ncol(data_total)-2

for(sub in 1:no_subjects){
  
  for(act in 1: no_activities){
    curr_row <- c(sub,activity_allotment(act))
    for(var in 1:no_variables){
      curr_row <- c(curr_row,mean(data_split_subject[[sub]][[act]][[var]],na.rm=TRUE))
    }
    data_final <- rbind(data_final,curr_row)
  }
}
names(data_final) <- c("subject","activity",names(data_total)[1:79])

write.table(data_final,"final_tidy.txt",row.names = FALSE)

