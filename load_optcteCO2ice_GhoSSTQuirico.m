function [optcteCO2ice_GhoSSTQuirico] = load_optcteCO2ice_GhoSSTQuirico(varargin)
% [optcteCO2ice_GhoSSTQuirico] = load_optcteCO2ice_GhoSSTQuirico(varargin)
%   load optical constant stored in GhoSST repository, first recorded in
%     Quirico, E., Douté, S., Schmitt, B., De Bergh, C., Cruikshank, 
%     D. P., Owen, T. C., Roush, T. L. (1999). Composition, 
%     physical state, and distribution of ices at the surface of Triton. 
%     Icarus, 139(2), 159?178. http://doi.org/10.1006/icar.1999.6111
%     and
%     Quirico, E., & Schmitt, B. (1997). Near-Infrared spectroscopy of 
%     simple hydrocarbons and carbon oxides diluted in Solid N2 and as 
%     pure ices: Implications for Triton and Pluto. Icarus, 127(2), 
%     354?378. http://doi.org/10.1006/icar.1996.5663

%  Optional Input Parameters
%    'FNAMELIST' : Cell array of the names of the file
%                  (default) ..see the source code
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/GhoSST/data/'
%    'CLEARCACHE': Boolean, (default) false
%  Output Parameters
%    optcteCO2ice_GhoSSTQuirico: struct
%        field "name" is prefixed by "optcteCO2ice_GhoSSTQuirico"
%    refer "load_GhoSST.m" for other information.

fnameList = {'optcte-NIR-CO2cr-179-28K.data.ascii'};

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

cachefilepath = joinPath(dirpath,'optcteCO2ice_GhoSSTQuirico.mat');

if exist(cachefilepath,'file') && ~clearcache
    load(cachefilepath,'optcteCO2ice_GhoSSTQuirico');
else
    [optcteCO2ice_GhoSSTQuirico] = load_GhoSST(fnameList,'optcteCO2ice_GhoSSTQuirico',...
                                   'DIRPATH',dirpath);
    save(cachefilepath,'optcteCO2ice_GhoSSTQuirico');
end