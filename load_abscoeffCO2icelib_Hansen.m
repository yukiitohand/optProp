function [abscoeffCO2icelib_Hansen] = load_abscoeffCO2icelib_Hansen()
% [abscoeffCO2icelib_Hansen] = load_abscoeffCO2icelib_Hansen()
%   load the library of absorption coefficient of CO2 published by Hansen.
%
% Output Parameters
%   abscoeffCO2icelib_Hansen: 
%   struct, library inherited from the struct abscoeffCO2icelib_Hansen
%   (output of "load_abscoeffCO2ice_Hansen()"), with new fields
%   'wavelength', 'abscoeff', 'libname' (='Hansen') added
%  
%   the unit of 'abscoeff' is converted to [1/(micro meter)] 

[abscoeffCO2icelib_Hansen] = load_abscoeffCO2ice_Hansen();
abscoeff = [abscoeffCO2icelib_Hansen.data.abscoeff].*1e-6;
abscoeffCO2icelib_Hansen.abscoeff = abscoeff(:);
wv = [abscoeffCO2icelib_Hansen.data.wavelength];
abscoeffCO2icelib_Hansen.wavelength = wv(:)*1000;
abscoeffCO2icelib_Hansen.libname = 'Hansen';
abscoeffCO2icelib_Hansen.unit_abscoeff = '1/(micro meter)';
abscoeffCO2icelib_Hansen.unit_wavelength = 'nm';

end