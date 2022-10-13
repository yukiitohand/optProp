% GhoSST data
dpath_GhoSST = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/GhoSST/data/';
fnameList_h2o_liq = {'refl-NIR_simul-liq-H2O-100mic-273K.data.ascii',...
                     'refl-NIR_simul-liq-H2O-100mic-293K.data.ascii'};

reflsimulH2Olqd_GhoSST = [];
for i=1:length(fnameList_h2o_liq)
    fname = fnameList_h2o_liq{i};
    fpath = joinPath(dpath_GhoSST,fname);
    spcH2O = GhoSSTread(fpath);
    tmp = [];
    tmp.data = spcH2O;
    tmp.name = fname;
    reflsimulH2Olqd_GhoSST{i} = tmp;
end

save reflsimulH2Olqd_GhoSST reflsimulH2Olqd_GhoSST

%%
load('reflsimulH2Olqd_GhoSST.mat', 'reflsimulH2Olqd_GhoSST');
figure; hold on;
for i=1:length(reflsimulH2Olqd_GhoSST)
    plot(reflsimulH2Olqd_GhoSST{i}.data.Wavelength,reflsimulH2Olqd_GhoSST{i}.data.Intensity,...
        'DisplayName', reflsimulH2Olqd_GhoSST{i}.name,...
        'Color',[0 0.8 0]);
end