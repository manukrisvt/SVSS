function [bf_inv,pr]=compute_bayes_fac_V2(M1,M2,data_available)
    Y=data_available.response;
    pi0=data_available.init_pi0;
    Y_var=data_available.var_Y;
    N=length(data_available.response);
    X_variance=data_available.Xvar;
    X_M1=data_available.predictor_library(:,M1); %X_j
    X_M2=data_available.predictor_library(:,M2); %X_(-j)
    Beta_M2=data_available.beta(:,M2)';
    
    Variance=1/((1/Y_var)*(X_M1'*X_M1)+(1/X_variance));
    Meanval=Variance*X_M1'*(Y-X_M2*Beta_M2)/Y_var;
    log_num=log(1/sqrt(X_variance));
    log_denom=log(1/sqrt(Variance))-0.5*(Meanval^2)/Variance;
    log_bayes_fac_inv=log_num-log_denom;
    bf_inv=exp(log_bayes_fac_inv);
    pr.H0=inv(1+((1-pi0)/pi0)*bf_inv);
    pr.E=Meanval;
    pr.V=Variance;
end
