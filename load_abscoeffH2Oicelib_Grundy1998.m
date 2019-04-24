function [abscoeffH2Oicelib_Grundy1998] = load_abscoeffH2Oicelib_Grundy1998()
% [abscoeffH2Oicelib_Grundy1998] = load_abscoeffH2Oicelib_Grundy1998()
%   load the library of absorption coefficient of H2O ice in 
%    (Grundy et al., 1998).
%
% Output Parameters
%   abscoeffH2Oicelib_Grundy1998: 
%   struct, library inherited from the struct abscoeffH2Oice_Grundy1998 
%   (output of "load_abscoeffH2Oice_Grundy1998()"), with new fields
%   'wavelength', 'abscoeff', 'libname' (='Grundy1998') added
%   

[abscoeffH2Oice_Grundy1998] = load_abscoeffH2Oice_Grundy1998();
abscoeffH2Oicelib_Grundy1998 = abscoeffH2Oice_Grundy1998;
for i=1:length(abscoeffH2Oicelib_Grundy1998)
    wv = [abscoeffH2Oice_Grundy1998(i).data.wavelength];
    abscoeff = [abscoeffH2Oice_Grundy1998(i).data.kab];
    abscoeff = abscoeff(:).*1e-4;
    abscoeffH2Oicelib_Grundy1998(i).abscoeff = abscoeff;
    abscoeffH2Oicelib_Grundy1998(i).wavelength = wv(:)*1000;
    abscoeffH2Oicelib_Grundy1998(i).libname = 'Grundy1998';
    abscoeffH2Oicelib_Grundy1998(i).unit_abscoeff = '1/(micro meter)';
    abscoeffH2Oicelib_Grundy1998(i).unit_wavelength = 'nm';
end

end