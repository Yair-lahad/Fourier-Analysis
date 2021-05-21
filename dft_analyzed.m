function dft_analyzed(f1,f2,EO,EC,fs,f,window,overlap,subj)
%% Setting variables
curr_EO = (EO(subj).data);
curr_EC = (EC(subj).data);
freq=0:fs/window:fs/2;                              % frequency vector
band_idx=(freq>=f(1) & freq<=f(end)); 
freq=freq(band_idx);                                % choose only part of frequencies
k = 0:window-1;                                     % cols for matrix
n = 0:window-1;                                     % rows for matrix
W = exp(-2.*pi.*1i.*n'*k/window);                   %creates complex matrix
EOmat = buffer(curr_EO,window,overlap,'nodelay');   %creates all windows matrix
ECmat = buffer(curr_EC,window,overlap,'nodelay');   %creates all windows matrix

%% Calculations
%EO dft
DFT_ps_EO = W*EOmat/window;
DFT_ps_EO = (abs(DFT_ps_EO).^2);
DFT_ps_EO = mean(DFT_ps_EO,2)*window/fs;
%EC dft
DFT_ps_EC = W*ECmat/window;
DFT_ps_EC = (abs(DFT_ps_EC).^2);
DFT_ps_EC = mean(DFT_ps_EC,2)*window/fs;

% Extracting IAF
DFT_ps_Diff = DFT_ps_EC - DFT_ps_EO; % Diffrence between EC to EO
DFT_ps_Diff = DFT_ps_Diff(band_idx); % Diffrence only in the wanted freq (6-14 Hz)
[~,IAF_index] = max(DFT_ps_Diff);
IAF = freq(IAF_index);               % the value of max IAF

%% Plotting
figure(f1);
subplot 313;
plot(freq,DFT_ps_EO(band_idx),'b',freq,DFT_ps_EC(band_idx),'r'); hold on
title('Power Spectrum- DFT')
legend('EO','EC');
figure(f2);
subplot 313;
plot(freq,DFT_ps_Diff); hold on
xline(IAF,'r--','linewidth',3);
title(['Difference Power Spectrum- DFT, IAF= ',num2str(round(IAF,2)),' Hz']);
xlabel('Frequency [Hz]');
legend('Diffrence','IAF');
end