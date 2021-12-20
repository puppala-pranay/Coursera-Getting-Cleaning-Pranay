# Coursera-Getting-Cleaning-Pranay

## For the script to work , the samsung data should be in the working directory

### Steps taken :

- Train data is extracted and features, Activity, Subject are appended
- Test data is also extracted in the same way
- Both the data are combined and the data frame is labeled by descriptive names form features file
- From all the columns only the required columns are extracted(mean(),strd())
- The numerical form of activities decoded with descriptive names
- Finally a new dataframe is created with means of all variables of each subject and each activity by spliting the complete data table
- Output is obtained in final_tidy.txt
