clear all
clc
% read in file
fid = fopen('Inp1.inp');
C = textscan(fid,'%s','Delimiter',' \n,',...
'TreatAsEmpty',{'NA','na'},'MultipleDelimsAsOne',1,'CommentStyle','#');
sizeofdata = size(C{1});
sizeofdata = sizeofdata(1);
% go through cell array
for i = 1:sizeofdata
    str = C{1}(i);
    temp = str2double(str);
    if isnan(temp)
        % its a command
        if strcmpi(str,'Coor')
            %its a coor
        end
        %sprintf('string :%s',str)
    else
        % its a number
        %sprintf('number :%d',temp);
    end
end
fclose(fid);
% read in header
%line = fgetl(fid);
%line = fgetl(fid);

%strcmpi(line,'feap.')
%strfind(line,'Hill')


% cline = '';
%   while strcmp(line,'end') == 0
%       for i = 1:length(line);
%           if line(i)=='#'
%               break
%           end
%           cline(i) = line(i);
%       end
%     cline;
%     line = fgetl(fid);
%     cline = line;
%   end
%fclose(fid);


%  fileID = fopen('Inp1.inp');
%  n=fscanf(fileID,'%s')
%  C= textscan(fileID,'%s','CommentStyle','#');%,'Delimiter','\n','MultipleDelimsAsOne'
%  fclose(fileID);
%  strfind(n,'Coor')
% celldisp(C);
% 
% dim = str2double(C{1}{1});
% 
% textscan(C,'%s','Delimiter','');

% Read in Nodal Coordinates
%find(C=='Coor')

%C = textscan(fileID,'%s %n %n %n %n','Delimiter',' ',...
%'TreatAsEmpty',{'NA','na'},'CommentStyle','#');
% xl= [ 0  0; 48 44; 48 60; 0 44;24 22; 48 52; 24 52; 0 22 ; 24 37]';
% ix = [1 2 3 4];
% addpath(genpath('Plot'));
% figure1 = figure('Name','Mesh');
% PlotElement( xl,ix,figure1 )
%nodes( xl,figure1 );