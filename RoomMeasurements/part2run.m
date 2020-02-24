%executing part 2 in the most efficient manner - running all the audio
%files together and waiting for them to run one at a time

%woodfloor audio files
part2('woodfloor_medium','quiet',2,3,1);
part2('woodfloor_medium','music0',2,3,2);
part2('woodfloor_medium','music1',2,3,3);
part2('woodfloor_medium','music2',2,3,4);
part2('woodfloor_medium','music3',2,3,5);

figure
%tileroom audio files 
part2('tileroom','quiet',2,3,1);
part2('tileroom','music0',2,3,2);
part2('tileroom','music1',2,3,3);
part2('tileroom','music2',2,3,4);

figure 
%carpetroom files
part2('carpetroom','quiet',2,3,1);
part2('carpetroom','music0',2,3,2);
part2('carpetroom','music1',2,3,3);
part2('carpetroom','music2',2,3,4);
part2('carpetroom','music3',2,3,5);