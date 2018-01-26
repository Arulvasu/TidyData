# *Cleaning and Getting Data* course project code book

### Analysis process

The analysis script, `run_analysis.R` reads in the processed experiment data and performs a number of steps to get it into summary form.

 - Both the processed test and training datasets are read in and merged into one data frame.
 - The data columns are then given names based on the `features.txt` file.
 - Columns that hold mean or standard deviation measurements are selected from the dataset, while the other measurement columns are excluded from the rest of the analysis.
 - The activity identifiers are replaced with the activity labels based on the `activity_labels.txt` file.
 - Invalid characters (`()` and `-` in this case) are removed from the column names. Also, duplicate phrase `BodyBody` in some columns names is replaced with `Body`.
 - The data is then grouped by subject and activity, and the mean is calculated for every measurement column.
 - Finally, the summary dataset is written to a file, `tidyData.txt`.

Each line in `run_analysis.R` is commented. Reference the file for more information on this process.

### Columns in output file

The columns included in the output file are listed below:

  - subject - The id of the experiment participant.
  - activityDescription - The name of the activity that the measurements correspond to, like `LAYING` or `WALKING`.

All of the following fields represent the mean of recorded data points for the given subject and activity. The detailed description of the different measurement types can be found in the `features_info.txt` file included in the data [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

  - time_BodyAcceleration_mean_X
  - time_BodyAcceleration_mean_Y
  - time_BodyAcceleration_mean_Z
  - time_BodyAcceleration_std_X
  - time_BodyAcceleration_std_Y
  - time_BodyAcceleration_std_Z
  - time_GravityAcceleration_mean_X
  - time_GravityAcceleration_mean_Y
  - time_GravityAcceleration_mean_Z
  - time_GravityAcceleration_std_X
  - time_GravityAcceleration_std_Y
  - time_GravityAcceleration_std_Z
  - time_BodyAccelerationJerk_mean_X
  - time_BodyAccelerationJerk_mean_Y
  - time_BodyAccelerationJerk_mean_Z
  - time_BodyAccelerationJerk_std_X
  - time_BodyAccelerationJerk_std_Y
  - time_BodyAccelerationJerk_std_Z
  - time_BodyGyro_mean_X
  - time_BodyGyro_mean_Y
  - time_BodyGyro_mean_Z
  - time_BodyGyro_std_X
  - time_BodyGyro_std_Y
  - time_BodyGyro_std_Z
  - time_BodyGyroJerk_mean_X
  - time_BodyGyroJerk_mean_Y
  - time_BodyGyroJerk_mean_Z
  - time_BodyGyroJerk_std_X
  - time_BodyGyroJerk_std_Y
  - time_BodyGyroJerk_std_Z
  - time_BodyAccelerationMagnitude_mean
  - time_BodyAccelerationMagnitude_std
  - time_GravityAccelerationMagnitude_mean
  - time_GravityAccelerationMagnitude_std
  - time_BodyAccelerationJerkMagnitude_mean
  - time_BodyAccelerationJerkMagnitude_std
  - time_BodyGyroMagnitude_mean
  - time_BodyGyroMagnitude_std
  - time_BodyGyroJerkMagnitude_mean
  - time_BodyGyroJerkMagnitude_std
  - force_BodyAcceleration_mean_X
  - force_BodyAcceleration_mean_Y
  - force_BodyAcceleration_mean_Z
  - force_BodyAcceleration_std_X
  - force_BodyAcceleration_std_Y
  - force_BodyAcceleration_std_Z
  - force_BodyAcceleration_meanFrequency_X
  - force_BodyAcceleration_meanFrequency_Y
  - force_BodyAcceleration_meanFrequency_Z
  - force_BodyAccelerationJerk_mean_X
  - force_BodyAccelerationJerk_mean_Y
  - force_BodyAccelerationJerk_mean_Z
  - force_BodyAccelerationJerk_std_X
  - force_BodyAccelerationJerk_std_Y
  - force_BodyAccelerationJerk_std_Z
  - force_BodyAccelerationJerk_meanFrequency_X
  - force_BodyAccelerationJerk_meanFrequency_Y
  - force_BodyAccelerationJerk_meanFrequency_Z
  - force_BodyGyro_mean_X
  - force_BodyGyro_mean_Y
  - force_BodyGyro_mean_Z
  - force_BodyGyro_std_X
  - force_BodyGyro_std_Y
  - force_BodyGyro_std_Z
  - force_BodyGyro_meanFrequency_X
  - force_BodyGyro_meanFrequency_Y
  - force_BodyGyro_meanFrequency_Z
  - force_BodyAccelerationMagnitude_mean
  - force_BodyAccelerationMagnitude_std
  - force_BodyAccelerationMagnitude_meanFrequency
  - force_BodyAccelerationJerkMagnitude_mean
  - force_BodyAccelerationJerkMagnitude_std
  - force_BodyAccelerationJerkMagnitude_meanFrequency
  - force_BodyGyroMagnitude_mean
  - force_BodyGyroMagnitude_std
  - force_BodyGyroMagnitude_meanFrequency
  - force_BodyGyroJerkMagnitude_mean
  - force_BodyGyroJerkMagnitude_std
  - force_BodyGyroJerkMagnitude_meanFrequency



### More information

Detailed information on the experiment and the data can be found in the `README.txt` and `features_info.txt` files included in the experiment data [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) or find more information on the dataset [homepage](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).