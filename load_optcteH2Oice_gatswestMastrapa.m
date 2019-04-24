function [optcteH2Oice_gatswestMastrapa] = load_optcteH2Oice_gatswestMastrapa(varargin)
% [optcteH2Oice_gatswestMastrapa] = load_optcteH2Oice_gatswestMastrapa(varargin)
%   load optical constant of H2O ice summarized at
%     http://gwest.gats-inc.com/ice_index/Ice_Refractive_Index.html
%   originally published at
%     Mastrapa, R. M., Bernstein, M. P., Sandford, S. A., Roush, 
%     T. L., Cruikshank, D. P., & Ore, C. M. D. (2008). Optical constants
%     of amorphous and crystalline H2O-ice in the near infrared from 1.1 
%     to 2.6 $\mu$m. Icarus, 197(1), 307-320.
%  Optional Input Parameters
%    'FNAMELIST' : Cell array of the names of the file
%                  (default) ..see the source code
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/gwest.gats-inc/Mastrapa/'
%    'CLEARCACHE': Boolean, (default) false
%  Output Parameters
%    optcteH2Oice_gatswestMastrapa: struct having field
%        'name' : string, prefixed with 'optcteH2Oice_gatswestMastrapa_'
%                 referring to name of the entry 
%                 (e.g. 'optcteH2Oice_gatswestMastrapa_index_ice_rf_mastrapa_Ic_50K')
%        'fname': string, name of the file, such as 'index_ice_rf_mastrapa_Ic_50K.txt'
%        'basename' : basename of "fname", such as 'index_ice_rf_mastrapa_Ic_50K'
%        'units': struct, having three fields {'wavelength','n','k'}
%        'data' : struct, having three fields {'wavelength','n','k'},
%                 storing recorded data table

fnameList = {'index_ice_rf_mastrapa_Ic_20K.txt',...
             'index_ice_rf_mastrapa_Ic_40K.txt',...
             'index_ice_rf_mastrapa_Ic_50K.txt',...
             'index_ice_rf_mastrapa_Ic_60K.txt',...
             'index_ice_rf_mastrapa_Ic_70K.txt',...
             'index_ice_rf_mastrapa_Ic_80K.txt',...
             'index_ice_rf_mastrapa_Ic_90K.txt',...
             'index_ice_rf_mastrapa_Ic_100K.txt',...
             'index_ice_rf_mastrapa_Ic_110K.txt',...
             'index_ice_rf_mastrapa_Ic_120K.txt',...
             'index_ice_rf_mastrapa_Ic_130K.txt',...
             'index_ice_rf_mastrapa_Ic_140K.txt',...
             'index_ice_rf_mastrapa_Ic_150K.txt'};
% 'crys_140K.txt' is exlcuded.

dirpath = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/gwest.gats-inc/Mastrapa/';
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

cachefilepath = joinPath(dirpath,'optcteH2Oice_gatswestMastrapa.mat');

if exist(cachefilepath,'file') && ~clearcache
    load(cachefilepath,'optcteH2Oice_gatswestMastrapa');
else
    N = length(fnameList);
    optcteH2Oice_gatswestMastrapa = struct('name',deal(cell(N,1)),...
                                       'fname',deal(cell(N,1)),...
                                       'basename',deal(cell(N,1)),...
                                       'units',deal(cell(N,1)),...
                                       'data',deal(cell(N,1)));
    for i=1:N
        fname = fnameList{i};
        fpath = joinPath(dirpath,fname);
        [pathstr,basename,ext] = fileparts(fpath);
        [spcH2O,unitsH2O] = read_gatswestH2OIce(fpath);
        optcteH2Oice_gatswestMastrapa(i).fname = fname;
        optcteH2Oice_gatswestMastrapa(i).basename = basename;
        optcteH2Oice_gatswestMastrapa(i).name = ['optcteH2Oice_gatswestMastrapa_' basename];
        optcteH2Oice_gatswestMastrapa(i).units = unitsH2O;
        optcteH2Oice_gatswestMastrapa(i).data = spcH2O;
    end
    save(cachefilepath,'optcteH2Oice_gatswestMastrapa');
end