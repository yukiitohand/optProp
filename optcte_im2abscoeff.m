function [k_abs] = optcte_im2abscoeff(k,wv)
% convert the imaginary part of the optical constant to absorption
% coefficient using the equation
% k_abs = 4*pi*k/wv
%  where k_abs: absorption coefficient, k: the imaginary part of the
%  optical constant, and wv: wavelength
%
% Input Parameters
%   k: imaginary part of the optical constant
%   wv: wavelenth
% 
% Output Parameters
%   k_abs: absorption coefficient, the unit will be [1/(unit of "wv")]

k_abs = 4 * pi * k ./ wv;

end