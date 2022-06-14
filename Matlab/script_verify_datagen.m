close all; clear *;

% Whether data shall be written to file or not
writeDataToFile = 1;

% use 2^6-1 or 2^24-1 as maximum sequence length
use_six = true;

% Create PN-sequence object with maximum-length sequence
lfsr = comm.PNSequence;
if use_six == true
    lfsr.Polynomial = [6 1 0];
    lfsr.InitialConditions = [1 1 0 0 0 0];
else
    lfsr.Polynomial = [24 1 0];
    ic = zeros(1,24,'uint32');
    ic(1) = 1;
    ic(2) = 1;
    lfsr.InitialConditions = ic;
end

% if you use the second lfsr you should produce ~20000 samples per frame to
% get the desired autocorrelation
lfsr.SamplesPerFrame = 500;

disp(['Initial state of LFSR: ' num2str(bin2dec(num2str(lfsr.InitialConditions)))]);

% Create pseudo-random bit sequence
bits = lfsr();

% Bit-to-symbol mapping with w_out as symbol wordlength
w_out = 8;
symbols = []; % Requires your input
for i = 1:lfsr.SamplesPerFrame
   if bits(i) == 1
      symbols(i) = -1; 
   else
      symbols(i) = 1;
   end
end

% Save output data to file to compare to VHDL-model (integer representation)
if writeDataToFile == 1
 save_variable(symbols, '%d', '../sim/datagen/log/datagen_result_ref.dat');
end

% Plot bit sequence
figure(1);
subplot(211);
stem(bits(1:10)); box off;
yticks([0 1]);
xlabel('Symbol index n \rightarrow'); ylabel('Bit \rightarrow');

% Autocorrelation
autocorr = dsp.Autocorrelator;
autocorr.MaximumLagSource = 'Property';
autocorr.MaximumLag = 50;
autocorr.Scaling = 'Biased';

% Calculate autocorrelation up to some lag
exx = autocorr(symbols'); % Requires your input

subplot(212);
stem(exx); box off; % Requires your input
xlabel('Lag i \rightarrow'); ylabel('E{x[n]x^*[n-i]} \rightarrow');