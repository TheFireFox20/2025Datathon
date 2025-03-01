from pycaret.classification import *
import pandas as pd
import os

data = pd.read_csv('final.csv')

exp = ClassificationExperiment()
exp.setup(data, target='transfer')

models = exp.compare_models(n_select=5)

for model in models:
    print(model)
    plot_model(model, plot='feature')

# folder_merger
#
# folders = ['defense_standard', 'kick_return_standard', 'kicking_standard',
#            'passing_standard', 'rushing_standard', 'scoring_standard']
# for folder in folders:
#     output_file = os.path.join(folder, 'merged.csv')
#     dfs = []
#     # list all dfs in defense
#     for file in os.listdir(folder):
#         file_path = os.path.join(folder, file)
#         df = pd.read_csv(file_path)
#         dfs.append(df)
#     # merge dfs
#     merged_df = pd.concat(dfs, ignore_index=True)
#     merged_df.to_csv(output_file, index=False)
#
# # -------------------------------------------------------------------
#
# output = 'total_data.csv'
# dfs = []
# for folder in folders:
#     file_path = os.path.join(folder, 'merged.csv')
#     df = pd.read_csv(file_path)
#     dfs.append(df)
#
# merged_df = pd.concat(dfs, ignore_index=True)
# merged_df.to_csv(output, index=False)
#
# # --------------------------------------------------------------------
#
# # if duplicate name / pos / team, merge record
# df = merged_df
# # merged data
# def merge_group(group):
#     return group.ffill().bfill().iloc[-1]  # Fill missing values and keep the last row
#
# # Group by player, pos, and team, then apply the merge function
# df_merged = (df.groupby(['player', 'pos', 'Team', 'Year'])
#              .apply(merge_group).reset_index(drop=True))
#
# duplicates = df[df.duplicated(subset=['player', 'pos', 'Team', 'Year'], keep=False)]
#
# output = 'merged.csv'
# df_merged.to_csv(output, index=False)




