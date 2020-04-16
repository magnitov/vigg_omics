import pandas as pd
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

ale = pd.read_csv('ALE_summary.txt', sep = '\t', header = None).iloc[0].values[:][1:]
N50 = pd.read_csv('QUAST_summary.txt', sep = '\t', header = 0).iloc[16].values[:][1:]
contigs_num = pd.read_csv('QUAST_summary.txt', sep = '\t', header = 0).iloc[12].values[:][1:]
length = pd.read_csv('QUAST_summary.txt', sep = '\t', header = 0).iloc[6].values[:][1:]

plt.figure(figsize = (9, 10))
plt.suptitle('Platanus assembly of Influenza virus A, optimal k=27', fontsize = 14, y = 0.92)

plt.subplot(411)
plt.plot(np.arange(15, 61, 3), N50)
plt.scatter(np.arange(15, 61, 3), N50)
plt.ylabel('N50', fontsize = 12)
plt.axvline(27, color = 'k', linestyle = '--', alpha = .7)

plt.subplot(412)
plt.plot(np.arange(15, 61, 3), ale)
plt.scatter(np.arange(15, 61, 3), ale)
plt.ylabel('ALE score', fontsize = 12)
plt.axvline(27, color = 'k', linestyle = '--', alpha = .7)

plt.subplot(413)
plt.plot(np.arange(15, 61, 3), contigs_num)
plt.scatter(np.arange(15, 61, 3), contigs_num)
plt.ylabel('Number of contigs', fontsize = 12)
plt.axvline(27, color = 'k', linestyle = '--', alpha = .7)

plt.subplot(414)
plt.plot(np.arange(15, 61, 3), length)
plt.scatter(np.arange(15, 61, 3), length)
plt.xlabel('Platanus assembly k-mer', fontsize = 12)
plt.ylabel('Assembly size, bp', fontsize = 12)
plt.axvline(27, color = 'k', linestyle = '--', alpha = .7)

plt.savefig('platanus_assembly_metrics.png', bbox_inches = 'tight')
plt.show()
