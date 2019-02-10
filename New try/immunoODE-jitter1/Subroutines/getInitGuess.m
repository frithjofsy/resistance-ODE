function [initGuess,lb,ub] = getInitGuess(patientCollection)

numParams = 2 + numel(patientCollection); %2 global paramters and 1 patient specific parameter
lb =  0*ones(numParams,1);
ub =  20*ones(numParams,1);
% numParams = 2 + numel(patientCollection)*5; %there are 2 global and 5 patient specific parameters
% lb =  0*ones(numParams,1); % lower bound for optimization, relative to the initial guess
% ub =  20*ones(numParams,1); % lower bound for optimization, relative to the initial guess

%% STEP 1: set parameters

% set the initial guesses of parameters based on Kuznetsov et al. Due to
% the non-dimensiolization procedure, we have to scale some parameters with
% plausible guesses of initial tumor cell numbers and initial lymphocyte
% numbers, respectively. We assume 1E7 tumor cells and 1E6 lymphocytes.
% initGuess = nan(numParams,1);
% initGuess(1) = 0.18; %alpha
% initGuess(2) = 0.0412; %delta
% %fill in patient specific parameters for the first patient
% initGuess(3) = 2*1e-9*10^7; %b*T0
% initGuess(4) = 1.101*1e-7*10^6; %n*E0
% initGuess(5) = 0.1245; %p
% initGuess(6) = 2.019*10^7/10^7; %g/T0
% initGuess(7) = 3.422*1e-10*10^7; %m*T0

initGuess = nan(numParams,1);
initGuess(1)=-0.062;             %this is b, death rate of sensitive cells
initGuess(2)=0.038;              %this is d, fixed net growth rate of resistant
                                 %cells during treatment
%patient specific parameter                                 
initGuess(3)=8.8/(8.8+417.2);    %this is f=c/(c+a) fraction of resistant cells, c is volume of resistant cells day 0, a is the volume of sensitive cells on day 0 


%% STEP 2: if >1 patient -> repeat parameters
if numel(patientCollection)>1
    initGuess(4:end) = repmat(initGuess(3),numel(patientCollection)-1,1); %filling the same for other patients
end

%% STEP 4 (optional): rescale initial guesses to match extreme growth rates
% betaIndex = 3; % index to beta of first patients
% fIndex = 1 % only first parameter changes, probably we do not need this part: 
% for i = 1:numel(patientCollection)
%     
%     %get the maximal relative change for the given patient
%     M = max(patientCollection{i}(:,2)/100+1);
%     shift = (i-1)*5;
%     % scale beta
%     initGuess(betaIndex+shift) = initGuess(betaIndex + shift) / (2*M);
% end

end