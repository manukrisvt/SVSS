function bf=compute_bayes_fac(M1,M2,data_available)
    variance=data_available.variance;
    Y=data_available.response;
    pi0=0.5;
    Y_var=var(Y);
    N=length(data_available.response);
    X_variance=2;
    X_M1=data_available.predictor_library(:,M1);
    X_M2=data_available.predictor_library(:,M2);
    
    
    Epsilon_inv_M1=(X_M1'*X_M1/Y_var+...
        eye(length(M1),length(M1))/X_variance);
    
    Epsilon_inv_M2=(X_M2'*X_M2/Y_var+...
        eye(length(M2),length(M2))/X_variance);
    
    bf.lognumerator=log(sqrt(2*pi*Y_var))+0.5*log(det(inv(Epsilon_inv_M1)))+...
        +(0.5/Y_var^2)*Y'*X_M1*inv(Epsilon_inv_M1)'*X_M1'*Y;
   bf.logdenominator=0.5*log(2*pi)+0.5*log(det(inv(Epsilon_inv_M2)))+...
        +(0.5/Y_var^2)*Y'*X_M2*inv(Epsilon_inv_M2)'*X_M2'*Y;
    bf.val=exp(bf.lognumerator-bf.logdenominator);
    pr_m1_m2=inv(1+((1-pi0)/pi0)*inv(bf.val))
    
end
