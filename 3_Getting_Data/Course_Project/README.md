<<<<<<< HEAD
###Course Project for Getting Data

###Author: Scott Lin
=======
Course Project for Getting Data

Author: Scott Lin
===================
>>>>>>> 7ce2b0f542318c4c9c95bb27dbcfb9d025b59698

The files contained in this repo includes:

tidydata.txt <- the output file for the course project

run_analysis.R <- the code used to make the project. This pulled data from the samsung data set, combined only the mean/standard deviation columns and summarized the dataset into a tidy dataset per subject and per activity. Along the way, I also renamed the columns and activity numbers appropriately.

run_analysisme.R <- exact same file, just with the working directory changed so I can work locally. Please ignore for grading.

<<<<<<< HEAD
codebook.txt <- codebook for this assignment in txt form

codebook.docx <- prettier version of the codebook with indenting
=======
codebook.txt <- codebook for this assignment.
>>>>>>> 7ce2b0f542318c4c9c95bb27dbcfb9d025b59698

./UCI HAR Dataset/ <- folder where all the files are pulled from

##Special Notes

There are some intracacies in the project that I chose to interpret on my own. Specifically, for pulling the mean and the standard deviation, I specifically looked for ones with mean() and sd() at the end of it. The resulting tidy data set has a dimension of 180 rows and 69 columns because of this.

Additionally, I summarized all my values based off of three columns. The subject, the activity, and the "group". The group is basically if they were in the test or train group. Because the subject numbers are actually not paired, this shouldn't matter, but I added it in just in case. I took the mean of every column, as I don't know enough about the underlying dataset not to.

Also, for question 4, when I was renaming my columns, I saw a lot of people going fancy. I actually prefer to have a shorter column name and putting the actual description inside the code book for easy reference. Wider column names, to me, is a pain. 

##Packages Used

dplyr - for the select functions