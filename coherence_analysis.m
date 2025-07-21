clear; close all;

% Folder path
folderPath = 'F:\sub1';
inputFile = fullfile(folderPath, 'sub1');
outputFile = fullfile(folderPath, 'coherence_acc-eeg.xlsx');

% Load data
B = readmatrix(inputFile);

% EEG channel labels (matching data columns)
EEG_labels = {'P3','CP3','C1','C3','Cz','C5','FC3','C4','CP4','FC4','Pz','C2','C6','P4'};
nEEG = numel(EEG_labels);

% Preallocate coherence matrix
allCxy = [];
F1 = [];

figure;
for ch = 1:nEEG
    x = B(:,2);        % Acceleration signal
    y = B(:,ch+2);     % EEG channel
    [Cxy,F] = mscohere(x, y, hamming(2000), 1000, 1000, 500);

    if ch == 1
        F1 = round(F,4); % Save frequency vector once
        allCxy = zeros(numel(F1), nEEG);
    end
    allCxy(:,ch) = round(Cxy,4);

    % Plot coherence
    subplot(4,4,ch);
    plot(F1, allCxy(:,ch));
    title(EEG_labels{ch}, 'Interpreter', 'none');
    xlabel('Freq [Hz]'); ylabel('Coherence');
    xlim([0 10]);
    grid on
end
sgtitle('Coherence between ACC and each EEG channel');

% Prepare output (Frequency + coherence for all channels)
outputCell = [ {'Frequency_Hz'}, strcat('Coherence_', EEG_labels) ; ...
               num2cell(F1),     num2cell(allCxy) ];

writecell(outputCell, outputFile);

disp(['Processing complete. Results saved to: ', outputFile]);
