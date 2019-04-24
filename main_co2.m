% GhoSST data
dpath_GhoSST = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/GhoSST/data/';
fnameList_co2ice = {'optcte-MIR+FIR-CO2cr-15K.data.ascii',...
                     'optcte-NIR-CO2cr-179-28K.data.ascii'};

optcteCO2ice_GhoSST = [];
for i=1:length(fnameList_co2ice)
    fname = fnameList_co2ice{i};
    fpath = joinPath(dpath_GhoSST,fname);
    spcCO2 = GhoSSTread(fpath);
    tmp = [];
    tmp.data = spcCO2;
    tmp.name = fname;
    optcteCO2ice_GhoSST{i} = tmp;
end

save optcteCO2ice_GhoSST optcteCO2ice_GhoSST

%%
% Hansen
dirpathco2_hansen = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Hansen/';
fname2005 = 'jgre2052-sup-0002-abscoeff.txt';
fname1997 = 'co2_hansen_phdthesis_all.txt';
[ spc2005,~ ] = readHansen2005CO2( joinPath(dirpathco2_hansen,fname2005) );

[ spc1997,~ ] = readHansen1997PhDThesisCO2( joinPath(dirpathco2_hansen,fname1997) );

% merge (use all data from 2005, use all data until 1.8414um (index:12601) 
% from 1997)

wl_1997 = flip([spc1997.wavelength]);
wn_1997 = flip([spc1997.waveNumber]);
kabs_1997 = flip([spc1997.abscoeff]);
minkabs_1997 = flip([spc1997.min_abscoeff]);
maxkabs_1997 = flip([spc1997.max_abscoeff]);

wl_2005 = [spc2005.wavelength];
wn_2005 = [spc2005.waveNumber];
kabs_2005 = [spc2005.abscoeff];
minkabs_2005 = [spc2005.min_abscoeff];
maxkabs_2005 = [spc2005.max_abscoeff];

idx_97 = 12601; idx97flip = 58;
wl = [wl_2005 wl_1997(idx97flip:end)];
wn = [wn_2005 wn_1997(idx97flip:end)];
kabs = [kabs_2005 kabs_1997(idx97flip:end)];
minkabs = [minkabs_2005 minkabs_1997(idx97flip:end)];
maxkabs = [maxkabs_2005 maxkabs_1997(idx97flip:end)];

abscoeffCO2ice_Hansen = struct('wavelength',deal(num2cell(wl)),...
                               'waveNumber',deal(num2cell(wn)),...
                               'abscoeff',deal(num2cell(kabs)),...
                               'min_abscoeff',deal(num2cell(minkabs)),...
                               'max_abscoeff',deal(num2cell(maxkabs)));
abscoeffCO2ice_Hansen = abscoeffCO2ice_Hansen';

save abscoeffCO2ice_Hansen abscoeffCO2ice_Hansen

%%
% Warren
fpath_Warren = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Warren/optical_constants_CO2.txt';
[optcteCO2ice_Warren1986,~] = readWarren1986CO2(fpath_Warren);
save optcteCO2ice_Warren1986 optcteCO2ice_Warren1986

%%
load('optcteCO2ice_GhoSST.mat', 'optcteCO2ice_GhoSST');
load('abscoeffCO2ice_Hansen.mat','abscoeffCO2ice_Hansen');
load('optcteCO2ice_Warren1986.mat', 'optcteCO2ice_Warren1986');

abscoeffCO2ice_Warren1986 = 4*pi*[optcteCO2ice_Warren1986.m_im]./[optcteCO2ice_Warren1986.wavelength];

abscoeffCO2ice_GhoSST = [];
for i=1:length(optcteCO2ice_GhoSST)
    abscoeff = 4*pi*optcteCO2ice_GhoSST{i}.data.k_index ./ optcteCO2ice_GhoSST{i}.data.Wavelength;
    abscoeffCO2ice_GhoSST{i} = abscoeff;
end

%%

figure;
plot([optcteCO2ice_Warren1986.wavelength],abscoeffCO2ice_Warren1986,...
    'DisplayName','Warren 1986 Adv. Optics',...
    'Color',[0.8 0.8 0]);
axis tight;
xlim([1.0 2.7]);


hold on;
plot([abscoeffCO2ice_Hansen.wavelength],[abscoeffCO2ice_Hansen.abscoeff].*1e-6,...
    'DisplayName','Hansen - CO2ice');

% figure;
hold on;
for i=1:length(abscoeffCO2ice_GhoSST)
    plot(optcteCO2ice_GhoSST{i}.data.Wavelength,abscoeffCO2ice_GhoSST{i},...
        'DisplayName', optcteCO2ice_GhoSST{i}.name,...
        'Color',[0 0.8 0]);
end

xlim([1.0 2.65]);
ylim([0 0.0045]);


                  