# List-wise
This is the source code for KDD'20 Paper List-wise Fairness Criterion for Point Processes

Run RunThisPortland.m to run the total program.

The ReadData.m is the data preprocessing part for Portland Data. The HawkesExampleSimu.m is the feature simulation part for Portland Data. To save the running time, I commented these two file and upload the output files, which are the two .mat files. You can uncomment them to run the total program.

HawkesExample.m is the file running program without adding fairness, HawkesExample50.m is the objective function with our list-wise fairness penalties, and mHawkesExample50.m is the objective function with list-sum fairness penalties. We use the loop to try different level of the trade-off parameters for fairness penalties.

All the original data are in the /data folder. Police_Incidents.csv is the Dallas data from Kaggle(https://www.kaggle.com/carrie1/dallaspolicereportedincidents) and Master Rescue Doc.xlsx is the Houston data(https://data.world/sya/harvey-rescue-doc) for rescue requests during the Hurricane Harvey. The rest of them are Portland Data from George Mohler(https://github.com/gomohler/crimerank). Here we only provide the example for Portland data to run our program as it is easy to extend to other datasets.

Cite: Jin Shang, Mingxuan Sun, and Nina S.N. Lam. 2020. List-wise fairness criterion for point processes. In Proc. of the ACM SIGKDD International Conference on Knowledge Discovery and Data Mining (KDD) DOI: 10.1145/3394486.3403246. 
