# Stochastic search variable selection (SSVS)


## Variable Selection
The stochastic search variable selection (SSVS), introduced by George and McCulloch[1], is one of the prominent Bayesian variable selection approaches for regression problems. Some of the basic principles of modern Bayesian variable selection methods were first introduced via the SSVS algorithm such as the use of a vector of variable inclusion indicators. SSVS can effectively search large model spaces, identifying the maximum a posteriori and median probability models, and also readily produce Bayesian model averaging estimates. A number of generalizations and extensions of the method have appeared in the statistical literature implementing SSVS to a variety of applications such as generalized linear models, contingency tables, time series data, and factor analysis. This tutorial explains the basics of the SSVS algorithm. 

The first step in understanding the SSVS, is to define the term Bayes factor. Bayes factor is formally defined as follows,
> A Bayes factor is the ratio of the likelihood of one particular hypothesis to the likelihood of another. It can be interpreted as a measure of the strength of evidence in favor of one theory among two competing theories.
<img src="http://www.sciweavers.org/tex2img.php?eq=BF%3D%5Cfrac%7BP%28%20D%7CH_%7B1%7D%29%7D%7BP%28%20D%7CH_%7B0%7D%29%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0" align="center" border="0" alt="BF=\frac{P( D|H_{1})}{P( D|H_{0})}" width="112" height="46" />

In other words bayes factor compares two competing theories and relatively weighs the chances of occurance of one against the other given the data. In terms of variable selection, the bayes factor gets reformulated to answer the critical question, i.e., whether or not to include a particular variable.
$$
BF=\frac{\int\limits _{\beta \ \varepsilon \ M_{1}} L( \beta |M_{k\backslash j}) \pi ( \beta |M_{k\backslash j}) d\beta }{\int\limits _{\beta \ \varepsilon \ M_{1}} L( \beta |M_{k}) \pi ( \beta |M_{k}) d\beta }
 $$
In the above expression, $\beta$ represents the coefficients of the variable in a standard linear regression setting. The prior set for $\beta$ is the spike and slab prior which puts mass at zero and smears mass with a dispersion of $\psi$, as follows,
$$\pi(\beta_j)=\pi_0\delta(\beta_j=0)+(1-\pi_0)N(\beta_j|0,\psi^2).$$ 
$M_{k\backslash j}$ is the model without including the $j^{th}$ variable and $M_{k}$ is the model with the $j^{th}$ variable. The relative BF value provides a "score" of how model $M_{k\backslash j}$ fares with the model $M_{k}$ given the data. The above expression is cumbersome and closed form solution is available if the regression has standard normal error as follows,
$$
y_i=\sum_{j=1}^pf_j(x_{i,j})\beta_j +\epsilon_i,\qquad i=1,\dots, N,
$$
In the limiting case of linear regression with normal errors, BF expression reduces to, 
$$
BF=\frac{\sqrt{2\pi } \psi \ \times e^{\frac{1}{2}\left( \mu ^{T}_{\backslash j} E^{-1}_{\backslash j} \mu _{\backslash j}\right)}( 2\pi )^{k/2} |E_{\backslash j} |^{1/2}}{e^{\frac{1}{2}\left( \mu ^{T} E^{-1} \mu \right)}( 2\pi )^{\frac{k+1}{2}} |E|^{1/2}}\\
\\
E_{\backslash j} =\left(\frac{X^{T}_{\backslash j} X_{\backslash j}}{\sigma ^{2}} +\frac{I}{\psi ^{2}}\right)^{-1}\\
E=\left(\frac{X^{T} X}{\sigma ^{2}} +\frac{I}{\psi ^{2}}\right)^{-1}
$$
The expression simplifies in log form,
log( BF) =log( numerator) -log( denominator)
![](https://i.imgur.com/h1jrg2g.png)
In the above expression, $\psi$ is a hyperparameter to be set by the user, this parameter decides how much dispersion is allowed in the beta coefficient parameter. One way to set the value is standardize all predictor variables to have zero mean and unit standard deviation and then set the value of $\psi$ to be 1.69, 1.96 or 2.25.

### Example problem
A simple linear regression toy example is created to demonstrate the applicability of the SSVS method.
$$
y_i=\sum_{j=1}^pf_j(x_{i,j})\beta_j +\epsilon_i,\qquad i=1,\dots, N,
$$
#### Step 1: Generate pseudo data.
$$
Y_i=-0.41X_1+1.89X_2+3.51X_3   -2.38X_4+6.94X_{10}
$$
Generating 50 data points of y using the above mentioned formule, where $X_1$ to $X_{10}$ are the possible predictor variables. 
![](https://i.imgur.com/A8hOAP0.jpg)
In the original problem, the required task is to identify the pertinent predictor variable and find out its coefficient value. To recreate the same, a library candidate of 10 variables are created ($X_1$ to $X_{10}$) and the box plot is shown below,
![](https://i.imgur.com/vkMbk0Y.jpg)

In the above example the main aim of the algorithm is to fish out the correct X variables that went into forming the response variable and calculate the coefficient of those regressors.
