### Describe the CodeBook
The CodeBook.md file contains a description of the data, it includes at the
bottom the original features_info.txt text. It further describes the variables
selected for this analysis, their new variable names, their structure and 
the data in this new tidy data set

### Describe the run_analysis.R file
At various stages of the analysis a message is printed to the console.
The stages follow:- 

#### Load the data on to the system and read files into R
+Load packages required
+Create temporary Directory and File for ext ".zip
+Download the zip file to temporary directory
+Read the zip file and create a list of the files names to extract
+unzip the files from the list
+Read into R all files from the list
+Close the connections (unlink)

#####Comment: This ensures the data is reproducible. When R is closed the
temporary directory and file will be **removed** from the users
system. The output of running the analysis file will remain in the
current working directory of R. This may also take a little longer to
process the analysis so the user should be aware. 

#### Merge the Activity,Subject, Test and Train data sets
+Rename the variable names of the subject and activity data sets
+Column bind the activity.test, subject.test and test.data 
+Column bind the activity.train, subject.train and train.data 
+Row bind the resulting test and training column accumulations
+Perform a test that the row bind is correct by taking the top 
of the test data set and the bottom of the training data set and
checking if they equal the resulting rows in the binded data set.

#### Extract from the Merged Data Set the Required Variables
+Get the id's from the features of the columns required
+Coerce the id's to match the merged data set
+Add to that the id's of the activity and subject columns
+Split the merged data set into new required data set

#### Create labels for the Activity column
+Create activity as a factor column based on the file activity_labels

#### Make the Column Names
+Start with the original feature names for the selected columns
+Parse the original names through a serious of regular expressions and alter
some of the name
+Each pass alters different parts of the names as new labels
+Add the Activity and Subject names and apply as column names
+Arrange the data by Subject and Activity

#####Comment: An attempt to make the names more readable whilst keeping them
close to the orignal names. This helps keep the data owners in tune with the 
changes without too much confusion.


#### Create and Write Out an Independent Data Set
+Group the data by Subject and Activity
+Generate mean data for each Subject and Activity
+Write to the current working directory this data in a file **mean_data_set.txt**



#### None of the Inertial Signals data was used in this data set





##Original ReadMe text

================================================================== Human
Activity Recognition Using Smartphones Dataset Version 1.0
================================================================== Jorge
L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. Smartlab -
Non Linear Complex Systems Laboratory DITEN - Universit‡ degli Studi di
Genova. Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The experiments have been video-recorded to label the data
manually. The obtained dataset has been randomly partitioned into two
sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by
applying noise filters and then sampled in fixed-width sliding windows
of 2.56 sec and 50% overlap (128 readings/window). The sensor
acceleration signal, which has gravitational and body motion components,
was separated using a Butterworth low-pass filter into body acceleration
and gravity. The gravitational force is assumed to have only low
frequency components, therefore a filter with 0.3 Hz cutoff frequency
was used. From each window, a vector of features was obtained by
calculating variables from the time and frequency domain. See
'features_info.txt' for more details.

For each record it is provided: ======================================

- Triaxial acceleration from the accelerometer (total acceleration) and
the estimated body acceleration. - Triaxial Angular velocity from the
gyroscope. - A 561-feature vector with time and frequency domain
variables. - Its activity label. - An identifier of the subject who
carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the
feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity
name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their
descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who
performed the activity for each window sample. Its range is from 1 to
30.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration
signal from the smartphone accelerometer X axis in standard gravity
units 'g'. Every row shows a 128 element vector. The same description
applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt'
files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration
signal obtained by subtracting the gravity from the total acceleration.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity
vector measured by the gyroscope for each window sample. The units are
radians/second.

Notes: ====== - Features are normalized and bounded within [-1,1]. -
Each feature vector is a row on the text file.

For more information about this dataset contact:
activityrecognition@smartlab.ws

License: ======== Use of this dataset in publications must be
acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge
L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a
Multiclass Hardware-Friendly Support Vector Machine. International
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz,
Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or
explicit can be addressed to the authors or their institutions for its
use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita.
November 2012.
