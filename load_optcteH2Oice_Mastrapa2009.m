function [optcteH2Oice_Mastrapa2009] = load_optcteH2Oice_Mastrapa2009(varargin)
% [optcteH2Oice_Mastrapa2009] = load_optcteH2Oice_Mastrapa2009(varargin)
%   load optical constant in 
%     Mastrapa, R. M., Sandford, S. A., Roush, T. L., Cruikshank, D. P., & 
%     Dalle Ore, C. M. (2009). Optical Constants of H_2O-Ice. 
%     The Astrophysical Journal, 701, 1347-1356.
%  Optional Input Parameters
%    'FNAMELIST' : Cell array of the names of the file
%                  (default) ..see the source code
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Mastrapa/AJ2009/h2o_nk/'
%    'CLEARCACHE': Boolean, (default) false
%  Output Parameters
%    optcteH2Oice_Mastrapa2009: struct having field
%        'name' : string, prefixed with 'optcteH2Oice_Mastrapa2009_'
%                 referring to name of the entry 
%                 (e.g. 'optcteH2Oice_Mastrapa2009_crys_20K')
%        'fname': string, name of the file, such as 'crys_20K.txt'
%        'basename' : basename of "fname", such as 'crys_20K'
%        'units': struct, having three fields {'wavelength','n','k'}
%        'data' : struct, having three fields {'wavelength','n','k'},
%                 storing recorded data table

fnameList = {'amorph_15K.txt',...
             'amorph_25K.txt',...
             'amorph_40K.txt',...
             'amorph_50K.txt',...
             'amorph_60K.txt',...
             'amorph_80K.txt',...
             'amorph_100K.txt',...
             'amorph_120K.txt',...
             'crys_20K.txt',...
             'crys_30K.txt',...
             'crys_40K.txt',...
             'crys_50K.txt',...
             'crys_60K.txt',...
             'crys_70K.txt',...
             'crys_80K.txt',...
             'crys_90K.txt',...
             'crys_100K.txt',...
             'crys_110K.txt',...
             'crys_120K.txt',...
             'crys_130K.txt',...
             'crys_140K.txt',...
             'crys_150K.txt'};
% 'crys_140K.txt' is exlcuded.

% edited by Yuki 2018.01.03
% 'crys_140K.txt' is restored from
% "http://gwest.gats-inc.com/ice_index/index_ice_rf_mastrapa_Ic_140K.txt"

dirpath = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Mastrapa/AJ2009/h2o_nk/';
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

cachefilepath = joinPath(dirpath,'optcteH2Oice_Mastrapa2009.mat');

if exist(cachefilepath,'file') && ~clearcache
    load(cachefilepath,'optcteH2Oice_Mastrapa2009');
else
    N = length(fnameList);
    optcteH2Oice_Mastrapa2009 = struct('name',deal(cell(N,1)),...
                                       'fname',deal(cell(N,1)),...
                                       'basename',deal(cell(N,1)),...
                                       'units',deal(cell(N,1)),...
                                       'data',deal(cell(N,1)));
    for i=1:N
        fname = fnameList{i};
        fpath = joinPath(dirpath,fname);
        [pathstr,basename,ext] = fileparts(fpath);
        [spcH2O_Mastrapa,unitsH2O_Mastrapa] = readMastrapa2009H2OIce(fpath);
        optcteH2Oice_Mastrapa2009(i).fname = fname;
        optcteH2Oice_Mastrapa2009(i).basename = basename;
        optcteH2Oice_Mastrapa2009(i).name = ['optcteH2Oice_Mastrapa2009_' basename];
        optcteH2Oice_Mastrapa2009(i).units = unitsH2O_Mastrapa;
        optcteH2Oice_Mastrapa2009(i).data = spcH2O_Mastrapa;
    end
    save(cachefilepath,'optcteH2Oice_Mastrapa2009');
end