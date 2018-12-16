# Zillow Prize: Zillow’s Home Value Prediction (Zestimate)
#### Improving the algorithm that changed the world of real estate
 

### Problem Statement

<span style="font-family:Papyrus"> 
Using the error(log error) from the Zestimate predictions, can we improve upon Zillow's home sales predictions? 
</span>

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
</span>

<p align="center">
  <h3>Nearest Neighbor Feature Engineering </>
  <img src="/Images/NNfeateng.png" )
</p>

## Issues: Time Constraints & Computation Expense

<span style="font-family:Papyrus"> 
</span>

<p align="center">
  <h3>Feature Engineering and Imputation Issues </>
  <img src="/Images/issueSlide.png" )
</p>
   
 ## EDA: Target

<span style="font-family:Papyrus"> 
</span>

<p align="center">
  <h3>Target Variable - Log Error </>
  <img src="/Images/targetEDA.png" )
</p>

## Interesting Feature EDA

<span style="font-family:Papyrus"> 
</span>

<p align="center">
  <h3>Interesting Features (future feature engineering)</>
  <img src="/Images/EDAinterestingFeats.png" )
</p>

## EDA: Location, Location Location

<span style="font-family:Papyrus"> 
</span>

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

<p align="center">
  <img src="/Images/performance.png" )
</p>

##
