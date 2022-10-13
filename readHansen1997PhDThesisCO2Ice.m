function [ spc,units ] = readHansen1997PhDThesisCO2Ice( filePath )
% [ spc ] = readHansen1997PhDThesisCO2Ice( filePath )
%   Read absorption coefficient of CO2 ice published in 
%   Hansen, G. B. (1996). The infrared absorption spectrum of carbon 
%   dioxide ice. PhD thesis, University of Washington, Seattle.
%   The file is something like:
%      30.00 333.33333 1.0315E+0 1.8003E+2 0
%      32.00 312.50000 4.1723E+0 9.1496E+1 0
%      33.00 303.03030 7.8942E+0 7.5901E+1 0 
%      34.00 294.11765 1.4735E+1 7.3869E+1 0
%      35.00 285.71429 2.5418E+1 7.9070E+1 1.3005E+0
%      36.00 277.77778 3.9137E+1 8.9449E+1 9.2808E+0
%      37.00 270.27027 5.3471E+1 1.0204E+2 2.4623E+1
%      38.00 263.15789 6.6434E+1 1.1539E+2 3.8200E+1
%      40.00 250.00000 9.2004E+1 1.4538E+2 6.1789E+1
%      44.00 227.27273 1.6713E+2 2.1454E+2 1.3135E+2
%      46.00 217.39130 2.2180E+2 2.6771E+2 1.8563E+2
%      48.00 208.33333 2.8151E+2 3.2691E+2 2.3715E+2
%        :
%        :
%
%    Labels for the columns are 
%    'waveNumber','wavelength','abscoeff','min_abscoeff','max_abscoeff'
%
%    The units will be 
%    '1/cm','micro meter','1/m','1/m','1/m'
% 
%    Input Parameters 
%      filepath to 'co2_hansen_phdthesis_all.txt'
%    Output Parameters
%      spc: struct having five fields
%             'wavelength'
%             'waveNumber'
%             'abscoeff'
%             'min_abscoeff'
%             'max_abscoeff'
%
%      units:struct having five fields
%             'wavelength': 'micro meter'
%             'waveNumber': '1/cm'
%             'abscoeff': '1/m'
%             'min_abscoeff': '1/m'
%             'max_abscoeff': '1/m'
%

fid = fopen(filePath,'r');

flg=1;
% read headers
% line = fgetl(fid);

% read data
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

spc = struct('waveNumber',deal(num2cell(data(:,1))),...
             'wavelength',deal(num2cell(data(:,2))),...
             'abscoeff',deal(num2cell(data(:,3))),...
             'max_abscoeff',deal(num2cell(data(:,4))),...
             'min_abscoeff',deal(num2cell(data(:,5))));
 
units = struct('waveNumber','1/cm',...
             'wavelength','micro meter',...
             'abscoeff','1/m',...
             'max_abscoeff','1/m',...
             'min_abscoeff','1/m');

end