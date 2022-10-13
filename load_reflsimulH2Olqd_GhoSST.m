function [reflsimulH2Olqd_GhoSST] = load_reflsimulH2Olqd_GhoSST(varargin)
% [reflsimulH2Olqd_GhoSST] = load_reflsimulH2Olqd_GhoSST(varargin)
%   load simulated H2Oice reflectance spectra stored in GhoSST repository, 
%   filed as 'refl-NIR_simul-liq-H2O-100mic-273K' and
%   'refl-NIR_simul-liq-H2O-100mic-293K'
%  Optional Input Parameters
%    'FNAMELIST' : Cell array of the names of the file
%                  (default) ..see the source code
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/GhoSST/data/'
%    'CLEARCACHE': Boolean, (default) false
%  Output Parameters
%    reflsimulH2Olqd_GhoSST: struct
%        field "name" is prefixed by "reflsimulH2Olqd_GhoSST"
%    refer "load_GhoSST.m" for other information.

fnameList = {'refl-NIR_simul-liq-H2O-100mic-273K.data.ascii',...
             'refl-NIR_simul-liq-H2O-100mic-293K.data.ascii'};

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

cachefilepath = joinPath(dirpath,'reflsimulH2Olqd_GhoSST.mat');

if exist(cachefilepath,'file') && ~clearcache
    load(cachefilepath,'reflsimulH2Olqd_GhoSST');
else
    reflsimulH2Olqd_GhoSST = load_GhoSST(fnameList,'reflsimulH2Olqd_GhoSST',...
                                   'DIRPATH',dirpath);
    save(cachefilepath,'reflsimulH2Olqd_GhoSST');
end

end