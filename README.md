# What's in this repo

This repo contains code and other stuff for predicting the outcome of soccer matches based on this https://www.kaggle.com/competitions/football-match-probability-prediction/overview dataset.

# Where is the actual data?

Because git doesn't like big files, the actual training and testing data is not in this repository.

After downloading the dataset off of kaggle, I used [create_validation_set.R](create_validation_set.R) to randomly split the data into a training and a testing set (85% and 15% of the total training data respectively). 
Then I used [create_validation_set2.R](create_validation_set2.R) to randomly split that training data into training and testing data. These files start with `base_` and can be viewed as the bottom level of the validation set hierarchy. 

To get this data you have to download it from onedrive. To try out a model, download all 4 files. The `_train.csv` files contain the predictors (`base_train.csv`) and the match results (`base_res_train.csv`) for the training set. The `_test.csv` files contain the same info, but for the testing set, which you can use to calculate the accuracy of your model after training it on the training data.

[base_train.csv](https://wpi0-my.sharepoint.com/:x:/g/personal/awkinley_wpi_edu/EZsjiwOvA1dPk5MaRRKcSXgBZEj2_HbGnViq6g1XqxwMBg?e=ffVtrJ)

[base_res_train.csv](https://wpi0-my.sharepoint.com/:x:/g/personal/awkinley_wpi_edu/EQmcPGDA_h1KvO_4dRP8xjIBAeHG_Jas4zEjN3DjnTsKNw?e=APbKpG)

[base_test.csv](https://wpi0-my.sharepoint.com/:x:/g/personal/awkinley_wpi_edu/EYzAele8y6xJg7_jB4PbxiAB1-kmPBHjSpSrC_Tp5N0cIw?e=hTNyci)

[base_res_test.csv](https://wpi0-my.sharepoint.com/:x:/g/personal/awkinley_wpi_edu/EfIRx0WGq_hKjntUOzljTssB3pNt75cjb6BI_JzAji7g6g?e=dTe1xd)


The training data all in one from this can be downloaded from [match_res_train.csv](https://wpi0-my.sharepoint.com/:x:/g/personal/awkinley_wpi_edu/EQCgebC2lABLmcdYSbJmwOcBDa6slsZ5WAtpk3XRO1gNDA?e=JoY5tB) and [matches_train.csv](https://wpi0-my.sharepoint.com/:x:/g/personal/awkinley_wpi_edu/EeID7MU-vANIt3PfaTi0FwkBIhh1ke8jTJ7NZ2WDNnKlHQ?e=Jnz4FW). (Don't do this unless you explicitly don't want to use the bottom level validation set).

The .gitignore file is set up so that if you download those files and put them in this repo folder, it won't get committed.

# What does the data look like?

Look at [summary.md](summary.md) to see some basic info about the data, primarily what the columns are, and what they look like.