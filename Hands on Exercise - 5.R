###########################################################################
#Hand on Exercise - 5
#Questions

#Q.1 -> Combine the datasets (Emp and Dept) and create a dataset which  has department name and location along with 
#employee information 

#Q.2 -> Find the average salary by location.

#Q.3 -> Create a dataset which has name of employee along with its manager name and find the manager who has the most
#direct reportees

#Q.4 -> If salary increment across levels are given (as in question), what would be the salary after increment

###########################################################################

#Load the required packages
library(data.table)
library(qdap)

###########################################################################
#Code for Q.1 begins from here

#Get the current working directory
getwd()

#Set the working directory as the directory which contains the 2 datasets
setwd("C:\\YYYYYY\\AMMA 2017\\Data\\data_2017\\data_2017")

#Read the Emp dataset
Emp <- read.csv('Emp.csv')

#Read the Dept dataset
Dept <- read.csv('Dept.csv')

#Merge the two datasets based on the Department No column(DEPTNO)
final <- merge(Emp, Dept, by = "DEPTNO")

#View the final merged dataset
View(final)

#Code for Q.1 ends here
###########################################################################


###########################################################################
#Code for Q.2 begins from here

#Use aggregate() function to find the mean salary for each location
average_data <- aggregate(final[,'SAL'],list(Location = final$LOC), FUN = mean)

#Change the column name to 'Average salary'
colnames(average_data) <- c("Location", "Average salary")

#View the average salary by location
View(average_data)

#Code for Q.2 ends here
###########################################################################


###########################################################################
#Code for Q.3 starts here

#Use the lookup function which works similarly to Vlookup of Excel
#Add the manager name in a new column 'manager_name'
final$manager_name <- lookup(final$MGR, final[,2:3])

#List out the number of reportees for each manager
employee_count <- aggregate(final[,"manager_name"], list(final$manager_name), FUN = length)

#Change the column name to 'reporting_employees'
colnames(employee_count) <- c("manager_names", "reporting_employees")

#View the manager with the maximum number of reportees
employee_count[which.max(employee_count$reporting_employees),]

#aggregate((employee_count$reporting_employees), list(employee_count$manager_names), FUN = max)

#Code for Q.3 ends here
###########################################################################



###########################################################################
#Code for Q.4 starts here

for(i in 1:nrow(final)) #Loop till the end of the rows of 'final' dataset
{
  if (final[i,4] == 'ANALYST'){                   #15% increment
    final[i,7] <- (final[i,7]*1.15)           
  }else if (final[i,4] == 'CLERK'){               #12.5% increment
         final[i,7] <- (final[i,7]*1.125)
  }else if (final[i,4] == 'MANAGER'){             #10.2% increment
         final[i,7] <- (final[i,7]*1.102)
  }else if (final[i,4] == 'PRESIDENT'){           #5.7% increment
         final[i,7] <- (final[i,7]*1.057)
  }else if(final[i,4] == 'SALESMAN'){
         final[i,7] <- (final[i,7]*1.133)
  }else{
    NULL
  }  
}

#Code for Q.4 ends here
###################################################################################

#End-of-exercise
###################################################################################