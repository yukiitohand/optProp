% read Warren 2008 H2O
fpath_Warren = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Warren/IOP_2008_ASCIItable.dat';
[optcteH2Oice_Warren2008,~] = readWarren2008H2O(fpath_Warren);
save optcteH2Oice_Warren2008 optcteH2Oice_Warren2008

%%
% read Mastrapa 2009 Astronomical Journal
dpath_Mastrapa = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Mastrapa/AJ2009/h2o_nk/';
dir_dpath = dir(dpath_Mastrapa);
optcteH2Oice_Mastrapa2009 = [];
for i=1:length(dir_dpath)
    if ~dir_dpath(i).isdir
        fname = dir_dpath(i).name;
        fpath = joinPath(dir_dpath(i).folder,fname);
        [pathstr,basename,ext] = fileparts(fpath);
        if ~strcmpi(basename,'crys_140K')
            [spcH2O_Mastrapa,~] = readMastrapa2009H2O(fpath);
            optcteH2Oice_Mastrapa2009.(basename) = spcH2O_Mastrapa;
        end
    end
end

save optcteH2Oice_Mastrapa2009 optcteH2Oice_Mastrapa2009

%%
% read Mastrapa 2008 Icarus
dpath_Mastrapa2 = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Mastrapa/Icarus2008/opt_cons/n_k/';
dir_dpath = dir(dpath_Mastrapa2);
optcteH2Oice_Mastrapa2008 = [];
for i=1:length(dir_dpath)
    if ~dir_dpath(i).isdir
        fname = dir_dpath(i).name;
        if isempty(regexpi(fname,'^\..*','once'))
            fpath = joinPath(dir_dpath(i).folder,fname);
            [pathstr,basename,ext] = fileparts(fpath);
            [spcH2O_Mastrapa,~] = readMastrapa2008H2O(fpath);
            optcteH2Oice_Mastrapa2008.(basename) = spcH2O_Mastrapa;
        end
    end
end

save optcteH2Oice_Mastrapa2008 optcteH2Oice_Mastrapa2008

%%
% read Grundy
filePath_grundy = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Grundy/alpha_H2O.ascii/alpha_H2O.ascii';
[ abscoeffH2Oice_Grundy1998 ] = readGrundyH2O( filePath_grundy );
save abscoeffH2Oice_Grundy1998 abscoeffH2Oice_Grundy1998

