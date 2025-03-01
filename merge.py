# purpose of this file is to merge the merge.csv and PortalData_2023

import pandas as pd

df_merged = pd.read_csv('merged.csv')
df_portal = pd.read_csv('PortalData_2023.csv')

# add null value for all 'Transfer' in merged to be adjusted later
df_merged['Transfer'] = pd.NA

df_final = df_merged.merge(
    df_portal[['Player', 'Team_New', 'Transfer']],  # Only keep necessary columns
    left_on=['player', 'Team'],
    right_on=['Player', 'Team_New'],
    how='left'
)

df_final.drop(columns=['Player', 'Team_New'], inplace=True, errors='ignore')

output = 'final.csv'

# df_final.to_csv(output, index=False)

transfer_counts = df_final['Transfer_y'].value_counts(dropna=False)

num_true = transfer_counts.get(True, 0)
num_false = transfer_counts.get(False, 0)
num_nan = transfer_counts.get(pd.NA, 0)  # Count NaN values separately

print(f"True count: {num_true}")
print(f"False count: {num_false}")
print(f"NaN count: {num_nan}")