clc;
clear;
close all;

%% Create Time-Series Data

load mydata0out.mat

Inputs=AllData(:,1:end-1);
Targets=AllData(:,end);

nData=numel(Targets);
Perm=randperm(nData);
% Perm=1:nData;

pTrain=0.7;
nTrainData=round(pTrain*nData);
TrainInputs=Inputs(Perm(1:nTrainData),:);
TrainTargets=Targets(Perm(1:nTrainData),:);
Perm(1:nTrainData)=[];
TrainData=[TrainInputs TrainTargets];

pTest=1-pTrain;
nTestData=nData-nTrainData;
TestInputs=Inputs(Perm,:);
TestTargets=Targets(Perm,:);
TestData=[TestInputs TestTargets];

%% Design ANFIS

% Option{3}='FCM (genfis3)';

nCluster=3;
Exponent=2;
MaxIt=1000;
MinImprovment=1e-5;
DisplayInfo=1;
FCMOptions=[Exponent MaxIt MinImprovment DisplayInfo];

fis=genfis3(TrainInputs,TrainTargets,'sugeno',nCluster,FCMOptions);

MaxEpoch=1000;
ErrorGoal=0;
InitialStepSize=0.01;
StepSizeDecreaseRate=0.9;
StepSizeIncreaseRate=1.1;
TrainOptions=[MaxEpoch ...
              ErrorGoal ...
              InitialStepSize ...
              StepSizeDecreaseRate ...
              StepSizeIncreaseRate];

DisplayInfo=true;
DisplayError=true;
DisplayStepSize=true;
DisplayFinalResult=true;
DisplayOptions=[DisplayInfo ...
                DisplayError ...
                DisplayStepSize ...
                DisplayFinalResult];

OptimizationMethod=1;
% 0: Backpropagation
% 1: Hybrid
            
fis=anfis([TrainInputs TrainTargets],fis,TrainOptions,DisplayOptions,[],OptimizationMethod);


%% Apply ANFIS to Train Data

% TrainOutputs=evalfis(TrainInputs,fis);
% 
% TrainErrors=TrainTargets-TrainOutputs;
% TrainMSE=mean(TrainErrors(:).^2);
% TrainRMSE=sqrt(TrainMSE);
% TrainErrorMean=mean(TrainErrors);
% TrainErrorSTD=std(TrainErrors);
% 
% figure;
% PlotResults(TrainTargets,TrainOutputs,'Train Data');
% 
% figure;
% plotregression(TrainTargets,TrainOutputs,'Train Data');
% set(gcf,'Toolbar','figure');

%% Apply ANFIS to Test Data

% TestOutputs=evalfis(TestInputs,fis);
% 
% TestErrors=TestTargets-TestOutputs;
% TestMSE=mean(TestErrors(:).^2);
% TestRMSE=sqrt(TestMSE);
% TestErrorMean=mean(TestErrors);
% TestErrorSTD=std(TestErrors);
% 
% figure;
% PlotResults(TestTargets,TestOutputs,'Test Data');
% 
% figure;
% plotregression(TestTargets,TestOutputs,'Test Data');
% set(gcf,'Toolbar','figure');

    
%% My Test

    MYInputs=AllData(:,1:end-1);
    MYTargets=AllData(:,end);
    MYOutputs=evalfis(MYInputs,fis);

% 
%     R=corr(JackTargets',JackOutputs')  
%     e=JackTargets-JackOutputs;
%     MSE=mean(e.^2)
%     RMSE=sqrt(MSE)
    
    figure;
    PlotResults(MYTargets,MYOutputs,'Test Data');

    figure;
    plotregression(MYTargets,MYOutputs,'Test Data');
    set(gcf,'Toolbar','figure');

%% Jack Test

JackInputs=sam31(:,1:end-1);
JackTargets=sam31(:,end);

JackOutputs=evalfis(JackInputs,fis);
JackOutputs=(JackOutputs-min(JackOutputs))/(max(JackOutputs)-min(JackOutputs));
JackOutputs=min(JackTargets)+(max(JackTargets)-min(JackTargets))*JackOutputs;

figure;
PlotResults(JackTargets,JackOutputs,'Test Data');

figure;
plotregression(JackTargets,JackOutputs,'Test Data');
set(gcf,'Toolbar','figure');



%% Hossein Test

HosseinInputs=sam31(:,1:end-1);
HosseinTargets=sam31(:,end);

HosseinOutputs=evalfis(HosseinInputs,fis);
HosseinOutputs=(HosseinOutputs-min(HosseinOutputs))/(max(HosseinOutputs)-min(HosseinOutputs));
HosseinOutputs=min(HosseinTargets)+(max(HosseinTargets)-min(HosseinTargets))*HosseinOutputs;

figure;
PlotResults(HosseinTargets,HosseinOutputs,'Test Data');

figure;
plotregression(HosseinTargets,HosseinOutputs,'Test Data');
set(gcf,'Toolbar','figure');