%%
% GhoSST spectra
dpath_GhoSST = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/GhoSST/data/';
fnameList_h2oice = {'optcte-NIR-H2O-Ih-100K.data.ascii',...
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
optcteH2Oice_GhoSST = [];
for i=1:length(fnameList_h2oice)
    fname = fnameList_h2oice{i};
    fpath = joinPath(dpath_GhoSST,fname);
    spcH2O = GhoSSTread(fpath);
    tmp = [];
    tmp.data = spcH2O;
    tmp.name = fname;
    optcteH2Oice_GhoSST{i} = tmp;
end

save optcteH2Oice_GhoSST optcteH2Oice_GhoSST

fnameList_h2oice_refl = {'refl-NIR_simul-snow-H2O-100mic-120K.data.ascii',...
                        'refl-NIR_simul-snow-H2O-100mic-140K.data.ascii',...
                        'refl-NIR_simul-snow-H2O-100mic-160K.data.ascii',...
                        'refl-NIR_simul-snow-H2O-100mic-180K.data.ascii',...
                        'refl-NIR_simul-snow-H2O-100mic-200K.data.ascii',...
                        'refl-NIR_simul-snow-H2O-100mic-220K.data.ascii',...
                        'refl-NIR_simul-snow-H2O-100mic-270K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-1000mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-100mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-10mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-2000mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-200mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-20mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-300mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-30mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-400mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-40mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-5000mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-500mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-50mic-145K.data.ascii',...
                        'refl-NMIR_simul-snow-H2O-75mic-145K.data.ascii'};
reflsimulH2Oice_GhoSST = [];
for i=1:length(fnameList_h2oice_refl)
    fname = fnameList_h2oice_refl{i};
    fpath = joinPath(dpath_GhoSST,fname);
    spcH2O = GhoSSTread(fpath);
    tmp = [];
    tmp.data = spcH2O;
    tmp.name = fname;
    reflsimulH2Oice_GhoSST{i} = tmp;
end
                    
save reflsimulH2Oice_GhoSST reflsimulH2Oice_GhoSST

dir_dpath = dir(dpath_GhoSST);
for i=1:length(dir_dpath)
    fprintf('%s\n',dir_dpath(i).name);
end

%%
% reading

load('optcteH2Oice_Warren2008.mat','optcteH2Oice_Warren2008');
load('optcteH2Oice_Mastrapa2009.mat','optcteH2Oice_Mastrapa2009');
load('optcteH2Oice_Mastrapa2008.mat','optcteH2Oice_Mastrapa2008');
load('optcteH2Oice_GhoSST.mat','optcteH2Oice_GhoSST');
load('abscoeffH2Oice_Grundy1998.mat','abscoeffH2Oice_Grundy1998');

abscoeffH2Oice_Warren2008 = 4*pi*[optcteH2Oice_Warren2008.m_im]./[optcteH2Oice_Warren2008.wavelength];

abscoeffH2Oice_Mastrapa2009 = [];
flds = fieldnames(optcteH2Oice_Mastrapa2009);
for i=1:length(flds)
    fld = flds{i};
    abscoeff = 4*pi*[optcteH2Oice_Mastrapa2009.(fld).k]./[optcteH2Oice_Mastrapa2009.(fld).wavelength];
    abscoeffH2Oice_Mastrapa2009.(fld) = abscoeff;
end

abscoeffH2Oice_Mastrapa2008 = [];
flds = fieldnames(optcteH2Oice_Mastrapa2008);
for i=1:length(flds)
    fld = flds{i};
    abscoeff = 4*pi*[optcteH2Oice_Mastrapa2008.(fld).k]./[optcteH2Oice_Mastrapa2008.(fld).wavelength];
    abscoeffH2Oice_Mastrapa2008.(fld) = abscoeff;
end

abscoeffH2Oice_GhoSST = [];
for i=1:length(optcteH2Oice_GhoSST)
    abscoeff = 4*pi*optcteH2Oice_GhoSST{i}.data.k_index ./ optcteH2Oice_GhoSST{i}.data.Wavelength;
    abscoeffH2Oice_GhoSST{i} = abscoeff;
end

%%
figure;

plot([optcteH2Oice_Warren2008.wavelength],abscoeffH2Oice_Warren2008,...
    'DisplayName','Warren 2008 JGR',...
    'Color',[0.8 0.8 0]);
axis tight;
xlim([1.0 2.7]);


flds = fieldnames(optcteH2Oice_Mastrapa2009);
hold on;
for i=1:length(flds)
    fld = flds{i};
    plot([optcteH2Oice_Mastrapa2009.(fld).wavelength],abscoeffH2Oice_Mastrapa2009.(fld),...
        'DisplayName',['Mastrapa 2009 AJ - ' fld],...
        'Color','b');
end
axis tight;
xlim([1.0 2.7]);

figure; 
flds = fieldnames(optcteH2Oice_Mastrapa2008);
hold on;
for i=1:length(flds)
    fld = flds{i};
    plot([optcteH2Oice_Mastrapa2008.(fld).wavelength],abscoeffH2Oice_Mastrapa2008.(fld),...
        'DisplayName',['Mastrapa 2008 Icarus - ' fld],...
        'Color','r');
end
axis tight;
xlim([1.0 2.65]);

figure; hold on;
for i=1:length(abscoeffH2Oice_GhoSST)
    plot(optcteH2Oice_GhoSST{i}.data.Wavelength,abscoeffH2Oice_GhoSST{i},...
        'DisplayName', optcteH2Oice_GhoSST{i}.name,...
        'Color',[0 0.8 0]);
end

figure; hold on;
for i=1:length(abscoeffH2Oice_Grundy1998)
    plot(abscoeffH2Oice_Grundy1998(i).wavelength,abscoeffH2Oice_Grundy1998(i).kab.*1e-4,...
        'DisplayName',['Grudy 1998 JGR - ' num2str(abscoeffH2Oice_Grundy1998(i).temperature) 'K'],...
        'Color',[0.6 0.6 0.6]);
end

%%
load('reflsimulH2Oice_GhoSST.mat', 'reflsimulH2Oice_GhoSST');
figure; hold on;
for i=1:length(reflsimulH2Oice_GhoSST)
    plot(reflsimulH2Oice_GhoSST{i}.data.Wavelength,reflsimulH2Oice_GhoSST{i}.data.Intensity,...
        'DisplayName', reflsimulH2Oice_GhoSST{i}.name,...
        'Color',[0 0.8 0]);
end