# List-wise
This is the source code for KDD'20 Paper List-wise Fairness Criterion for Point Processes

We implement it in Matlab. The RunThisPortland.m is used to run the total program.

The ReadData.m is the data preprocessing part for Portland Data. The HawkesExampleSimu.m is the sensitive feature simulation part for Portland Data. To save the running time, I commented these two file in RunThisPortland.m and upload the output files, which are the two .mat files. You can uncomment them to run the total program.

HawkesExample.m is the file running program without adding fairness, HawkesExample50.m is the objective function with our list-wise fairness penalties (NDCG@50), and mHawkesExample50.m is the objective function with list-sum fairness penalties (Patrol@50). We use the loop to try different level of the trade-off parameters for fairness penalties.

All the original data are in the /data folder. Police_Incidents.csv is the Dallas data from Kaggle (https://www.kaggle.com/carrie1/dallaspolicereportedincidents) and Master Rescue Doc.xlsx is the Houston data (https://data.world/sya/harvey-rescue-doc) for rescue requests during the Hurricane Harvey. The rest of them are Portland Data from George Mohler (https://github.com/gomohler/crimerank). Here we only provide the example for Portland data to run our program as it is easy to extend to other datasets.

We appreciate Professor George Mohler (https://www.georgemohler.com/) for providing his source code for the paper "A penalized likelihood method for balancing accuracy and fairness in predictive policing" at IEEE International Conference on Systems, Man, and Cybernetics (SMC2018). In the paper we compared our method with their method, which we name is list-sum fairness (Patrol@k).

Cite: Jin Shang, Mingxuan Sun, and Nina S.N. Lam. 2020. List-wise fairness criterion for point processes. In Proc. of the ACM SIGKDD International Conference on Knowledge Discovery and Data Mining (KDD) DOI: 10.1145/3394486.3403246. 
