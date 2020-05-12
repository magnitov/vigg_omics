import pandas as pd
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

data = pd.read_csv('./CpG_methylation/cpgs_adjusted.bed', header = None, sep = '\s+')
data = data[data[6] != '-1-1']

plt.figure(figsize = (7, 5))
plt.title('ICM vs Epiblast DMCs, adjusted p-values', fontsize = 14)
plt.hist(np.abs([float(x) for x in data[6].values]), bins = 40, edgecolor = 'k', alpha = .75)
plt.xlabel('Adjusted p-value', fontsize = 12)
plt.ylabel('Frequency', fontsize = 12)
plt.savefig('./figures/pvalues_hist.png', bbox_inches = 'tight')

data = pd.read_csv('./CpG_methylation/dmrs.bed', header = None, sep = '\s+')

plt.figure(figsize = (7, 5))
plt.title('ICM vs Epiblast number of Cs in DMR', fontsize = 14)
plt.hist(data[4].values, bins = 40, edgecolor = 'k', alpha = .75, range = (0, 200))
plt.xlabel('Number of cytosines', fontsize = 12)
plt.ylabel('Frequency', fontsize = 12)
plt.savefig('./figures/cytosines.png', bbox_inches = 'tight')
