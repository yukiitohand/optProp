function [ spc,units ] = readHansen2005CO2Ice( filePath )
% [ spc ] = readHansen2005CO2Ice( filePath )
%   Read abosorption coefficient of CO2 ice stored published with
%   Hansen, G. B. (2005). Ultraviolet to near-infrared absorption spectrum 
%   of carbon dioxide ice from 0.174 to 1.8 ?m. Journal of Geophysical 
%   Research, 110(E11), E11003. http://doi.org/10.1029/2005JE002531
%   
%   The data is something like:
%   Wavel(µm)	Waven(cm-1)	  Absorp(m-1)	Minimum(m-1)	Maximum(m-1)
% 	0.174000	57471.264     3.8023e+003     1.9455e+003     4.0000e+003
% 	0.174125	57430.007     3.2915e+003     1.9243e+003     4.0000e+003
% 	0.174250	57388.809     2.7922e+003     1.8715e+003     4.0000e+003
% 	0.174375	57347.670     2.4327e+003     1.7943e+003     4.0000e+003
% 	0.174500	57306.590     2.1508e+003     1.6985e+003     4.0000e+003
% 	0.174625	57265.569     1.9325e+003     1.5985e+003     3.4348e+003
% 	0.174750	57224.607     1.7557e+003     1.5001e+003     2.3062e+003
% 	0.175000	57142.857     1.4949e+003     1.3281e+003     1.7471e+003
% 	0.175250	57061.341     1.3167e+003     1.1943e+003     1.4791e+003
% 	0.175500	56980.057     1.1803e+003     1.0846e+003     1.2989e+003
% 	0.175750	56899.004     1.0715e+003     9.9305e+002     1.1645e+003
% 	0.176000	56818.182     9.7987e+002     9.1375e+002     1.0561e+003
% 	0.176250	56737.589     8.9671e+002     8.4018e+002     9.6046e+002
% 	0.176500	56657.224     8.1919e+002     7.7100e+002     8.7243e+002
% 	0.176750	56577.086     7.4627e+002     7.0463e+002     7.9143e+002
%   :
%   :
% 
%    Input Parameters 
%      filepath to 'jgre2052-sup-0002-abscoeff.txt'
%    Output Parameters
%      spc: struct having five fields
%             'wavelength'
%             'waveNumber'
%             'abscoeff'
%             'min_abscoeff'
%             'max_abscoeff'
%
%      units: struct
%             'wavelength','micro meter'
%             'waveNumber','1/cm'
%             'abscoeff','1/m'
%             'min_abscoeff','1/m'
%             'max_abscoeff','1/m'

fid = fopen(filePath,'r');

flg=1;
% read headers
line = fgetl(fid);
% param = {'wavelength','waveNumber','abscoeff','min_abscoeff','max_abscoeff'};
% units = {'micro meter','1/cm','1/m','1/m','1/m'};

% read data
data = [];
flg_data = 1;
while flg_data
    line = fgetl(fid);
    if line == -1
        flg_data=0;
    else
        ld = strtrim(line);
        ld = regexp(ld,'\s+','split');
        ld = cellfun(@(x) str2double(x),ld);
        data = [data;ld];
    end
end

fclose(fid);

spc = struct('wavelength',deal(num2cell(data(:,1))),...
             'waveNumber',deal(num2cell(data(:,2))),...
             'abscoeff',deal(num2cell(data(:,3))),...
             'min_abscoeff',deal(num2cell(data(:,4))),...
             'max_abscoeff',deal(num2cell(data(:,5))));
 
units = struct('wavelength','micro meter',...
               'waveNumber','1/cm',...
               'abscoeff','1/m',...
               'min_abscoeff','1/m',...
               'max_abscoeff','1/m');

end

