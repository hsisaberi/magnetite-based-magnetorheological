clc;
clear;
close all;

% meanerror=100;
% apple=10;
R=0.1;
RMSE=200;
% R<0.9 && 
% while R<1.5

        load mydata0out.mat
        
        Data_Inputs=AllData(:,1:end-1)';
        
        Data_Targets=AllData(:,end)';

        inputs=Data_Inputs;
        targets=Data_Targets;

        % Create a Fitting Network
        hiddenLayerSize = 5;
        TF={'tansig','purelin'};
        net = newff(inputs,targets,hiddenLayerSize,TF);

        
        % Choose Input and Output Pre/Post-Processing Functions
        % For a list of all processing functions type: help nnprocess
        net.input.processFcns = {'removeconstantrows','mapminmax'};
        net.output.processFcns = {'removeconstantrows','mapminmax'};

        % Setup Division of Data for Training, Validation, Testing
        % For a list of all data division functions type: help nndivide
        net.divideFcn = 'dividerand';  % Divide data randomly
        net.divideMode = 'sample';  % Divide up every sample
        net.divideParam.trainRatio = 50/100;
        net.divideParam.valRatio = 25/100;
        net.divideParam.testRatio = 25/100;

        % Choose a Training Function
        % For a list of all training functions type: help nntrain
        % 'trainlm' is usually fastest.
        % 'trainbr' takes longer but may be better for challenging problems.
        % 'trainscg' uses less memory. Suitable in low memory situations.
        net.trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

        % Choose a Performance Function
        % For a list of all performance functions type: help nnperformance
        net.performFcn = 'mse';  % Mean Squared Error %mae ,sse ,mse

        % Choose Plot Functions
        % For a list of all plot functions type: help nnplot
        net.plotFcns = {'plotperform','ploterrhist','plotregression', 'plotfit'};

        net.trainParam.showWindow=false;
        net.trainParam.showCommandLine=false;
        net.trainParam.show=100;
        net.trainParam.epochs=1000;
        net.trainParam.goal=1e-8;
        net.trainParam.max_fail=100;

        % Train the Network
        [net,tr] = train(net,inputs,targets);
        
        % Test the Network
        outputs = net(inputs);
        errors = gsubtract(targets,outputs);
        performance = perform(net,targets,outputs);

        % Recalculate Training, Validation and Test Performance
        trainInd=tr.trainInd;
        trainInputs = inputs(:,trainInd);
        trainTargets = targets(:,trainInd);
        trainOutputs = outputs(:,trainInd);
        trainErrors = trainTargets - trainOutputs;
        trainPerformance = perform(net,trainTargets,trainOutputs);

        valInd=tr.valInd;
        valInputs = inputs(:,valInd);
        valTargets = targets(:,valInd);
        valOutputs = outputs(:,valInd);
        valErrors = valTargets-valOutputs;
        valPerformance = perform(net,valTargets,valOutputs);

        testInd=tr.testInd;
        testInputs = inputs(:,testInd);
        testTargets = targets(:,testInd);
        testOutputs = outputs(:,testInd);
        testError = testTargets-testOutputs;
        meanerror= mse(testError);
        testPerformance = perform(net,testTargets,testOutputs);

        %PlotResults(targets,outputs,'All Data');
        %PlotResults(trainTargets,trainOutputs,'Train Data');
        %PlotResults(valTargets,valOutputs,'Validation Data');
        %PlotResults(testTargets,testOutputs,'Test Data');

        % View the Network
        % view(net);

        % Plots
        % Uncomment these lines to enable various plots.

        % figure;
        % plotperform(tr);

        % figure;
        % plottrainstate(tr);

        % figure
        % plotfit(net,inputs,targets)

        % figure;
        % plotregression(trainTargets,trainOutputs,'Train Data',...
        %     valTargets,valOutputs,'Validation Data',...
        %     testTargets,testOutputs,'Test Data',...
        %     targets,outputs,'All Data');

        % figure;
        % ploterrhist(errors);
        apple=std(errors);
        sam=[sam31
             sam40];
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

%         if RHossein>0.95 && RJack>0.95  %&&  MSEHossein<1.2 && MSEJack<1.2
%             break;
%     %     elseif RHossein>0.93 && RJack>0.97 &&  MSEHossein<1.2 && MSEJack<1.2
%     %         break;
%     %     elseif RHossein>0.97 && RJack>0.93 &&  MSEHossein<1.2 && MSEJack<1.2
%     %         break;
%         end
% end

PlotResults(JackTargets,JackOutputs,'Jack TEST Data');
PlotResults(HosseinTargets,HosseinOutputs,'Hossein TEST Data');

figure;
plotregression(HosseinTargets,HosseinOutputs,'Test Data');
set(gcf,'Toolbar','figure');

figure;
plotregression(JackTargets,JackOutputs,'Test Data');
set(gcf,'Toolbar','figure');

% 
%     JackInputs=sam33(:,1:end-1)';
%     JackTargets=sam33(:,end)';
% %     JackTargets=(JackTargets-min(JackTargets))./(max(JackTargets)-min(JackTargets));
% 
% 
%     JackOutputs=net(JackInputs);
% %     JackOutputs=(JackOutputs-min(JackOutputs))./(max(JackOutputs)-min(JackOutputs));
%     JackOutputs=(JackOutputs-min(JackOutputs))/(max(JackOutputs)-min(JackOutputs));
%     JackOutputs=min(JackTargets)+(max(JackTargets)-min(JackTargets))*JackOutputs;
%     
%     R=corr(JackTargets',JackOutputs')  
%     e=JackTargets-JackOutputs;
%     MSE=mean(e.^2)
%     RMSE=sqrt(MSE)
% 
%     PlotResults(JackTargets,JackOutputs,'My TEST Data');

