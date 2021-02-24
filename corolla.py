import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
# Q-Q Plot
from scipy import stats
import pylab
import statsmodels.formula.api as smf 
import statsmodels.api as sm



# imported data set from clicking on the icon because it was showing the error 'utf-8' codec can't decode byte 0xa0 in position 0: invalid start byte


ml_new = smf.ols('Price ~ Age_08_04+KM+HP+cc+Gears+Quarterly_Tax+Weight',data = corolla).fit() 
ml_new.summary()
sm.graphics.influence_plot(ml_new)


pred = ml_new.predict(corolla)

# Q-Q plot
res = ml_new.resid
sm.qqplot(res)
plt.show()

# Q-Q plot
stats.probplot(res, dist = "norm", plot = pylab)
plt.show()

# Residuals vs Fitted plot
sns.residplot(x = pred, y = corolla.Price, lowess = True)
plt.xlabel('Fitted')
plt.ylabel('Residual')
plt.title('Fitted vs Residual')
plt.show()

sm.graphics.influence_plot(ml_new)



#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
### Splitting the data into train and test data 
from sklearn.model_selection import train_test_split
corolla_train, corolla_test = train_test_split(corolla, test_size = 0.2) # 20% test data

# preparing the model on train data 
model_train = smf.ols('Price ~ Age_08_04+KM+HP+cc+Gears+Quarterly_Tax+Weight', data = corolla_train).fit()

# prediction on test data set 
test_pred = model_train.predict(corolla_test)

# test residual values 
test_resid = test_pred - corolla_test.Price
# RMSE value for test data 
test_rmse = np.sqrt(np.mean(test_resid * test_resid))
test_rmse


# train_data prediction
train_pred = model_train.predict(corolla_train)

# train residual values 
train_resid  = train_pred - corolla_train.Price
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid * train_resid))
train_rmse
