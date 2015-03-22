run_analysis <- function () {
    
    print("Preparing the Analysis environment ...")
    library("dplyr"); library("reshape2")
    subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors=FALSE)
    x_test <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors=FALSE)
    y_test <- read.table("UCI HAR Dataset/test/y_test.txt", stringsAsFactors=FALSE)
    subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors=FALSE)
    x_train <- read.table("UCI HAR Dataset/train/X_train.txt",  stringsAsFactors=FALSE)
    y_train <- read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors=FALSE)
    activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt",  stringsAsFactors=FALSE)
    features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)

    ## You should create one R script called run_analysis.R that does the
    ## following. 
    ## 1.Merges the training and the test sets to create one data set.
    ## first rename column of y data from "V1", to "YV1" and subject
    ## data to "SV1" to ease later changes and 2: to make easy data 
    ## checks to ensure we are going in the right direction.
    print("Merging the X, Y, Subject, test and train data ...")
    names(y_test) <- "YV1"
    names(y_train) <- "YV1"
    names(subject_test) <- "SV1"
    names(subject_train) <- "SV1"
    
    ## bind x and y by columns
    yx_test <- cbind(y_test,subject_test,x_test)
    yx_train <- cbind(y_train,subject_train,x_train)
    
    ## bind train and test set by row
    test_train <- rbind(yx_train,yx_test)
    
    ## test that worked
    print("Checking the merged data ...")
    rows_train <- nrow(yx_train)
    onefromlast <- rows_train - 1
    bot_train <- yx_train[onefromlast:rows_train,]
    top_test <- yx_test[1:2,]
    bot_top <- rbind(bot_train,top_test)
    twobelowjoin <- rows_train + 2
    stopifnot(test_train[onefromlast:twobelowjoin,]==bot_top)
    
    ##  get to here we have merged datasets    
    ## 2.Extracts only the measurements on the mean and standard deviation
    ##   for each measurement.
    print("Extract only the feature measurements required ...")
    featureIds = grep("mean|std", features[,2], ignore.case=FALSE,perl=TRUE, value=FALSE)
    coersedIds = featureIds[]+2
    splitcols <- c(1,2,coersedIds)
    mean_std <- select(test_train, splitcols)
    
    ## 3.Uses descriptive activity names to name the activities in the
    ##   data set create a factor for VY1
    print("Create labels for the activities ...")
    mean_std$YV1 <- factor(mean_std$YV1,labels=activityLabels$V2)
    
    ## 4.Appropriately labels the data set with descriptive variable names.
    print("Rename the feature columns and arrange by Subject then by Activity...")
    featureNames <- features$V2[featureIds]
    
    newlabels = gsub("-mean[(][)]-", "MeanOfAxis.",featureNames,perl=TRUE)
    newlabels = gsub("-mean[(][)]", "Mean",newlabels,perl=TRUE)
    newlabels = gsub("-std[(][)]-", "StdOfAxis.",newlabels,perl=TRUE)
    newlabels = gsub("-std[(][)]", "StdDev",newlabels,perl=TRUE)
    newlabels = gsub("-meanFreq[(][)]-", "meanFreqOfAxis.",newlabels,perl=TRUE)
    newlabels = gsub("-meanFreq[(][)]", "MeanFreq",newlabels,perl=TRUE)
    newlabels = gsub("tB", "timeB",newlabels,perl=TRUE)
    newlabels = gsub("tG", "timeG",newlabels,perl=TRUE)
    newlabels = gsub("fG", "freqG",newlabels,perl=TRUE)
    newlabels = gsub("fB", "freqB",newlabels,perl=TRUE)
    
    colnames(mean_std) <- c("Activity","Subject", newlabels)
    mean_std  <- arrange(mean_std,Subject,Activity)
    
    ## 5.From the data set in step 4, creates a second, independent tidy 
    ##   data set with the average of each variable for each activity and 
    ##   each subject.
    ## Make a list of mean vars
    print("Create the new data set and write to the current working directory ...")
    by_SubAct <- mean_std %>% group_by(Subject, Activity)
    mean_data_set <- by_SubAct %>% summarise_each( funs(mean), -Subject, -Activity)
    write.table(mean_data_set,file = "mean_data_set.txt",row.name=FALSE)

    cat("To read use mds <- read.table(\"mean_data_set.txt\", header=TRUE)")  
    
}