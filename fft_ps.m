function fft_ps(f1,f2,EO,EC,fs,freqband,subj)
%% Setting variables
L = length(EO(subj).data);
freq = (0:(L-1))*fs/L; % frequency vector
band_idx = find(freq >= freqband(1) & freq<= freqband(2)); % choose only part of frequencies

%% Calculations 
%fft for EO
specVec = fft(EO(subj).data)/L;
fft_ps_EO = (abs(specVec).^2);
fft_ps_EO = fft_ps_EO(1:floor(L/2))*L/fs;
%fft for EC
specVec = fft(EC(subj).data)/L;
fft_ps_EC = (abs(specVec).^2);
fft_ps_EC = fft_ps_EC(1:floor(L/2))*L/fs;

%Extracting Difference spectrum
fft_Diff_ps = fft_ps_EC - fft_ps_EO;  % Diffrence between EC to EO
fft_Diff_ps = fft_Diff_ps(band_idx);  % Diffrence only in the wanted freq (6-14 Hz)
[~,IAF_index] = max(fft_Diff_ps);
f_band = freq(band_idx); % frequency vector 
IAF = f_band(IAF_index); % the value of max IAF

%% Plotting
figure(f1);
subplot 312
plot(f_band,fft_ps_EO(band_idx),'b',f_band,fft_ps_EC(band_idx),'r'); hold on
title('Power Spectrum- FFT')
figure(f2);
subplot 312
plot(f_band,fft_Diff_ps); hold on
xline(IAF,'r--','linewidth',2)
title(['Difference Power Spectrum- FFT, IAF= ',num2str(round(IAF,2)),' Hz']);
end