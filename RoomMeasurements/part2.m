%Part 2 - Using room data downloaded from canvas
% For this part, we delay the input signal to the LMS filter to account for
% the delay between the speaker and the microphone - this is due to
% transmission delays as well as processing delays 

%From visual observation of the the data array, we can see that the values
%from 1 to 17000 ~ 17250 are very close to 0 in value with an exponent of
%-4 to -6. 

%in order to account for this delay, I ran the lms function with delayed
%inputs. 

%since there are a large number of files, 
function part2(room,name,row,col,loc)

%loading the entire folder in order to be able to automatically access all
%audio files 
    load(['C:\Users\Angad\Documents\ECE 4271\Project2\RoomMeasurements\',room,'_',name,'.mat'])
    
    %calling the Normalised LMS function with delayed input. I ball parked
    %the delay value to 17230
    
    [dhat1,e1,w1] = mylms(x(1:end-17230),y(17230:end),zeros(10000,1));
    
    subplot(row,col,loc)
    plot(w1)
    title([name,' Learned RIR'])
    xlabel('Number of samples')
    ylabel('Impulse Response')
end