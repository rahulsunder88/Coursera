## merge all datasets
trainX <- read.table("./data/train/X_train.txt")
trainY <- read.table("./data/train/Y_train.txt") 
trainSubject <- read.table("./data/train/subject_train.txt")
testX <- read.table("./data/test/X_test.txt")
testY <- read.table("./data/test/Y_test.txt")
testSubject <- read.table("./data/test/subject_test.txt")
bindData <- rbind(trainX,testX)
bindLabel <- rbind(trainY,testY)
joinSubject <- rbind(trainSubject,testSubject)

# extract the measurements

features <- read.table("./data/features.txt")
meanStdIndices <- grep("mean\\(\\)|std\\(\\)",features[,2])
length(meanStdIndices)
bindData <- bindData[,meanStdIndices]
names(bindData) <- gsub("\\(\\)","",features[meanStdIndices,2]) 
names(bindData) <- gsub("mean","Mean", names(bindData))
names(bindData) <- gsub("std","Std", names(bindData))
names(bindData) <- gsub("-","",names(bindData))

# name the columns

activity <- read.table("./data/activity_labels.txt")
activity[,2] <- tolower(gsub("_","",activity[,2]))
substr(activity[2,2],8,8) <- toupper(substr(activity[2,2],8,8))
substr(activity[3,2],8,8) <- toupper(substr(activity[2,2],8,8))
activityLabel <- activity[bindLabel[,1],2]
bindLabel[,1] <- activityLabel
names(bindLabel) <- "activity"
                             
# write the data
                             
name(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject,bindLabel,bindData)
write.table(cleanedData,"merged_Data.txt")
                             
# write output dataset with the above created results
                             
subjectLen <- length(table(joinSubject))
activityLen <- dim(activity)[1]
columnLen <- dim(cleanedData)[2]
result <- matrix(NA,nrow=subjectLen*activityLen, ncol=columnLen)
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
        for(i in 1:subjectLen)
                {
                             for (j in 1:activityLen) 
                             {
                             result[row,1] <-sort(unique(joinSubject)[,1])[i]
                             result[row,2] <- activity[j,2]
                             bool1 <- i == cleanedData$subject
                             bool2 <- activity[j,2] == cleanedData$activity
                             result[row,3:columnLen] <- colMeans(cleanedData[bool1&bool2,3:columnLen])
                             row <- row + 1
                             }
                }
                             
write.table(result,"data_with_means.txt")