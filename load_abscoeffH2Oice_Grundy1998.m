function [abscoeffH2Oice_Grundy1998] = load_abscoeffH2Oice_Grundy1998(varargin)
%  [abscoeffH2Oice_Grundy1998] = load_abscoeffH2Oice_Grundy1998(varargin)
%   load absorption coefficient of water ice in 
%    Grundy, W. M., & Schmitt, B. (1998). The temperature-dependent 
%    near-infrared absorption spectrum of hexagonal H 2 O ice. 
%    Journal of Geophysical Research: Planets, 103(E11), 25809?25822. 
%    http://doi.org/10.1029/98JE00738

%  Optional Input Parameters
%    'FNAME' : Name of the file
%              (default) 'alpha_H2O.ascii'
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Grundy/alpha_H2O.ascii/'
%    'CLEARCACHE': Boolean, (default) false
%  Output Parameters
%    abscoeffH2Oice_Grundy1998: struct

fname = 'alpha_H2O.ascii';
dirpath = '/Users/itohy1/data/ancillary/optprop/Grundy/alpha_H2O.ascii/';
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

cachefilepath = joinPath(dirpath,'abscoeffH2Oice_Grundy1998.mat');

if exist(cachefilepath,'file') && ~clearcache
    load(cachefilepath,'abscoeffH2Oice_Grundy1998');
else
    fpath = joinPath(dirpath,fname);
    [data,units] = readGrundyH2OIce(fpath);
    abscoeffH2Oice_Grundy1998 = data;
    for i=1:length(abscoeffH2Oice_Grundy1998)
        abscoeffH2Oice_Grundy1998(i).fname = fname;
        abscoeffH2Oice_Grundy1998(i).name = ['abscoeffH2Oice_Grundy1998_' num2str(abscoeffH2Oice_Grundy1998(i).temperature) 'K'];
        abscoeffH2Oice_Grundy1998(i).units = units;
    end
    save(cachefilepath,'abscoeffH2Oice_Grundy1998');
end