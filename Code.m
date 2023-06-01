% Load audio signal
[x, Fs] = audioread("sound.wav");
% Add noise to audio signal 
SNR = 10; % desired SNR in dB
noise = randn(length(x),1);
noise_power = norm(x)/10^(SNR/20);
noise = noise * noise_power;
x_noisy = x + noise;
% Compute DFT of audio signal and noisy audio signal
X = zeros(length(x),1);
X_noisy = zeros(length(x),1);
for k = 1:length(x)
for n = 1:length(x)
X(k) = X(k) + x(n)*exp(-1i*2*pi*(k-1)*(n-1)/length(x));
X_noisy(k) = X_noisy(k) + x_noisy(n)*exp(-1i*2*pi*(k-1)*(n-1)/length(x));
end
end
% Define low-pass filter to remove high-frequency noise
fc = 5000; % cutoff frequency in Hz
M = length(x);
n = 0:M-1;%vectors containing the index values of audio 
h = 2*fc/Fs*sinc(2*fc/Fs*(n-M/2)); % impulse response of low pass filter
% Apply low-pass filter to DFT of noisy audio signal
X_filtered = X_noisy .* fftshift(h');
% Plot original signal and noise
t = (0:length(x)-1)/Fs;
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Signal');
subplot(2,1,2);
plot(t, noise);
xlabel('Time (s)');
ylabel('Amplitude');
title('Noise');
% Print DFT matrix
X_matrix = zeros(length(x), length(x));
for k = 1:length(x)
for n = 1:length(x)
X_matrix(k, n) = exp(-1i*2*pi*(k-1)*(n-1)/length(x));
end
end
disp(X_matrix);