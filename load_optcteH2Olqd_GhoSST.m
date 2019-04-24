function [optcteH2Olqd_GhoSST] = load_optcteH2Olqd_GhoSST(varargin)
% [optcteH2Olqd_GhoSST] = load_optcteH2Olqd_GhoSST(varargin)
%   load simulated H2Oice reflectance spectra stored in GhoSST repository, 
%   filed as 'optcte-NIR-H2O-liq-273K' and 'optcte-NIR-H2O-liq-293K'
%  Optional Input Parameters
%    'FNAMELIST' : Cell array of the names of the file
%                  (default) ..see the source code
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/GhoSST/data/'
%    'CLEARCACHE': Boolean, (default) false
%  Output Parameters
%    optcteH2Olqd_GhoSST: struct
%        field "name" is prefixed by "optcteH2Olqd_GhoSST"
%    refer "load_GhoSST.m" for other information.

fnameList = {'optcte-NIR-H2O-liq-273K.data.ascii',...
             'optcte-NIR-H2O-liq-293K.data.ascii'};

dirpath = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/GhoSST/data/';
clearcache = false;

if (rem(length(varargin),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        switch upper(varargin{i})
            case 'FNAMELIST'
                fnameList = varargin{i+1};
            case 'DIRPATH'
                dirpath = varargin{i+1};
            case 'CLEARCACHE'
                clearcache = varargin{i+1};
            otherwise
                % Hmmm, something wrong with the parameter string
                error(['Unrecognized option: ''' varargin{i} '''']);
        end
    end
end

cachefilepath = joinPath(dirpath,'optcteH2Olqd_GhoSST.mat');

if exist(cachefilepath,'file') && ~clearcache
    load(cachefilepath,'optcteH2Olqd_GhoSST');
else
    optcteH2Olqd_GhoSST = load_GhoSST(fnameList,'optcteH2Olqd_GhoSST',...
                                   'DIRPATH',dirpath);
    save(cachefilepath,'optcteH2Olqd_GhoSST');
end

end