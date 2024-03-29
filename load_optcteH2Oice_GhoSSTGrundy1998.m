function [optcteH2Oice_GhoSSTGrundy1998] = load_optcteH2Oice_GhoSSTGrundy1998(varargin)
% [optcteH2Oice_GhoSSTGrundy1998] = load_optcteH2Oice_GhoSSTGrundy1998(varargin)
%   load optical constant stored in GhoSST repository, first recorded in
%     Grundy, W. M., & Schmitt, B. (1998). The temperature-dependent 
%     near-infrared absorption spectrum of hexagonal H2O ice. 
%     Journal of Geophysical Research: Planets, 103(E11), 25809?25822.
%  Optional Input Parameters
%    'FNAMELIST' : Cell array of the names of the file
%                  (default) ..see the source code
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/GhoSST/data/'
%    'CLEARCACHE': Boolean, (default) false
%  Output Parameters
%    optcteH2Oice_GhoSSTGrundy1998: struct
%        field "name" is prefixed by "optcteH2Oice_GhoSSTGrundy1998"
%    refer "load_GhoSST.m" for other information.

fnameList = {'optcte-NIR-H2O-Ih-100K.data.ascii',...
             'optcte-NIR-H2O-Ih-110K.data.ascii',...
             'optcte-NIR-H2O-Ih-120K.data.ascii',...
             'optcte-NIR-H2O-Ih-130K.data.ascii',...
             'optcte-NIR-H2O-Ih-140K.data.ascii',...
             'optcte-NIR-H2O-Ih-150K.data.ascii',...
             'optcte-NIR-H2O-Ih-160K.data.ascii',...
             'optcte-NIR-H2O-Ih-170K.data.ascii',...
             'optcte-NIR-H2O-Ih-180K.data.ascii',...
             'optcte-NIR-H2O-Ih-190K.data.ascii',...
             'optcte-NIR-H2O-Ih-200K.data.ascii',...
             'optcte-NIR-H2O-Ih-20K.data.ascii',...
             'optcte-NIR-H2O-Ih-210K.data.ascii',...
             'optcte-NIR-H2O-Ih-220K.data.ascii',...
             'optcte-NIR-H2O-Ih-230K.data.ascii',...
             'optcte-NIR-H2O-Ih-240K.data.ascii',...
             'optcte-NIR-H2O-Ih-250K.data.ascii',...
             'optcte-NIR-H2O-Ih-260K.data.ascii',...
             'optcte-NIR-H2O-Ih-270K.data.ascii',...
             'optcte-NIR-H2O-Ih-30K.data.ascii',...
             'optcte-NIR-H2O-Ih-40K.data.ascii',...
             'optcte-NIR-H2O-Ih-50K.data.ascii',...
             'optcte-NIR-H2O-Ih-60K.data.ascii',...
             'optcte-NIR-H2O-Ih-70K.data.ascii',...
             'optcte-NIR-H2O-Ih-80K.data.ascii',...
             'optcte-NIR-H2O-Ih-90K.data.ascii'};

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

cachefilepath = joinPath(dirpath,'optcteH2Oice_GhoSSTGrundy1998.mat');

if exist(cachefilepath,'file') && ~clearcache
    load(cachefilepath,'optcteH2Oice_GhoSSTGrundy1998');
else
    optcteH2Oice_GhoSSTGrundy1998 = load_GhoSST(fnameList,'optcteH2Oice_GhoSSTGrundy1998',...
                                   'DIRPATH',dirpath);
    save(cachefilepath,'optcteH2Oice_GhoSSTGrundy1998');
end