# Early-Prediction-of-Sepsis
 This work is based on an open source data which is a Physionet chalIenge 2019. In this project, a prediction model for sepsis has been developed. The data is first explored and cleansed to get an appropriate meta-data. The meta-data serves as an input to the prediction model. Prediction model using logistic regression and KNN was built and accuracy for the respective models was calculated. 

Input:
The physionet link for the data - https://physionet.org/content/challenge-2019/1.0.0/

Steps followed:
![image](https://user-images.githubusercontent.com/63999177/179417728-47db30a2-eb8e-428f-ba2f-8a17addfeb09.png)

Procedure for data cleansing:
![image](https://user-images.githubusercontent.com/63999177/179417829-b378f1e4-91c2-4aa0-af8c-8deeb1f19165.png)

Results:

i) Logistic Regression:
![image](https://user-images.githubusercontent.com/63999177/179417934-73b2d615-b6ba-4015-90d3-0a472924045d.png)

![logistic_validation_1](https://user-images.githubusercontent.com/63999177/179417952-f0fb0810-03c5-4440-9450-a3559a622bfe.png)

ii) KNN:
(Different neighbour values were tried and better accuracy was found for k=100)
![knn_100_1](https://user-images.githubusercontent.com/63999177/179418045-1c93cf5a-82cb-49e7-b824-90788e44970b.png)


