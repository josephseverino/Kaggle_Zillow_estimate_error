# Zillow Prize: Zillow’s Home Value Prediction (Zestimate)
#### Improving the algorithm that changed the world of real estate
 

### Problem Statement

<span style="font-family:Papyrus"> 
Using the error(log error) from the Zestimate predictions, can we improve upon Zillow's home sales predictions? 

</span>

[Kaggle Competition Link](https://www.kaggle.com/c/zillow-prize-1)

#### Introduction

<span style="font-family:Papyrus"> 
 In the past few years, Zillow has transformed the homebuyer experience from speculation to a more well-informed prediction for buyers and sellers. This predictive advantage has added more insight to the marketplace by understanding the current and future value of homes. Understanding these predictive algorithms and improving their accuracy will contribute to a more informed market for home buyers and sellers. My presentation is designed to understand which factors influence the existing models Zillow uses and explore future data engineering for improved predictions. My project investigated oversampling and model stacking versus simple regression models in order to predict on Zillow existing model errors. 
</span>

#### What am I solving? Why is it important? 


##### Goal: Improve Zillow’s current model 
* Evaluated by MAE of Regression Model
Importance: 
* Improving existing models
* Outlier detection
* Data Cleaning
* Dealing with sparse data
* Over-sampling



#### Methodology


1. Download Data from Kaggle:   Train Set ≈90,000   Test Set ≈3,000,000
2. Merge dataset on ParcelID (most code done in Python some in R)
3. EDA and Data imputation (FancyImpute)
4. Feature Engineering based on Nearest Neighbor attributes mean ratio + Elevation Google API & custom NN algorithm)
5. Oversample outliers as Categorical features (SMOTE)
6. Stacking models: Classifier models as features and regression model as predictors
7. Train and optimize models using GridSearchCV
8. Random Forest - Classifier
9. Xgboost - Regression
10. Repeat steps for Test Set
11. Create predictions for 6 different periods (OCT, NOV, DEC for 2016 and 2017) and Submit to Kaggle





## Feature Engineering

<span style="font-family:Papyrus"> 
 In the display below, we can visually see how I engineered my features around each data point. The circle represents euclidean distance from the center point in red. All the surrounding points are it's nearest neighbors (NN). Taking in several sizes of NN's (i.e. K = 5, 20 & 100 neighbors) we can construct many location features to compare relative relationships. For example, the features that were created consisted of the following (all with relation to mean of neighbors: feature/average of neighbors) :
</span>

* Bath count
* Bedroom count
* Square footage
* Taxamount (psuedo relation to value of home)
* Log Error
* Elevation
 
<p align="center">
  <h3>Nearest Neighbor Feature Engineering </>
  <img src="/Images/NNfeateng.png" )
</p>

## Issues: Time Constraints & Computation Expense

<span style="font-family:Papyrus"> 
Due to computation expenses of running all 2.9 million points, I decided it would better to build KNN features when I have access to a GPU. 
</span>

<p align="center">
  <h3>Feature Engineering and Imputation Issues </>
  <img src="/Images/issueSlide.png" )
</p>
   
 ## EDA: Target

* Left and right tails are long 
* Most error is centered around zero
* Assuming the log is of base *e* we get the following predictions compared to actual sales price
* Max error seems very unreasonable, but there are very few occurances. 

<p align="center">
  <h3>Target Variable - Log Error </>
  <img src="/Images/targetEDA.png" )
</p>

## Interesting Feature EDA

* Both plots show a negative relationship between X-values and variance of Target variable.
* Smaller values of X-axis show less predictability of our target value (High variance)
* Elevation has to two levels of high to low variance 
* X values with lower variance tend to be of the lowest error
* Low variance also has a relationship with supply of given X-axis ranges
* For future research I would consider binning these features for better accuracy

<p align="center">
  <h3>Interesting Features (future feature engineering)</>
  <img src="/Images/EDAinterestingFeats.png" )
</p>

## EDA: Location, Location Location

* Both plots are showing only outliers of log error greater than .25 and less than -.25
* (left plot) Clustering for both over-estimates and under-estimates
* (right plot) better view of clustering of outliers. 

<p align="center">
  <h3>Latitude vs Longitude with Log Error </>
  <img src="/Images/GEOEDA.png" )
</p>

<p align="center">
  <h3>Location Zoomed In</>
  <img src="/Images/zoomGEO.png" )
</p>

<p align="center">
  <h3>Time Series</>
  <img src="/Images/timeseries.png" )
</p>
   
<p align="center">
  <h3>Year Built vs Log Error</>
  <img src="/Images/yearbuilt.png" )
</p>

## Model Stacking

<span style="font-family:Papyrus"> 
Model stacking is a type of ensemble model where several different models are used to predict the target variable. Once that model is built, it is used to predict on both the validation and test sets. Those predictions are then used to as features in all three to help the regression model. In this particular model, I used three Random Forest Classifiers as my new features. The classification model was predicting the right and left tails of the log error distribution using various thresholds for classifying an outlier. Naturally, these points were under-represented (scarce), thus I used over-sampling to weigh the target variables as being important.
</span>

<p align="center">
  <h3>Model Stacking Visual</>
  <img src="/Images/modelStack.png" )
</p>
   
<p align="center">
  <h3>Classifier: Outliers as Features</>
  <img src="/Images/classifier.png" )
</p>
   
## Regression Model

<span style="font-family:Papyrus"> 
</span>

<p align="center">
  <h3>Tune Regression Model: Methodology </>
  <img src="/Images/tuneMethodology.png" )
</p>
   
## 
   
<p align="center">
  <h3>Plots: Regresssion Results </>
  <img src="/Images/regResults.png" )
</p>
   
## Model Performance

* Simple Random Forest model did best
* XgBoost requires extensive hyperparameter searches for optimal performance (GPUs work best)
* Xgboost with stacking overfitted training data
* Stacking made model bias toward outliers

<p align="center">
  <img src="/Images/performance.png" )
</p>

## Conclusion

* Explore Supply of houses with certain features (e.g. 3 bedroom houses vs 20 bedroom homes have higher supply in market) 
* Use GPU to do more robust features
* Try stacking with regression models
* Tune Classification models for more conservative False Positives (this will decrease True Positives as consequence)
* Stack various types of models (i.e. KNN, Niave Bayes, SVM, Logistic Regressor, DNN etc.)
