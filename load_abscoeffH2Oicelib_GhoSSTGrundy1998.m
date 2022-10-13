function [abscoeffH2Oicelib_GhoSSTGrundy1998] = load_abscoeffH2Oicelib_GhoSSTGrundy1998()
% [abscoeffH2Oicelib_GhoSSTGrundy1998] = load_abscoeffH2Oicelib_GhoSSTGrundy1998()
%   load the library of absorption coefficient of H2O ice 
%   computed from the optical constant in GhoSST repository, 
%   originally recorded by (Grundy et al. 1998).
%
% Output Parameters
%   abscoeffH2Oicelib_GhoSSTGrundy1998: 
%   struct, library inherited from the struct optcteH2Oice_Mastrapa2009 
%   (output of "load_optcteH2Oice_GhoSSTGrundy1998()"), with new fields
%   'wavelength', 'abscoeff', 'libname' (='GhoSSTGrundy1998') added
%   
[optcteH2Oice_GhoSSTGrundy1998] = load_optcteH2Oice_GhoSSTGrundy1998();
abscoeffH2Oicelib_GhoSSTGrundy1998 = optcteH2Oice_GhoSSTGrundy1998;
for i=1:length(abscoeffH2Oicelib_GhoSSTGrundy1998)
    wv = [optcteH2Oice_GhoSSTGrundy1998(i).data.Wavelength];
    k = [optcteH2Oice_GhoSSTGrundy1998(i).data.k_index];
    wv = flip(wv(:));
    k = flip(k(:));
    [abscoeff] = optcte_im2abscoeff(k(:),wv(:));
    abscoeffH2Oicelib_GhoSSTGrundy1998(i).abscoeff = abscoeff;
    abscoeffH2Oicelib_GhoSSTGrundy1998(i).wavelength = wv(:)*1000;
    abscoeffH2Oicelib_GhoSSTGrundy1998(i).libname = 'GhoSSTGrundy1998';
    abscoeffH2Oicelib_GhoSSTGrundy1998(i).unit_abscoeff = '1/(micro meter)';
    abscoeffH2Oicelib_GhoSSTGrundy1998(i).unit_wavelength = 'nm';
end

end