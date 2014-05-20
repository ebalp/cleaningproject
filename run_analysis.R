
## Loads the data (set load to 1)

load <- 1
if (load){
    features <- read.table("features.txt",sep=" ",col.names=c("num","feat"))
    actlab <-read.table("activity_labels.txt",sep=" ",col.names=c("label","activity"))
    
    subject_test <-read.table("./test/subject_test.txt",col.names="subject")
    subject_train <-read.table("./train/subject_train.txt",col.names="subject")
    
    xtrain <- read.table("./train/X_train.txt")
    ytrain <- read.table("./train/y_train.txt",col.names="activity")
    xtest <- read.table("./test/X_test.txt")
    ytest <- read.table("./test/y_test.txt",col.names="activity")
    
    #names(xtest)<-as.vector(as.character(features[,2]))
    #names(xtrain)<-as.vector(as.character(features[,2]))

    
}

## Merges the data in one dataset 
group <- factor(rep("test", length(ytest)))
datatest <- cbind(subject_test,group,ytest, xtest)
group <- factor(rep("train", length(ytrain)))
datatrain <- cbind(subject_train,group,ytrain,xtrain)

data<- rbind(datatest,datatrain)
data$actlab <- actlab[as.character(data$activity),2]
## 


## Aggregates mean and sd by subject and activity

means<-aggregate(data,by=list(act=data$activity,sub=data$subject),FUN=mean)
stds<-aggregate(data,by=list(act=data$activity,sub=data$subject),FUN=sd)

means$actlab <-actlab[as.character(means$act),2]
names(means)<-paste(names(means),rep("mean",length(means)),sep="")
stds$actlab <-actlab[as.character(stds$act),2]
names(stds)<-paste(names(stds),rep("sd",length(stds)),sep="")

results <- data.frame(means,stds)

write.table(results, "dataset.txt")

    
    





