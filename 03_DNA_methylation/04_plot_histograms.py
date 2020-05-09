import pandas as pd
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

i = 1
plt.figure(figsize = (15, 4))
for f, title in zip(['8cell_rep1.CpG_report.merged_CpG_evidence.cov',
                     'ICM_rep1.CpG_report.merged_CpG_evidence.cov',
                     'Epiblast_rep1.CpG_report.merged_CpG_evidence.cov'],
                    ['8cell_rep1', 'ICM_rep1', 'Epiblast_rep1']):
    
    data = pd.read_csv(f, header = None, sep = '\t')

    plt.subplot(1, 3, i)
    plt.title(title + ', chr14', fontsize = 14)
    plt.hist(data[3].values, bins = 20, edgecolor = 'k', alpha = .75)
    i += 1
    plt.ylim((0, 400000))
    plt.xlabel('% Methylation', fontsize = 12)
    plt.ylabel('Frequency', fontsize = 12)
plt.tight_layout()
plt.savefig('methylation_percentage_hist.png', bbox_inches = 'tight')
