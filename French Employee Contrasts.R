##French contrasts
library(psych)

French.data <- read.csv(file.choose())


##Joshua Wiley's Contrast t-test function (modified)
t.contrast.calc <- function(x=NA, lambda, m=NULL, s=NULL, n=NULL, raw=FALSE) 
{
  if(identical(raw, TRUE)) {
    xok <- list(NULL)
    for(i in seq_along(x)) {xok[[i]] <- x[[i]][!is.na(x[[i]])]};
    for(i in seq_along(xok)) {m[i] <- mean(xok[[i]])};
    for(i in seq_along(xok)) {s[i] <- sd(xok[[i]])};
    for(i in seq_along(xok)) {n[i] <- length(xok[[i]])}
  }
  df <- sum(n-1)
  effect <- sum(m*lambda)
  s2.pooled <- weighted.mean(x=s^2, w=n-1)
  sample.correction <- sum((lambda^2)/n)
  variability <- sqrt(sample.correction*s2.pooled)
  t.score <- effect/variability
  p.score <- pt(q=t.score, df=df, lower.tail=F)
  r.score <- t.score/sqrt((t.score^2)+df)
  value <- list(t.score, p.score, r.score, s2.pooled, df)
  names(value) <- c("t.contrast", "p.value", "r.contrast", "pooled.variance", "df")
  return(value)
}




### Demographics

summary(data$t1Sex)

summary(French.data$Condition)

summary(French.data$t1age)

summary(data$t1own_edu)

names(data)




######################## Elevation


French.data$t1Elevationmean <- rowMeans(French.data[ , c("t1Elevation1", "t1Elevation2", "t1Elevation4","t1Elevation5", "t1Elevation7","t1Elevation8")],na.rm=TRUE )

#reliability
alpha(French.data[ , c("t1Elevation1", "t1Elevation2", "t1Elevation4", "t1Elevation5","t1Elevation7","t1Elevation8")])


aggregate(French.data$t1Elevationmean~Condition, French.data, mean )
aggregate(French.data$t1Elevationmean~Condition, French.data, sd )


#backwards way of finding number of participants per condition for each variable
elev.num <- French.data[ , c("t1Elevationmean", "Condition")]
elev.num2 <- na.omit(elev.num)

summary(elev.num2$Condition)

