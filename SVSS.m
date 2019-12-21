clear all
clc
close all
%% Stochastic Variable selection algorithm matlab script
% This code is based on conjugate priors

%% Generate pseudo random data
init_data.predictor_np=10;
init_data.order=1;
init_data.N=100;
init_data.predictor=randn([init_data.N,init_data.predictor_np]);
init_data=generate_data(init_data);

init_data.noofterms=floor(size(init_data.predictor_column,2)/2);
rng(0,'v5uniform');
init_data.actualmodelterms=randi([1,size(init_data.predictor_column,2)],[init_data.noofterms,1]);
init_data.actualmodelpredictors=init_data.predictor_column(:,init_data.actualmodelterms);
init_data.response=sum(init_data.actualmodelpredictors,2)+0.03*randn([init_data.N,1]);


%% SVSS algorithm
data_available.variance=100;
data_available.response=init_data.response;
data_available.predictor_library=init_data.predictor_column;
data_available.org_predictor=init_data.predictor;
M1=[10 3 7 9]%init_data.actualmodelterms;
M2=[10 3 5 7 9];
bf=compute_bayes_fac(M1,M2,data_available);
