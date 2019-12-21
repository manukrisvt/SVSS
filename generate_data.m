function [init_data]=generate_data(init_data)
init_data.predictor_column=init_data.predictor;
flg=size(init_data.predictor_column,2);

if init_data.order==2
    for ni=1:size(init_data.predictor,2)
        for nj=ni:ni
            flg=flg+1;
            init_data.predictor_column(:,flg)=init_data.predictor(:,ni).*init_data.predictor(:,nj);
        end
    end
end

if init_data.order==3
    for ni=1:size(init_data.predictor,2)
        for nj=ni:ni
            flg=flg+1;
            init_data.predictor_column(:,flg)=init_data.predictor(:,ni).*init_data.predictor(:,nj);
            for nk=nj:nj
                flg=flg+1;
                init_data.predictor_column(:,flg)=init_data.predictor(:,ni).*init_data.predictor(:,nj).*init_data.predictor(:,nk);
            end
    end
   end
end

if init_data.order>3
    error('Please rerun the script with an order less than 3');
end
end

    

        
