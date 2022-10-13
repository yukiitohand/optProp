function [ spcs,units ] = readGrundyH2OIce( filePath )
% [ spcs ] = readGrundyH2OIce( filePath )
%   read the absorption coefficient of H2O ice distributed by Grundy directly.

%     # Grundy, W.M. and B. Schmitt (1998), The Temperature-Dependent        
%     #     Near-Infrared Absorption Spectrum of Hexagonal H2O Ice.          
%     #     J. Geophys. Res. E, 103, 25,809-25,822.                          
%     # 
%     # Column 1 contains wavelengths in microns.
%     # 
%     # Columns 2 - 27 contain Lambert absorption coefficients for ice       
%     # at temperatures (K) equal to the column number multiplied by 10.     
%     # Absorption coefficient units are cm-1.
%     # 
%     9.623e-01  1.033e-01  1.206e-01  1.067e-01  1.506e-01  1.718e-01  2.017e-01  2.003e-01  2.622e-01  2.729e-01  3.033e-01  3.402e-01  3.035e-01  2.998e-01  1.514e-01  2.722e-02  4.562e-02  7.106e-03  6.741e-03  6.798e-03  7.422e-03  7.495e-03  8.219e-03  5.827e-02  1.182e-02  1.746e-02  2.275e-02
%     9.628e-01  1.021e-01  1.133e-01  1.047e-01  1.424e-01  1.725e-01  1.875e-01  1.834e-01  2.478e-01  2.674e-01  2.854e-01  3.242e-01  2.894e-01  2.911e-01  1.483e-01  2.364e-02  4.234e-02  3.638e-03  3.264e-03  4.055e-03  4.872e-03  5.669e-03  6.693e-03  5.685e-02  1.095e-02  1.718e-02  2.287e-02


spc = [];

fid = fopen(filePath,'r','n','UTF-8');
% skip headers
flg_skip=1;
for i=1:10
    fgetl(fid);
end

data = fscanf(fid,'%f');
data = reshape(data,[27,length(data)/27])';

for i=1:26
    spcs(i).temperature = 10*(i+1);
    datum_stru = struct('wavelength',deal(num2cell(data(:,1))),...
                        'kab',deal(num2cell(data(:,i+1))));
    spcs(i).data = datum_stru;
%     spcs(i).wavelength = data(:,1);
%     spcs(i).kab = data(:,i+1);
end

units = struct('wavelength','micro meter','kab','1/cm');



    
end

