SVSS
Stochastic Search Variable Selection:
-----------------------------------------
The main steps of the
algorithm is as explained below,
Gibbs sampling steps:

At every iteration of MCMC, a model is generated
At every iteration, 2^p models are evaulated
The 𝜎 term sampling is built inside the algorithm using a gamma random variable, and is sampled at each step of the iteration
At the end of Gibbs sampling, the algorithm returns directly the value of the beta coefficient

The most important factor affecting the algorithm are
1.) Tuning the 𝜎, standard deviation of response
2.) Tuning the 𝜓, the standard deviation for the beta coeff model
To address the 𝜓 part, standardization is recommended for the predictor variables and hence
𝜓 = 1.69 𝑜𝑟 1.96 𝑜𝑟 2.25

