function [abscoeffCO2icelib_GhoSSTQuirico] = load_abscoeffCO2icelib_GhoSSTQuirico()
% [abscoeffCOwicelib_GhoSSTQuirico] = load_abscoeffCOwicelib_GhoSSTQuirico()
%   load the library of absorption coefficient of CO2 ice 
%   computed from the optical constant in (Quirico et al. 2008)
%
% Output Parameters
%   abscoeffCOwicelib_GhoSSTQuirico: 
%   struct, library inherited from the struct optcteH2Oice_Mastrapa2009 
%   (output of "load_optcteCO2ice_GhoSSTQuirico()"), with new fields
%   'wavelength', 'abscoeff', 'libname' (='GhoSSTQuirico1997') added
%   

[optcteCO2ice_GhoSSTQuirico] = load_optcteCO2ice_GhoSSTQuirico();
abscoeffCO2icelib_GhoSSTQuirico = optcteCO2ice_GhoSSTQuirico;
wv = [optcteCO2ice_GhoSSTQuirico.data.Wavelength];
k = [optcteCO2ice_GhoSSTQuirico.data.k_index];
wv = flip(wv(:));
k = flip(k(:));
[abscoeff] = optcte_im2abscoeff(k(:),wv(:));
abscoeffCO2icelib_GhoSSTQuirico.abscoeff = abscoeff(:);
abscoeffCO2icelib_GhoSSTQuirico.wavelength = wv(:)*1000;
abscoeffCO2icelib_GhoSSTQuirico.libname = 'GhoSSTQuirico1997';
abscoeffCO2icelib_GhoSSTQuirico.unit_abscoeff = '1/(micro meter)';
abscoeffCO2icelib_GhoSSTQuirico.unit_wavelength = 'nm';

end