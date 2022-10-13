function [reflsimulH2Oice_GhoSSTAppere] = load_reflsimulH2Oice_GhoSSTAppere(varargin)
% [reflsimulH2Oice_GhoSSTAppere] = load_reflsimulH2Oice_GhoSSTAppere(varargin)
%   load simulated H2Oice reflectance spectra stored in GhoSST repository, 
%   first recorded in
%     Appéré, T., Schmitt, B., Langevin, Y., Douté, S., Pommerol, 
%     A., Forget, F., ? Bibring, J. P. (2011). Winter and spring evolution 
%     of northern seasonal deposits on Mars from OMEGA on Mars Express. 
%     Journal of Geophysical Research E: Planets, 116(5). 
%     http://doi.org/10.1029/2010JE003762
%  Optional Input Parameters
%    'FNAMELIST' : Cell array of the names of the file
%                  (default) ..see the source code
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/GhoSST/data/'
%    'CLEARCACHE': Boolean, (default) false
%  Output Parameters
%    reflsimulH2Oice_GhoSSTAppere: struct
%        field "name" is prefixed by "reflsimulH2Oice_GhoSSTAppere"
%    refer "load_GhoSST.m" for other information.

fnameList = {'refl-NIR_simul-snow-H2O-100mic-120K.data.ascii',...
             'refl-NIR_simul-snow-H2O-100mic-140K.data.ascii',...
             'refl-NIR_simul-snow-H2O-100mic-160K.data.ascii',...
             'refl-NIR_simul-snow-H2O-100mic-180K.data.ascii',...
             'refl-NIR_simul-snow-H2O-100mic-200K.data.ascii',...
             'refl-NIR_simul-snow-H2O-100mic-220K.data.ascii',...
             'refl-NIR_simul-snow-H2O-100mic-270K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-10mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-20mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-30mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-40mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-50mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-75mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-100mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-200mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-300mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-400mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-500mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-1000mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-2000mic-145K.data.ascii',...
             'refl-NMIR_simul-snow-H2O-5000mic-145K.data.ascii'};

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

cachefilepath = joinPath(dirpath,'reflsimulH2Oice_GhoSSTAppere.mat');

if exist(cachefilepath,'file') && ~clearcache
    load(cachefilepath,'reflsimulH2Oice_GhoSSTAppere');
else
    reflsimulH2Oice_GhoSSTAppere = load_GhoSST(fnameList,'reflsimulH2Oice_GhoSSTAppere',...
                                   'DIRPATH',dirpath);
    save(cachefilepath,'reflsimulH2Oice_GhoSSTAppere');
end

end