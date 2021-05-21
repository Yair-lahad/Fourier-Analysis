function [EO,EC]=filterData(data,conditions,channel)
%this function receives a structure of edf files of all subjects, and returns only
%subjects with proper number who contains EO and EC files ending with .edf
%function returns 2 structs,'EO' data and 'EC' data of all subjects filtered by specific channel

EO=struct('data',{});
EC=struct('data',{});
subj=1;      %begin with first subject
fileAdded=0; %help us to know when to move to next subject
for file=1: length(data)
    name = data(file).name; % current subjects from Subjects folders
    %filter only files who have subject number, "EO" or "EC"
    if ~isempty(regexp(name,'\d*EO', 'once')) % filter EO
        % extract data from files using edfread function, only in wanted channel
        [~, EO_subj] = edfread([data(file).folder '\' name],'targetsignals',channel);
        % save relevant data in a struct, easier to use for analyze
        EO(subj).data=EO_subj;
        %update counter to know when to continue to next subject
        fileAdded=fileAdded+1;
    elseif ~isempty(regexp(name,'\d*EC', 'once'))
        % same conditions for EC
        [~, EC_subj] = edfread([data(file).folder '\' name],'targetsignals',channel);
        EC(subj).data=EC_subj;
        fileAdded=fileAdded+1;
    end
    if mod(fileAdded,conditions)==0
        subj=subj+1; % advance to next subject only if all conditions added for current subject
    end
end
end