function pwelch_ps (f1,f2,EO,EC,window,noverlap,f,fs,subj)
%% Calculations
%Calculating Pwelch for both conditions using pwelch function
pwelch_ps_EO = pwelch(EO(subj).data, window, noverlap, f, fs);
pwelch_ps_EC = pwelch(EC(subj).data, window, noverlap, f, fs);
% Extracting IAF
pwelch_Diff_ps = pwelch_ps_EC - pwelch_ps_EO; % calculate diffrence between EC to EO
[~,IAF_index] = max(pwelch_Diff_ps);
IAF = f(IAF_index); % the value of max IAF

%% Plotting
figure(f1);
sgtitle(char("Subject " + subj + " Power Spectrums"));
subplot 311
plot(f,pwelch_ps_EO,'b',f,pwelch_ps_EC,'r'); hold on
title('Power Spectrum- Pwelch')
figure(f2);
sgtitle(char("Subject " + subj + " Difference Power Spectrums"));
subplot 311
plot(f,pwelch_Diff_ps); hold on
xline(IAF,'r--','linewidth',3)
title(['Difference Power Spectrum- Pwelch, IAF= ',num2str(round(IAF,2)),' Hz'])
end