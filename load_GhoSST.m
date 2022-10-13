function [data_GhoSST] = load_GhoSST(fnameList,name_header,varargin)
% [optcteH2Oice_GhoSSTGrundy1998] = load_optcteH2Oice_GhoSST(varargin)
%   load any data in the downloaded GhoSST data
%
%  Input Parameters
%    fnameList : Cell array of the names of the file
%    name_header: header added to the name ('_' is automatically added)
%  Optional Input Parameters
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/GhoSST/data/'
%  Output Parameters
%    data_GhoSST: struct
%      'name'  : string, [name_header '_' <file_name>] (<file_name> comes 
%                from the meta information stored in each text file.
%      'fname' : string, file name of the text file "*.data.ascii"
%      'basename','units', : empty
%     
%      other fields are inherited from the output of "GhoSSTread.m"
%      

dirpath = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/GhoSST/data/';

if (rem(length(varargin),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        switch upper(varargin{i})
            case 'DIRPATH'
                dirpath = varargin{i+1};
            otherwise
                % Hmmm, something wrong with the parameter string
                error(['Unrecognized option: ''' varargin{i} '''']);
        end
    end
end

N = length(fnameList);
data_GhoSST = struct('name',deal(cell(N,1)),...
                     'fname',deal(cell(N,1)),...
                     'basename',deal(cell(N,1)),...
                     'units',deal(cell(N,1)),...
                     'data',deal(cell(N,1)));
for i=1:N
    fname = fnameList{i};
    fpath = joinPath(dirpath,fname);
    [pathstr,basename,ext] = fileparts(fpath);
    [datum] = GhoSSTread(fpath);
    data_GhoSST(i).fname = fname;
    data_GhoSST(i).name = [name_header '_' datum.file_name];
    flds = fieldnames(datum);
    for j=1:length(flds)
        fld = flds{j};
        data_GhoSST(i).(fld) = datum.(fld);
    end
end

end
