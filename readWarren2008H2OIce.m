function [ spc,units ] = readWarren2008H2OIce( filePath )
% [ spc,units ] = readWarren2008H2O( filePath )
%   Read the optical constants of H2O ice published in [Warren 2008]
%   Warren, S. G., & Brandt, R. E. (2008). Optical constants of ice from 
%   the ultraviolet to the microwave: A revised compilation. Journal of 
%   Geophysical Research Atmospheres, 113(14), 1?10.
%    Data will be something like ....
%      4.430E-002    0.8228  1.640E-001
%      4.510E-002    0.8250  1.730E-001
%      4.590E-002    0.8255  1.830E-001
%      4.680E-002    0.8258  1.950E-001
%      4.770E-002    0.8263  2.080E-001
%      4.860E-002    0.8281  2.230E-001
%      4.960E-002    0.8347  2.400E-001
%      5.060E-002    0.8428  2.500E-001
%      5.170E-002    0.8483  2.590E-001
%      5.280E-002    0.8505  2.680E-001
%      5.390E-002    0.8497  2.790E-001
%   :
%   :
%   The first column is wavelength (micro meter), the second column is the
%   real part of the optical constant of H2O, and the third is the
%   imaginary part of the optical constant.
%   
%    Input Parameters 
%      filepath to 'IOP_2008_ASCIItable.dat'
%    Output Parameters
%      spc: struct having three fields
%             'wavelength'
%             'm_re'
%             'm_im'
%      units: struct having three fields
%             'wavelength: 'micro meter'
%             'm_re': '' (unitless)
%             'm_im': '' (unitless)


fid = fopen(filePath,'r');

flg=1;

data = [];
flg_data = 1;
while flg_data
    line = fgetl(fid);
    if line == -1
        flg_data=0;
    else
        ld = strtrim(line);
        if ~isempty(ld)
            ld = regexp(ld,'\s+','split');
            ld = cellfun(@(x) str2double(x),ld);
            data = [data;ld];
        end
    end
end

fclose(fid);

spc = struct('wavelength',deal(num2cell(data(:,1))),...
             'm_re',deal(num2cell(data(:,2))),...
             'm_im',deal(num2cell(data(:,3))));
 
units = struct('wavelength','micro meter',...
               'm_re','',...
               'm_im','');
end

