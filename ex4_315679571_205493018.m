clear;
clc;
%% Exercise 4- Identifying individual alpha frequency

% Gali Winterberger      - id 315679571
% Yair Lahad             - id 205493018

%% Setting variables
channel=19;
data=dir('..\DATA_DIR\**\*.edf'); %get the files ending with ".edf" in folders who contains subjects
conditions=2; % EO and EC per subject
nSubjects = length(data)/conditions;
[EO,EC]=filterData(data,conditions,channel); % using a function to filter our data
freqband = [6,14]; % choosing which frequency to analyze
jump=0.1;        
f = freqband(1):jump:freqband(2); % frequency vector
fs = 256;        % sample rate
window = 5*fs;   % repesnts seconds of window (secs * number of samples per sec)
noverlap = [];   
overlap=2.5*fs;  % resprents the overlap between windows
%% Power spectrum (PS) methods and Individual Alpha Frequency (IAF)
for subj=1:nSubjects
    f1 = figure('name',['Subject number- ' num2str(subj) ' Power Spectrum'],'NumberTitle','off' ); % Power Spectrums figure
    set(f1,'color','w');
    f2 = figure('name',['Subject number- ' num2str(subj) ' Diffrence Power Spectrum'],'NumberTitle','off'); % Difference Power Spectrums and IAF figure
    set(f2,'color','w');
    % pwelch
    pwelch_ps(f1,f2,EO,EC,window,noverlap,f,fs,subj);
    % FFT
    fft_ps(f1,f2,EO,EC,fs,freqband,subj);
    % DFT
    dft_analyzed(f1,f2,EO,EC,fs,f,window,overlap,subj)
end

