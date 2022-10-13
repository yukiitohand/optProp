function [optcteH2Oice_Warren2008] = load_optcteH2Oice_Warren2008(varargin)
% [optcteH2Oice_Warren2008] = load_optcteH2Oice_Warren2008(varargin)
%   load optical constant of water ice in 
%    Warren, S. G., & Brandt, R. E. (2008). Optical constants of ice from 
%    the ultraviolet to the microwave: A revised compilation. J. Geophys. 
%    Res. (Atmospheres), 113, D14220.

%  Optional Input Parameters
%    'FNAME' : Name of the file
%              (default) 'IOP_2008_ASCIItable.dat'
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Warren/'
%    'CLEARCACHE': Boolean, (default) false
%  Output Parameters
%    optcteH2Oice_Warren2008: struct

fname = 'IOP_2008_ASCIItable.dat';
dirpath = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Warren/';
clearcache = false;

if (rem(length(varargin),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        switch upper(varargin{i})
            case 'FNAME'
                fname = varargin{i+1};
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

cachefilepath = joinPath(dirpath,'optcteH2Oice_Warren2008.mat');

if exist(cachefilepath,'file') && ~clearcache
    load(cachefilepath,'optcteH2Oice_Warren2008');
else
    fpath_Warren = joinPath(dirpath,fname);
    [data,units] = readWarren2008H2OIce(fpath_Warren);
    optcteH2Oice_Warren2008 = [];
    optcteH2Oice_Warren2008.fname = fname;
    optcteH2Oice_Warren2008.name = 'optcteH2Oice_Warren2008';
    optcteH2Oice_Warren2008.units = units;
    optcteH2Oice_Warren2008.data = data;
    save(cachefilepath,'optcteH2Oice_Warren2008');
end