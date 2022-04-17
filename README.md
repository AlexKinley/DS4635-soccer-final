# What's in this repo

This repo contains code and other stuff for predicting the outcome of soccer matches based on this https://www.kaggle.com/competitions/football-match-probability-prediction/overview dataset.

# Where is the actual data?

Because git doesn't like big files, the actual training and testing data is not in this repository.

After downloading the dataset off of kaggle, I used [create_validation_set.R](create_validation_set.R) to randomly split the data into a training and a testing set (85% and 15% of the total training data respectively). 
The training data from this can be downloaded from [match_res_train.csv](https://wpi0-my.sharepoint.com/:x:/g/personal/awkinley_wpi_edu/EQCgebC2lABLmcdYSbJmwOcBDa6slsZ5WAtpk3XRO1gNDA?e=JoY5tB) and [matches_train.csv](https://wpi0-my.sharepoint.com/:x:/g/personal/awkinley_wpi_edu/EeID7MU-vANIt3PfaTi0FwkBIhh1ke8jTJ7NZ2WDNnKlHQ?e=Jnz4FW).

The .gitignore file is set up so that if you download those files and put them in this repo folder, it won't get committed.

# What does the data look like?

Look at [summary.md](summary.md) to see some basic info about the data, primarily what the columns are, and what they look like.