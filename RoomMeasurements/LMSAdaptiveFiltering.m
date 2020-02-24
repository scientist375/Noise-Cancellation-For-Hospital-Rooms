% %Angad Daryani
% %ECE 4271 - Project 2: LMS Adaptive Filtering 
% %Spring 2020
% 
% %Part 1 - Generating the audio files with the noise signals
% %SECTION 1
% 
% %import classroom audio file - random file picked from the ZIP folder 
% firstAudioFile = '05x30y.wav';
% 
% %read the audio file into matlab workspace
% [x,Fs] = audioread(firstAudioFile);
% 
% %downsample the audio file go be 1/3rd 
% downSampledFile = resample(x,1,3);
% 
% %generating an excitation signal of white noise 
% whiteNoiseSignal = randn(1,1000000);
% %whiteNoiseSignal = ((0.1*whiteNoiseSignal.*(max(simSignal))./(max(downSampledFile2));
% 
% %ensuring that the values are between -1 and 1
% %whiteNoiseSignal = 0.1.*(whiteNoiseSignal)./(max(whiteNoiseSignal));
% 
% %convolving the white noise signal with the downsampled file
% simSignal = conv(whiteNoiseSignal, downSampledFile);
% 
% %limiting signal length
% simSignal = simSignal(1,1:1000000);
% 
% %Randomly downloaded noise signal - Using LILPUMP Gucci Gang for humor
% %purposes
% externalNoise = 'Lil Pump.mp3';
% 
% %read the audio file into Matlab workspace
% [x2,Fs2] = audioread (externalNoise);
% 
% %restricting size - for some reason the wav file has 2 columns
% noiseSignal = x2(1:5955312,1);
% %noiseSignal = ((0.1*noiseSignal).*(max(simSignal)))./(max(downSampledFile2));
% 
% %transposing the noiseSignal vector
% noiseSignal = noiseSignal.';
% 
% 
% %limiting the signal to 250000 samples
% noiseSignal = noiseSignal (1,1:1000000);
% 
% %ensuring that the values are between -1 and 1
% %noiseSignal = 0.1.* (noiseSignal)./ (max(noiseSignal));
% 
% %Second Audio file from the same room with different location 
% secondAudioFile = '60x25y.wav';
% 
% %read the audio file into matlab workspace
% [x3,Fs3] = audioread(secondAudioFile);
% 
% %downsample the audio file go be 1/3rd 
% downSampledFile2 = resample(x3,1,3);
% 
% %Second Simulated Signal - convolved with downloaded noise signal
% simSignal2 = conv(noiseSignal, downSampledFile2);
% 
% %maintaining constant vector sizes
% simSignal2 = simSignal2(1,1:1000000);
% 
% %Sum of noise and generated excited noise signal multipled by 0.1 to make
% %sure it's around 10% of the original excitation signals
% %totalNoiseSig = simSignal;
% totalNoiseSig = 0.3*((simSignal2 + simSignal).*(max(simSignal)))./(max(downSampledFile2));
% 
% %setting w0
% w0 = zeros(64000,1);
% 
% %inputs to LMS filter 
% xval = whiteNoiseSignal';
% dval = totalNoiseSig';
% 
% %calling myLMS filter
% [dhat, e, w] = mylms(xval, dval, w0);
% 
% %writing the MSE 
% mse = ((norm(downSampledFile - w))^2)/((norm(downSampledFile))^2);
% 
% %first 400 MSE
% mse400 = ((norm(downSampledFile(1:400) - w(1:400)))^2)/((norm(downSampledFile(1:400)))^2);
% 
% %tail end of the MSE 
% msetail = ((norm(downSampledFile(42667:end) - w(42667:end)))^2)/((norm(downSampledFile(42667:end)))^2);
% 
% %Calculating SNR
% SNR = 20*log10(1/0.3) %keep changing this based on noise level
% 
% %plotting results 
% subplot (2,1,1)
% plot(w)
% ylabel('w')
% xlabel ('Samples [n]')
% subplot(2,1,2)
% plot(e)
% ylabel('e')
% xlabel('Samples[n]')
%----------------------------------ATTEMPT 2------------------------------

%Angad Daryani
%ECE 4271 - Project 2: LMS Adaptive Filtering 
%Spring 2020

%ATTEMPT 2: REORGANISING THE CODE
%Part 1 - Generating the audio files with the noise signals
%SECTION 1

% Using audioread to import the audio WAV and MP3 file 

%first audio signal
[firstAudioFile, fs1] = audioread('05x30y.wav');

%second audio signal
[secondAudioFile, fs2] = audioread('60x25y.wav');

%external noise
[gucciGang, fs3] = audioread('Lil Pump.mp3');

%setting common sample size outside, to make it easier to implement/test
sampleSize = 1000000;

%resizing the song to make the sample size consistent
gucciGang = gucciGang(1:sampleSize,1);

%generating random white noise of the same sample size
whiteNoise = randn(sampleSize,1);

% downsampling the input audio signals to 32kHz
% using rational approximation to clean out the ratio for computation
[num, den] = rat(fs3/32000);

%resampling all the audio files to 32kHz
firstAudioFile = resample(firstAudioFile,1,3);
secondAudioFile = resample(secondAudioFile,1,3);
gucciGang = resample(gucciGang,num,den);

% Making the noisy signals using convolution of the audiofiles with the
% whiteNoise and externalNoise signal

%using common variable for carrying out experimental changes for the report
noise_ratio = 0;

%first signal with room audio and random white noise 
simSignal = conv(firstAudioFile,whiteNoise);

%second signal with room audio and external noise source -- song in this
%case
simSignal2 = conv(secondAudioFile,gucciGang);

%normalising the noise to be 'X' percent of the total signal
simSignal2 = noise_ratio .* simSignal2(1:length(simSignal)) .* max(simSignal) ./ max(simSignal2);

%overall audio signal - added up
overallAudio = (simSignal + simSignal2);

% performing stochastic gradient descent using nLMS to get difference
% between the actual signal and desired signal 

%calling the myLMS filter function with inputs of X,D,w0
[dhat1,e1,w1] = mylms(whiteNoise,overallAudio(1:length(whiteNoise)),zeros(64000,1));

%plotting the results 
subplot(2,1,1)
plot(e1)
title('Error')
xlabel('Number of samples [n]')
ylabel('Error Squared')

subplot(2,1,2)
plot(w1)
title('Learned RIR')
xlabel('Number of samples [n]')
ylabel('Impulse Response')

% calculate MSE results
tailEnd = round(length(w1)*2/3);

%Signal to Noise Ratio
SNR = 20*log10(1/noise_ratio)

%Normalised Mean Squared Error
NormMSE = (norm(firstAudioFile-w1)^2)./(norm(firstAudioFile)^2)

%Normalised Mean Squared Error with first 400 samples 
NormMSE400 = (norm(firstAudioFile(1:400)-w1(1:400))^2)./(norm(firstAudioFile(1:400))^2)

NormMSEtail = (norm(firstAudioFile(tailEnd:end)-w1(tailEnd:end))^2)./(norm(firstAudioFile(tailEnd:end))^2)
