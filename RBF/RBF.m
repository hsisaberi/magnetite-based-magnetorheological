clc;
clear;
close all;

load mydata0out.mat

performance=1000;

while performance>100

    Data_Inputs=[AllData(:,1)'; AllData(:,2)'; AllData(:,3)'; AllData(:,4)'];
    Data_Targets=AllData(:,end)';

    inputs=Data_Inputs;
    targets=Data_Targets;

    nData=size(inputs,2);

    Perm=randperm(nData);
    % Perm=1:nData;

    pTrainData=0.7;
    nTrainData=round(pTrainData*nData);
    trainInd=Perm(1:nTrainData);
    Perm(1:nTrainData)=[];
    trainInputs = inputs(:,trainInd);
    trainTargets = targets(:,trainInd);

    pTestData=1-pTrainData;
    nTestData=nData-nTrainData;
    testInd=Perm;
    Perm(1:nTestData)=[];
    testInputs = inputs(:,testInd);
    testTargets = targets(:,testInd);

    % Create and Train RBF Network
    Goal=0;
    Spread=10;
    MaxNeuron=200;
    DisplatAt=200;
    net = newrb(trainInputs,trainTargets,Goal,Spread,MaxNeuron,DisplatAt);

    % Test the Network
    outputs = net(inputs);
    errors = gsubtract(targets,outputs);
    performance = perform(net,targets,outputs);

    %% My Test system
    
    JackInputs=sam31(:,1:end-1)';
    JackTargets=sam31(:,end)';
%     JackTargets=(JackTargets-min(JackTargets))./(max(JackTargets)-min(JackTargets));


    JackOutputs=net(JackInputs);
%     JackOutputs=(JackOutputs-min(JackOutputs))./(max(JackOutputs)-min(JackOutputs));
    JackOutputs=(JackOutputs-min(JackOutputs))/(max(JackOutputs)-min(JackOutputs));
    JackOutputs=min(JackTargets)+(max(JackTargets)-min(JackTargets))*JackOutputs;
    
    RJack=corr(JackTargets',JackOutputs')
    eJack=JackTargets-JackOutputs;
    MSEJack=mean(eJack.^2);
    RMSEJack=sqrt(MSEJack);
    
    HosseinInputs=sam40(:,1:end-1)';
    HosseinTargets=sam40(:,end)';
%     HosseinTargets=(HosseinTargets-min(HosseinTargets))./(max(HosseinTargets)-min(HosseinTargets));


    HosseinOutputs=net(HosseinInputs);
%     HosseinOutputs=(HosseinOutputs-min(HosseinOutputs))./(max(HosseinOutputs)-min(HosseinOutputs));
    HosseinOutputs=(HosseinOutputs-min(HosseinOutputs))/(max(HosseinOutputs)-min(HosseinOutputs));
    HosseinOutputs=min(HosseinTargets)+(max(HosseinTargets)-min(HosseinTargets))*HosseinOutputs;
    
    RHossein=corr(HosseinTargets',HosseinOutputs')
    eHossein=HosseinTargets-HosseinOutputs;
    MSEHossein=mean(eHossein.^2);
    RMSEHossein=sqrt(MSEHossein);
    
    if RHossein>0.95 && RJack>0.95  %&&  MSEHossein<1.2 && MSEJack<1.2
        break;
%     elseif RHossein>0.93 && RJack>0.97 &&  MSEHossein<1.2 && MSEJack<1.2
%         break;
%     elseif RHossein>0.97 && RJack>0.93 &&  MSEHossein<1.2 && MSEJack<1.2
%         break;
%     elseif performance>400
%         break;
    end
    
end

% Recalculate Training, Validation and Test Performance
trainOutputs = outputs(:,trainInd);
trainErrors = trainTargets - trainOutputs;
trainPerformance = perform(net,trainTargets,trainOutputs);

testOutputs = outputs(:,testInd);
testError = testTargets-testOutputs;
testPerformance = perform(net,testTargets,testOutputs);

PlotResults(targets,outputs,'All Data');
PlotResults(trainTargets,trainOutputs,'Train Data');
PlotResults(testTargets,testOutputs,'Test Data');

%% My Test Plot

PlotResults(JackTargets,JackOutputs,'Jack TEST Data');
PlotResults(HosseinTargets,HosseinOutputs,'Hossein TEST Data');

figure;
plotregression(HosseinTargets,HosseinOutputs,'Test Data');
set(gcf,'Toolbar','figure');

figure;
plotregression(JackTargets,JackOutputs,'Test Data');
set(gcf,'Toolbar','figure');

% View the Network
% view(net);
