# SequentialForwardSelection

It performs sequential forward selection respectively on the dataset sequentialDataset.mat using Bayesian classification accuracy as the criterion.

Bayesian Classification is done in **gaussdens.m**.

Finding means of the training data, classification and accuracy tests are done in **hesapla.m**. Basically sequential forward selection function is **hesapla.m**.

## Dataset
There are four classes where each class consists of 8-dimensional 160 feature vectors in sequentialDataset.mat dataset.

80 feature vectors are used for training and the remaining 80 feature vectors are used for testing in each class.

## Results

It selects optimum features. In this case the result is " 0     1     1     1     0     0     1     1 " which means 2, 3, 4, 7 and 8th features are selected.
