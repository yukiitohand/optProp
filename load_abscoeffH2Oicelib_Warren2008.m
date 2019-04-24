function [abscoeffH2Oicelib_Warren2008] = load_abscoeffH2Oicelib_Warren2008()
% [abscoeffH2Oicelib_Warren2008] = load_abscoeffH2Oicelib_Warren2008()
%   load the library of absorption coefficient of H2O ice 
%   computed from the optical constant in (Warren et al. 2008)
%
% Output Parameters
%   abscoeffH2Oicelib_Warren2008: 
%   struct, library inherited from the struct optcteH2Oice_Mastrapa2009 
%   (output of "load_optcteH2Oice_Warren2008()"), with new fields
%   'wavelength', 'abscoeff', 'libname' (='Warren2008') added
%   

[optcteH2Oice_Warren2008] = load_optcteH2Oice_Warren2008();
abscoeffH2Oicelib_Warren2008 = optcteH2Oice_Warren2008;
wv = [optcteH2Oice_Warren2008.data.wavelength];
k = [optcteH2Oice_Warren2008.data.m_im];
[abscoeff] = optcte_im2abscoeff(k(:),wv(:));
abscoeffH2Oicelib_Warren2008.abscoeff = abscoeff;
abscoeffH2Oicelib_Warren2008.wavelength = wv(:)*1000;
abscoeffH2Oicelib_Warren2008.libname = 'Warren2008';
abscoeffH2Oicelib_Warren2008.unit_abscoeff = '1/(micro meter)';
abscoeffH2Oicelib_Warren2008.unit_wavelength = 'nm';

end