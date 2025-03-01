from sklearn.ensemble import AdaBoostClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import cross_val_score
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import LabelEncoder
import pandas as pd

data = pd.read_csv('final.csv')
X = data.drop(columns=['transfer'])
y = data['transfer']

if y.dtype == 'object':
    y = LabelEncoder().fit_transform(y)

# Separate numeric and categorical columns
numeric_cols = X.select_dtypes(include=['number']).columns
categorical_cols = X.select_dtypes(exclude=['number']).columns

# Fill missing values
X[numeric_cols] = X[numeric_cols].fillna(X[numeric_cols].mean())  # Fill numeric NaNs with mean
X[categorical_cols] = X[categorical_cols].fillna('missing')  # Fill categorical NaNs with 'missing'

# Encode categorical features (if any exist)
if len(categorical_cols) > 0:
    X = pd.get_dummies(X, columns=categorical_cols, drop_first=True)  # One-hot encoding

# Double-check for any remaining NaNs
if X.isna().sum().sum() > 0:
    X = X.fillna(0)  # Replace any remaining NaNs with 0

ada_model = AdaBoostClassifier(
    n_estimators=50,  # Number of boosting rounds
    learning_rate=1.0,
    random_state=42
)

cv_scores = cross_val_score(ada_model, X, y, cv=10, scoring='f1_macro')

print(f"Cross-validation scores: {cv_scores}")
print(f"Mean accuracy: {cv_scores.mean():.4f}")