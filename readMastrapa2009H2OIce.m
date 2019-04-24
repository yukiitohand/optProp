function [ spc,units ] = readMastrapa2009H2OIce( filePath )
% [ spc,units ] = readMastrapa2009H2OIce( filePath )
%   Read the optical constants of H2O ice published in [Mastrapa et al., 2009]
%   Mastrapa, R. M., Sandford, S. A., Roush, T. L., Cruikshank, D. P., & 
%   Dalle Ore, C. M. (2009). Optical Constants of H_2O-Ice. 
%   The Astrophysical Journal, 701, 1347?1356.
%   The text file is something like
%     #Starting index of refraction:       1.32000
%     #Wavelength (um)       n           k
%            1.1111962       1.3126489   1.0541223e-08
%            1.1113154       1.3126471   1.0542353e-08
%            1.1114346       1.3126453   1.0543484e-08
%            1.1115538       1.3126435   1.0544615e-08
%            1.1116730       1.3126417   1.0545746e-08
%            1.1117923       1.3126399   1.0546878e-08
%            1.1119116       1.3126381   1.0548009e-08
%            1.1120309       1.3126363   1.0549141e-08
%            1.1121503       1.3126345   1.0550273e-08
%                :
%                :
%   The first column is wavelength (micro meter), "n" is the
%   real part of the optical constant of H2O, and "k" is the
%   imaginary part of the optical constant.
%   
%    Input Parameters 
%      filepath to text file in the folder "h2o_nk"
%    Output Parameters
%      spc: struct having three fields
%             'wavelength'
%             'n'
%             'k'
%      units: struct having three fields
%             'wavelength: 'micro meter'
%             'n': '' (unitless)
%             'k': '' (unitless)


fid = fopen(filePath,'r');
fgetl(fid); fgetl(fid); % skipp the header
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
             'n',deal(num2cell(data(:,2))),...
             'k',deal(num2cell(data(:,3))));
 
units = struct('wavelength','micro meter',...
               'n','',...
               'k','');
end