function [Q_H2Oicelib_Grundy1998] = load_Q_H2Oice_Grundy1998(opt,varargin)
% [abscoeffH2Oicelib_Grundy1998] = load_abscoeffH2Oicelib_Grundy1998()
%   load the library of scattering efficiency of H2O ice computed from the
%   optical constants published in (Grundy et al., 1998).
%
% Output Parameters
%   Q_H2Oicelib_Grundy1998: 
%   struct, library inherited from the struct abscoeffH2Oice_Grundy1998 
%   (output of "load_abscoeffH2Oice_Grundy1998()"), with new fields
%   'wavelength', 'abscoeff', 'libname' (='Grundy1998') added
%   

global crism_env_vars
dir_cache = crism_env_vars.dir_CACHE;

overwrite = 0; 
warn_overwrite = 1;
if (rem(length(varargin),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        switch upper(varargin{i})
            case 'DIR_CACHE'
                dir_cache = varargin{i+1};
            case 'OVERWRITE'
                overwrite = varargin{i+1};
            case 'WARN_OVERWRITE'
                warn_overwrite = varargin{i+1};
            otherwise
                error('Unrecognized option: %s', varargin{i});
        end
    end
end

[infocachefname] = sprintf('Q_H2Oicelib_Grundy1998%d_info.mat',opt);
infocachefilepath = fullfile(dir_cache,infocachefname);
if ~overwrite && exist(infocachefilepath,'file')
    load(infocachefilepath,'infoQ_H2Oicelib_Grundy1998');
    Q_H2Oicelib_Grundy1998 = infoQ_H2Oicelib_Grundy1998;
elseif ~exist(infocachefilepath,'file') || overwrite
    flg=1;
    if exist(infocachefilepath,'file')
        if warn_overwrite
            flg = doyouwantto('overwrite',sprintf('%s exists',infocachefilepath));
            if flg
                fprintf('Overwriting %s\n',infocachefilepath);
            end
        end
    end
    
    if flg

        [abscoeffH2Oice_Grundy1998] = load_abscoeffH2Oice_Grundy1998();


        wv = [abscoeffH2Oice_Grundy1998(26).data.wavelength]; % micro meter
        wv = wv(:)*1000; % convert to nano meter

        switch opt
            case 1
                dirpath_Q = '/Users/yukiitoh/src/python/mie_yuki/';
                Q270K = load(joinPath(dirpath_Q,'Q_h2oIce_Grundy1998_270K_1.mat'));
                n = length(Q270K.rList);
                Qsca_lib = struct('wavelength',cell(n,1),'Q',cell(n,1),'libname',cell(n,1),...
                               'unit_wavelength',cell(n,1),'name',cell(n,1),'unit_Q',cell(n,1));
                Qext_lib = struct('wavelength',cell(n,1),'Q',cell(n,1),'libname',cell(n,1),...
                               'unit_wavelength',cell(n,1),'name',cell(n,1),'unit_Q',cell(n,1));
                for i=1:n
                    Qsca_lib(i).wavelength = wv;
                    Qsca_lib(i).Q = Q270K.Qsca(:,i);
                    Qsca_lib(i).unit_Q = '';
                    Qsca_lib(i).unit_wavelength = 'nm';
                    Qsca_lib(i).name = sprintf('Qsca_H2Oice_Grundy_r%2.1fum',Q270K.rList(i));
                    Qsca_lib(i).libname = 'Q_H2Oicelib_Grundy1998_270K_1';

                    Qext_lib(i).wavelength = wv;
                    Qext_lib(i).Q = -Q270K.Qext(:,i);
                    Qext_lib(i).unit_Q = '';
                    Qext_lib(i).unit_wavelength = 'nm';
                    Qext_lib(i).name = sprintf('Qsca_H2Oice_Grundy_r%2.1fum',Q270K.rList(i));
                    Qext_lib(i).libname = 'Q_H2Oicelib_Grundy1998_270K_1';

                end

                Q_H2Oicelib_Grundy1998 = merge_struct(Qext_lib,Qsca_lib);

            case 2
                dirpath_Q = '/Users/yukiitoh/src/python/mie_yuki/';
                fnameList = {'Q_h2oIce_Grundy1998_270K_1.mat','Q_h2oIce_Grundy1998_260K_1.mat','Q_h2oIce_Grundy1998_250K_1.mat'};
                Q_H2Oicelib_Grundy1998 = [];
                for jdx = 1:length(fnameList)
                    fname = fnameList{jdx};
                    Q = load(joinPath(dirpath_Q,fname));
                    n = length(Q.rList);
                    Qw_lib = struct('wavelength',cell(n,1),'Q',cell(n,1),'libname',cell(n,1),...
                                   'unit_wavelength',cell(n,1),'name',cell(n,1),'unit_Q',cell(n,1));
                    Qsca_lib = struct('wavelength',cell(n,1),'Q',cell(n,1),'libname',cell(n,1),...
                                   'unit_wavelength',cell(n,1),'name',cell(n,1),'unit_Q',cell(n,1));
                    for i=1:n
                        Qsca_lib(i).wavelength = wv;
                        Qsca_lib(i).Q = Q.Qsca(:,i);
                        Qsca_lib(i).unit_Q = '';
                        Qsca_lib(i).unit_wavelength = 'nm';
                        Qsca_lib(i).name = sprintf('Qsca_H2Oice_Grundy_r%2.1fum',Q.rList(i));
                        Qsca_lib(i).libname = fname;
                    end
                    Q_H2Oicelib_Grundy1998 = merge_struct(Q_H2Oicelib_Grundy1998,Qsca_lib);
                end

            case 3
                dirpath_Q = '/Users/yukiitoh/src/python/mie_yuki/';
                fnameList = {'Q_h2oIce_Grundy1998_270K_1.mat','Q_h2oIce_Grundy1998_260K_1.mat','Q_h2oIce_Grundy1998_250K_1.mat'};
                Q_H2Oicelib_Grundy1998 = [];
                for jdx = 1:length(fnameList)
                    fname = fnameList{jdx};
                    Q = load(joinPath(dirpath_Q,fname));
                    n = length(Q.rList);
                    Qw_lib = struct('wavelength',cell(n,1),'Q',cell(n,1),'libname',cell(n,1),...
                                   'unit_wavelength',cell(n,1),'name',cell(n,1),'unit_Q',cell(n,1));
                    for i=1:n
                        Qw_lib(i).wavelength = wv;
                        Qw_lib(i).Q = -Q.Qext(:,i)+Q.Qsca(:,i);
                        Qw_lib(i).unit_Q = '';
                        Qw_lib(i).unit_wavelength = 'nm';
                        Qw_lib(i).name = sprintf('Qw_H2Oice_Grundy_r%2.1fum',Q.rList(i));
                        Qw_lib(i).libname = fname;

                    end

                    Q_H2Oicelib_Grundy1998 = merge_struct(Q_H2Oicelib_Grundy1998,Qw_lib);
                end

            otherwise
                    error('opt %d is not defined',opt);
        end
        
        infoQ_H2Oicelib_Grundy1998 = Q_H2Oicelib_Grundy1998;
        save(infocachefilepath,'infoQ_H2Oicelib_Grundy1998');
    end
end

end