# Trigger vs control
found.m<- doBy::summaryBy(t1Elevationmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Elevationmean.mean"]
found.sd <- doBy::summaryBy(t1Elevationmean~Condition,data=French.data,FUN=sd, na.rm=TRUE)[,"t1Elevationmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-3,1,1,1),
                s=found.sd,
                n=c(46,46,48,53)
)

# kind vs control
found.m<- doBy::summaryBy(t1Elevationmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Elevationmean.mean"]
found.sd <- doBy::summaryBy(t1Elevationmean~Condition,data=French.data,FUN=sd, na.rm=TRUE)[,"t1Elevationmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,1,0),
                s=found.sd,
                n=c(46,46,48,53)
)


# work vs control
found.m<- doBy::summaryBy(t1Elevationmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Elevationmean.mean"]
found.sd <- doBy::summaryBy(t1Elevationmean~Condition,data=French.data,FUN=sd, na.rm=TRUE)[,"t1Elevationmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,0,1),
                s=found.sd,
                n=c(46,46,48,53)
)


# health vs control
found.m<- doBy::summaryBy(t1Elevationmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Elevationmean.mean"]
found.sd <- doBy::summaryBy(t1Elevationmean~Condition,data=French.data,FUN=sd, na.rm=TRUE)[,"t1Elevationmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,1,0,0),
                s=found.sd,
                n=c(46,46,48,53)
)



######################## Humility
French.data$t1Humilitymean <- rowMeans( French.data[ , c("t1Humility1", "t1Humility2", "t1Humility3", "t1Humility4","t1Humility5","t1Humility6")] ,na.rm=FALSE)

aggregate(French.data$t1Humilitymean~Condition, French.data, mean )
aggregate(French.data$t1Humilitymean~Condition, French.data, sd )

#backwards way of finding number of participants per condition for each variable
hum.num <- French.data[ , c("t1Humilitymean", "Condition")]
hum.num2 <- na.omit(hum.num)

summary(hum.num2$Condition)

#reliability
alpha(French.data[ , c("t1Humility1", "t1Humility2", "t1Humility3", "t1Humility4","t1Humility5","t1Humility6")])


#trigger vs control
found.m<- doBy::summaryBy(t1Humilitymean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Humilitymean.mean"]

found.sd <- doBy::summaryBy(t1Humilitymean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Humilitymean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-3,1,1,1),
                s=found.sd,
                n=c(49,51,50,56)
)

# kind vs control
found.m<- doBy::summaryBy(t1Humilitymean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Humilitymean.mean"]
found.sd <- doBy::summaryBy(t1Humilitymean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Humilitymean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,1,0),
                s=found.sd,
                n=c(49,51,50,56)
)

#work vs control
found.m<- doBy::summaryBy(t1Humilitymean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Humilitymean.mean"]
found.sd <- doBy::summaryBy(t1Humilitymean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Humilitymean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,0,1),
                s=found.sd,
                n=c(49,51,50,56)
)


# health vs control
found.m<- doBy::summaryBy(t1Humilitymean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Humilitymean.mean"]
found.sd <- doBy::summaryBy(t1Humilitymean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Humilitymean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,1,0,0),
                s=found.sd,
                n=c(49,51,50,56)
)




############################# State Gratitude
French.data$t1GQ6_statemean <- rowMeans(French.data[ , c("t1GQ_state1", "t1GQ_state2", "t1GQ_state3", "t1GQ_state4","t1GQ_state5","t1GQ_state6")] ,na.rm=TRUE)
aggregate(French.data$t1GQ6_statemean~Condition, French.data, mean )
aggregate(French.data$t1GQ6_statemean~Condition, French.data, sd )



#reliability
alpha(French.data[ , c("t1GQ_state1", "t1GQ_state2", "t1GQ_state3", "t1GQ_state4","t1GQ_state5","t1GQ_state6")])


#backwards way of finding number of participants per condition for each variable
grat.num <- French.data[ , c("t1GQ6_statemean", "Condition")]
grat.num2 <- na.omit(grat.num)

summary(grat.num2$Condition)

#Trigger vs control
found.m<- doBy::summaryBy(t1GQ6_statemean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1GQ6_statemean.mean"]

found.sd <- doBy::summaryBy(t1GQ6_statemean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1GQ6_statemean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-3,1,1,1),
                s=found.sd,
                n=c(49,53,52,57)
)

#k vs c
found.m<- doBy::summaryBy(t1GQ6_statemean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1GQ6_statemean.mean"]

found.sd <- doBy::summaryBy(t1GQ6_statemean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1GQ6_statemean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,1,0),
                s=found.sd,
                n=c(49,53,52,57)
)

#work vs c
found.m<- doBy::summaryBy(t1GQ6_statemean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1GQ6_statemean.mean"]

found.sd <- doBy::summaryBy(t1GQ6_statemean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1GQ6_statemean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,0,1),
                s=found.sd,
                n=c(49,53,52,57)
)

#helath vs c
found.m<- doBy::summaryBy(t1GQ6_statemean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1GQ6_statemean.mean"]

found.sd <- doBy::summaryBy(t1GQ6_statemean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1GQ6_statemean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,1,0,0),
                s=found.sd,
                n=c(49,53,52,57)
)




########################### Negative Affect


French.data$t1NAmean <- rowMeans( French.data[ , c("t1NA1", "t1NA2", "t1NA3", "t1NA4","t1NA5")] ,na.rm=TRUE)

#reliability
alpha(French.data[ , c("t1NA1", "t1NA2", "t1NA3", "t1NA4","t1NA5")])

#backwards way of finding number of participants per condition for each variable
NA.num <- French.data[ , c("t1NAmean", "Condition")]
NA.num2 <- na.omit(NA.num)
summary(NA.num2$Condition)

aggregate(French.data$t1NAmean~Condition, French.data, mean )
aggregate(French.data$t1NAmean~Condition, French.data, sd )


### Trigger vs control
found.m<- doBy::summaryBy(t1NAmean ~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1NAmean.mean"]

found.sd <- doBy::summaryBy(t1NAmean ~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1NAmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(3,-1,-1,-1),
                s=found.sd,
                n=c(50,52,50,56)
)

# k vs c
found.m<- doBy::summaryBy(t1NAmean ~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1NAmean.mean"]

found.sd <- doBy::summaryBy(t1NAmean ~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1NAmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(1,0,-1,0),
                s=found.sd,
                n=c(50,52,50,56)
)

# work vs c
found.m<- doBy::summaryBy(t1NAmean ~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1NAmean.mean"]

found.sd <- doBy::summaryBy(t1NAmean ~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1NAmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(1,0,0,-1),
                s=found.sd,
                n=c(54,56,55,59)
)

# health vs c
found.m<- doBy::summaryBy(t1NAmean ~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1NAmean.mean"]

found.sd <- doBy::summaryBy(t1NAmean ~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1NAmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(1,-1,0,0),
                s=found.sd,
                n=c(54,56,55,59)
)





########################### Embarrassment

French.data$t1Embarrassment <- French.data[ , c("t1NA7")] 

aggregate(French.data$t1Embarrassment~Condition, French.data, mean )
aggregate(French.data$t1Embarrassment~Condition, French.data, sd )

#backwards way of finding number of participants per condition for each variable
emb.num <- French.data[ , c("t1Embarrassment", "Condition")]
emb.num2 <- na.omit(emb.num)
summary(emb.num2$Condition)


# Trigger vs control
found.m<- doBy::summaryBy(t1Embarrassment~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Embarrassment.mean"]

found.sd <- doBy::summaryBy(t1Embarrassment~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Embarrassment.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-3,1,1,1),
                s=found.sd,
                n=c(50,52,50,56)
)

#k vs c
found.m<- doBy::summaryBy(t1Embarrassment~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Embarrassment.mean"]

found.sd <- doBy::summaryBy(t1Embarrassment~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Embarrassment.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,1,0),
                s=found.sd,
                n=c(50,52,50,56)
)

# work vs c
found.m<- doBy::summaryBy(t1Embarrassment~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Embarrassment.mean"]

found.sd <- doBy::summaryBy(t1Embarrassment~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Embarrassment.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,0,1),
                s=found.sd,
                n=c(50,52,50,56)
)

# health vs c
found.m<- doBy::summaryBy(t1Embarrassment~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Embarrassment.mean"]

found.sd <- doBy::summaryBy(t1Embarrassment~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Embarrassment.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,1,0,0),
                s=found.sd,
                n=c(50,52,50,56)
)

########################### Shame

French.data$t1Shame <- French.data[ , c("t1NA8")] 

aggregate(French.data$t1Shame~Condition, French.data, mean )
aggregate(French.data$t1Shame~Condition, French.data, sd )

#backwards way of finding number of participants per condition for each variable
Shame.num <- French.data[ , c("t1Shame", "Condition")]
Shame.num2 <- na.omit(Shame.num)
summary(Shame.num2$Condition)

# Trigger vs control
found.m<- doBy::summaryBy(t1Shame~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Shame.mean"]

found.sd <- doBy::summaryBy(t1Shame~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Shame.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-3,1,1,1),
                s=found.sd,
                n=c(49,52,49,55)
)

#k vs c
found.m<- doBy::summaryBy(t1Shame~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Shame.mean"]

found.sd <- doBy::summaryBy(t1Shame~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Shame.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,1,0),
                s=found.sd,
                n=c(49,52,49,55)
)

# work vs c
found.m<- doBy::summaryBy(t1Shame~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Shame.mean"]

found.sd <- doBy::summaryBy(t1Shame~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Shame.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,0,1),
                s=found.sd,
                n=c(49,52,49,55)
)

# health vs c
found.m<- doBy::summaryBy(t1Shame~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Shame.mean"]

found.sd <- doBy::summaryBy(t1Shame~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Shame.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,1,0,0),
                s=found.sd,
                n=c(49,52,49,55)
)

########################### Discomfort

French.data$t1discomfort <- French.data[ , c("t1NA9")] 

aggregate(French.data$t1discomfort~Condition, French.data, mean )
aggregate(French.data$t1discomfort~Condition, French.data, sd )

#backwards way of finding number of participants per condition for each variable
dis.num <- French.data[ , c("t1discomfort", "Condition")]
dis.num2 <- na.omit(dis.num)
summary(dis.num2$Condition)


# Trigger vs control
found.m<- doBy::summaryBy(t1discomfort~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1discomfort.mean"]

found.sd <- doBy::summaryBy(t1discomfort~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1discomfort.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-3,1,1,1),
                s=found.sd,
                n=c(50,52,49,56)
)

#k vs c
found.m<- doBy::summaryBy(t1discomfort~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1discomfort.mean"]

found.sd <- doBy::summaryBy(t1discomfort~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1discomfort.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,1,0),
                s=found.sd,
                n=c(50,52,49,56)
)

# work vs c
found.m<- doBy::summaryBy(t1discomfort~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1discomfort.mean"]

found.sd <- doBy::summaryBy(t1discomfort~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1discomfort.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,0,1),
                s=found.sd,
                n=c(50,52,49,56)
)

# health vs c
found.m<- doBy::summaryBy(t1discomfort~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1discomfort.mean"]

found.sd <- doBy::summaryBy(t1discomfort~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1discomfort.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,1,0,0),
                s=found.sd,
                n=c(50,52,49,56)
)


########################### Guilt

French.data$t1Guilt1 <- French.data[ , c("t1Guilt")] 

aggregate(French.data$t1Guilt1~Condition, French.data, mean )
aggregate(French.data$t1Guilt1~Condition, French.data, sd )

#backwards way of finding number of participants per condition for each variable
guilt.num <- French.data[ , c("t1Guilt1", "Condition")]
guilt.num2 <- na.omit(guilt.num)
summary(guilt.num2$Condition)

# Trigger vs control
found.m<- doBy::summaryBy(t1Guilt1~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Guilt1.mean"]

found.sd <- doBy::summaryBy(t1Guilt1~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Guilt1.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-3,1,1,1),
                s=found.sd,
                n=c(46,46,47,53)
)

#k vs c
found.m<- doBy::summaryBy(t1Guilt1~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Guilt1.mean"]

found.sd <- doBy::summaryBy(t1Guilt1~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Guilt1.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,1,0),
                s=found.sd,
                n=c(46,46,47,53)
)

# work vs c
found.m<- doBy::summaryBy(t1Guilt1~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Guilt1.mean"]

found.sd <- doBy::summaryBy(t1Guilt1~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Guilt1.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,0,1),
                s=found.sd,
                n=c(46,46,47,53)
)

# health vs c
found.m<- doBy::summaryBy(t1Guilt1~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Guilt1.mean"]

found.sd <- doBy::summaryBy(t1Guilt1~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Guilt1.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,1,0,0),
                s=found.sd,
                n=c(46,46,47,53)
)



########################### Indebted

French.data$t1Indebt1 <- French.data[ , c("t1Indebted")] 
aggregate(French.data$t1Indebt1~Condition, French.data, mean )
aggregate(French.data$t1Indebt1~Condition, French.data, sd )

#backwards way of finding number of participants per condition for each variable
indebt.num <- French.data[ , c("t1Indebt1", "Condition")]
indebt.num2 <- na.omit(indebt.num)
summary(indebt.num2$Condition)

# Trigger vs control
found.m<- doBy::summaryBy(t1Indebt1~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Indebt1.mean"]

found.sd <- doBy::summaryBy(t1Indebt1~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Indebt1.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-3,1,1,1),
                s=found.sd,
                n=c(46,48,47,53)
)



# k vs c
found.m<- doBy::summaryBy(t1Indebt1~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Indebt1.mean"]

found.sd <- doBy::summaryBy(t1Indebt1~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Indebt1.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,1,0),
                s=found.sd,
                n=c(46,48,47,53)
)

# work vs c
found.m<- doBy::summaryBy(t1Indebt1~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Indebt1.mean"]

found.sd <- doBy::summaryBy(t1Indebt1~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Indebt1.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,0,1),
                s=found.sd,
                n=c(46,48,47,53)
)

# health vs c
found.m<- doBy::summaryBy(t1Indebt1~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Indebt1.mean"]

found.sd <- doBy::summaryBy(t1Indebt1~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Indebt1.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,1,0,0),
                s=found.sd,
                n=c(46,48,47,53)
)



############################ Connectedness

French.data$t1Connectednessmean <- rowMeans(French.data[ , c("t1BMPN1", "t1BMPN2", "t1BMPN3", "t1BMPN4","t1BMPN5","t1BMPN6")] ,na.rm=TRUE)

aggregate(French.data$t1Connectednessmean~Condition, French.data, mean )
aggregate(French.data$t1Connectednessmean~Condition, French.data, sd )


#backwards way of finding number of participants per condition for each variable
cnnct.num <- French.data[ , c("t1Connectednessmean", "Condition")]
cnnct.num2 <- na.omit(cnnct.num)
summary(cnnct.num2$Condition)


#reliability
alpha(French.data[ , c("t1BMPN1", "t1BMPN2", "t1BMPN3", "t1BMPN4","t1BMPN5","t1BMPN6")])

#Trigger vs control
found.m<- doBy::summaryBy(t1Connectednessmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Connectednessmean.mean"]

found.sd <- doBy::summaryBy(t1Connectednessmean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Connectednessmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-3,1,1,1),
                s=found.sd,
                n=c(50,53,52,57)
)

#k vs c
found.m<- doBy::summaryBy(t1Connectednessmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Connectednessmean.mean"]

found.sd <- doBy::summaryBy(t1Connectednessmean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Connectednessmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,1,0),
                s=found.sd,
                n=c(50,53,52,57)
)

#work vs c
found.m<- doBy::summaryBy(t1Connectednessmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Connectednessmean.mean"]

found.sd <- doBy::summaryBy(t1Connectednessmean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Connectednessmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,0,1),
                s=found.sd,
                n=c(50,53,52,57)
)


#health vs c

found.m<- doBy::summaryBy(t1Connectednessmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Connectednessmean.mean"]

found.sd <- doBy::summaryBy(t1Connectednessmean~Condition,data=French.data,FUN=sd,na.rm=TRUE)[,"t1Connectednessmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,1,0,0),
                s=found.sd,
                n=c(50,53,52,57)
)




######################## Improvement motivation


French.data$t1Imotivmean <- rowMeans(French.data[ , c("t1Motiv_eff1", "t1Motiv_eff2", "t1Motiv_eff3","t1Motiv_eff4")],na.rm=TRUE )

#reliability
alpha(French.data[ , c("t1Motiv_eff1", "t1Motiv_eff2", "t1Motiv_eff3", "t1Motiv_eff4")])

#backwards way of finding number of participants per condition for each variable
imot.num <- French.data[ , c("t1Imotivmean", "Condition")]
imot.num2 <- na.omit(imot.num)
summary(imot.num2$Condition)


aggregate(French.data$t1Imotivmean~Condition, French.data, mean )

aggregate(French.data$t1Imotivmean~Condition, French.data, sd )

# Trigger vs control
found.m<- doBy::summaryBy(t1Imotivmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Imotivmean.mean"]
found.sd <- doBy::summaryBy(t1Imotivmean~Condition,data=French.data,FUN=sd, na.rm=TRUE)[,"t1Imotivmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-3,1,1,1),
                s=found.sd,
                n=c(52,54,54,59)
)

# kind vs control
found.m<- doBy::summaryBy(t1Imotivmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Imotivmean.mean"]
found.sd <- doBy::summaryBy(t1Imotivmean~Condition,data=French.data,FUN=sd, na.rm=TRUE)[,"t1Imotivmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,1,0),
                s=found.sd,
                n=c(52,54,54,59)
)


# work vs control
found.m<- doBy::summaryBy(t1Imotivmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Imotivmean.mean"]
found.sd <- doBy::summaryBy(t1Imotivmean~Condition,data=French.data,FUN=sd, na.rm=TRUE)[,"t1Imotivmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,0,0,1),
                s=found.sd,
                n=c(52,54,54,59)
)


# health vs control
found.m<- doBy::summaryBy(t1Imotivmean~Condition,data=French.data,FUN=mean,na.rm=TRUE)[,"t1Imotivmean.mean"]
found.sd <- doBy::summaryBy(t1Imotivmean~Condition,data=French.data,FUN=sd, na.rm=TRUE)[,"t1Imotivmean.sd"]
t.contrast.calc(m=found.m,
                lambda=c(-1,1,0,0),
                s=found.sd,
                n=c(52,54,54,59)
)


