aPR=audioPlayerRecorder('SampleRate',16000);
x=randn(320000,1)/3;
x=min(max(x,-1),1)*0.95;

y=zeros(size(x));

for k = 1:16000:length(x),
    [audioRecorded,nUnderruns,nOverruns]=aPR(x(k:k+15999));

    y(k:k+15999) = audioRecorded;
    if nUnderruns > 0
        fprintf('Audio player queue was underrun by %d samples.\n',nUnderruns);
    end
    if nOverruns > 0
        fprintf('Audio recorder queue was overrun by %d samples.\n',nOverruns);
    end
end

release(aPR)

