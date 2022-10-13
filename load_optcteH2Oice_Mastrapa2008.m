function [optcteH2Oice_Mastrapa2008] = load_optcteH2Oice_Mastrapa2008(varargin)
% [optcteH2Oice_Mastrapa2008] = load_optcteH2Oice_Mastrapa2008(varargin)
%   load optical constant in 
%     Mastrapa, R. M., Bernstein, M. P., Sandford, S. A., Roush, 
%     T. L., Cruikshank, D. P., & Ore, C. M. D. (2008). Optical constants
%     of amorphous and crystalline H2O-ice in the near infrared from 1.1 
%     to 2.6 $\mu$m. Icarus, 197(1), 307-320.
%  Optional Input Parameters
%    'FNAMELIST' : Cell array of the names of the file
%                  (default) ..see the source code
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Mastrapa/Icarus2008/opt_cons/n_k/'
%    'CLEARCACHE': Boolean, (default) false
%  Output Parameters
%    optcteH2Oice_Mastrapa2008: struct having field
%        'name' : string, prefixed with 'optcteH2Oice_Mastrapa2008_'
%                 referring to the name of the entry
%                 (e.g. 'optcteH2Oice_Mastrapa2008_amorph_high')
%        'fname': string, name of the file, such as 'amorph_high.txt'
%        'basename' : basename of "fname", such as 'amorph_high'
%        'units': struct, having three fields {'wavelength','n','k','T'}
%        'data' : struct, having three fields {'wavelength','n','k','T'},
%                 storing recorded data table

fnameList = {'amorph_high.txt',...
             'amorph_low.txt',...
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

dirpath = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Mastrapa/Icarus2008/opt_cons/n_k/';
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

cachefilepath = joinPath(dirpath,'optcteH2Oice_Mastrapa2008.mat');

if exist(cachefilepath,'file') && ~clearcache
    load(cachefilepath,'optcteH2Oice_Mastrapa2008');
else
    N = length(fnameList);
    optcteH2Oice_Mastrapa2008 = struct('name',deal(cell(N,1)),...
                                       'fname',deal(cell(N,1)),...
                                       'basename',deal(cell(N,1)),...
                                       'units',deal(cell(N,1)),...
                                       'data',deal(cell(N,1)));
    for i=1:N
        fname = fnameList{i};
        fpath = joinPath(dirpath,fname);
        [pathstr,basename,ext] = fileparts(fpath);
        [spcH2O_Mastrapa,unitsH2O_Mastrapa] = readMastrapa2008H2OIce(fpath);
        optcteH2Oice_Mastrapa2008(i).fname = fname;
        optcteH2Oice_Mastrapa2008(i).basename = basename;
        optcteH2Oice_Mastrapa2008(i).name = ['optcteH2Oice_Mastrapa2008_' basename];
        optcteH2Oice_Mastrapa2008(i).units = unitsH2O_Mastrapa;
        optcteH2Oice_Mastrapa2008(i).data = spcH2O_Mastrapa;
    end
    save(cachefilepath,'optcteH2Oice_Mastrapa2008');
end