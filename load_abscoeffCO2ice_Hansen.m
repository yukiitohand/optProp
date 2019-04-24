function [abscoeffCO2ice_Hansen] = load_abscoeffCO2ice_Hansen(varargin)
% [abscoeffCO2ice_Hansen] = load_abscoeffCO2ice_Hansen(varargin)
%   load absorption coefficient of CO2Ice in 
%    Hansen, G. B. (2005). Ultraviolet to near-infrared absorption spectrum
%    of carbon dioxide ice from 0.174 to 1.8 ?m. Journal of Geophysical 
%    Research, 110(E11), E11003. http://doi.org/10.1029/2005JE002531
%    and
%    Hansen, G. B. (1996). The infrared absorption spectrum of carbon 
%    dioxide ice. PhD Thesis, University of Washington, Seattle.
%
%  The output is a merged data.
%  Optional Input Parameters
%    'DIRPATH : Path to the directory
%               (default) '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Hansen/'
%    'CLEARCACHE': Boolean, (default) false
%  Output Parameters
%    abscoeffCO2ice_Hansen: struct havinf three fields
%         'name'  : 'abscoeffCO2ice_Hansen'
%         'data'  : struct
%             'wavelength'
%             'waveNumber'
%             'abscoeff'
%             'min_abscoeff'
%             'max_abscoeff'
%         'units': struct
%             'wavelength','micro meter'
%             'waveNumber','1/cm'
%             'abscoeff','1/m'
%             'min_abscoeff','1/m'
%             'max_abscoeff','1/m'

dirpath = '/Users/yukiitoh/Box Sync/data/ancillary/optprop/Hansen/';
clearcache = false;

if (rem(length(varargin),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        switch upper(varargin{i})
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

fname2005 = 'jgre2052-sup-0002-abscoeff.txt';
fname1997 = 'co2_hansen_phdthesis_all.txt';

cachefilepath = joinPath(dirpath,'abscoeffCO2ice_Hansen.mat');

if exist(cachefilepath,'file') && ~clearcache
    load(cachefilepath,'abscoeffCO2ice_Hansen');
else
    [ spc2005,units05 ] = readHansen2005CO2Ice( joinPath(dirpath,fname2005) );
    [ spc1997,units97 ] = readHansen1997PhDThesisCO2Ice( joinPath(dirpath,fname1997) );
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

    abscoeffCO2ice_Hansen = [];
    abscoeffCO2ice_Hansen.name = 'abscoeffCO2ice_Hansen';
    abscoeffCO2ice_Hansen.units = units05;
    data = struct('wavelength',deal(num2cell(wl)),...
                  'waveNumber',deal(num2cell(wn)),...
                  'abscoeff',deal(num2cell(kabs)),...
                  'min_abscoeff',deal(num2cell(minkabs)),...
                  'max_abscoeff',deal(num2cell(maxkabs)));
    abscoeffCO2ice_Hansen.data = data';

    save(cachefilepath,'abscoeffCO2ice_Hansen');
end