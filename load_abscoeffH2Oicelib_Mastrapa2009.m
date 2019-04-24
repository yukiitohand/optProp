function [abscoeffH2Oicelib_Mastrapa2009] = load_abscoeffH2Oicelib_Mastrapa2009()
% [abscoeffH2Oicelib_Mastrapa2009] = load_abscoeffH2Oicelib_Mastrapa2009()
%   load the library of absorption coefficient of H2O ice
%   computed from the optical constant in (Mastrap et al. 2009).
%
% Output Parameters
%   abscoeffH2Oicelib_Mastrapa2009: 
%   struct, library inherited from the struct optcteH2Oice_Mastrapa2009 
%   (output of "load_optcteH2Oice_Mastrapa2009()"), with new fields
%   'wavelength', 'abscoeff', 'libname' (='Mastrapa2009') added
%   

[optcteH2Oice_Mastrapa2009] = load_optcteH2Oice_Mastrapa2009();
abscoeffH2Oicelib_Mastrapa2009 = optcteH2Oice_Mastrapa2009;
for i=1:length(abscoeffH2Oicelib_Mastrapa2009)
    wv = [optcteH2Oice_Mastrapa2009(i).data.wavelength];
    k = [optcteH2Oice_Mastrapa2009(i).data.k];
    [abscoeff] = optcte_im2abscoeff(k(:),wv(:));
    abscoeffH2Oicelib_Mastrapa2009(i).abscoeff = abscoeff;
    abscoeffH2Oicelib_Mastrapa2009(i).wavelength = wv(:)*1000;
    abscoeffH2Oicelib_Mastrapa2009(i).libname = 'Mastrapa2009';
    abscoeffH2Oicelib_Mastrapa2009(i).unit_abscoeff = '1/(micro meter)';
    abscoeffH2Oicelib_Mastrapa2009(i).unit_wavelength = 'nm';
end

end