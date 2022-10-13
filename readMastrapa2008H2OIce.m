function [ spc,units ] = readMastrapa2008H2OIce( filePath )
% [ spc,units ] = readMastrapa2008H2OIce( filePath )
%   Read the optical constants of H2O ice published in [Mastrapa et al., 2008]
%   Mastrapa, R. M., Bernstein, M. P., Standford, S. A., Roush, 
%   T. L., Cruikshank, D. P., & Dalle Ore, C. M. (2008). Optical constants 
%   of amorphous and crystalline H2O-ice in the near infrared from 1.1 to 
%   2.6 ?m. Icarus, 197(1), 307?320.
%   The text file is something like
%        # Crystalline H2O-ice at 100 K, R. M. Mastrapa
%        # Ice thickness used (cm): d =0.5
%        # Initial n value used: n = 1.32
%        # Final n value derived: n = 1.3215602940361271
%        # Number of iterations: i = 14
%        # Wavelength (microns) 	 n 	 k 	 T
%        1.111132	1.319904	9.075415e-07	9.499723e-01
%        1.111191	1.319904	6.911981e-07	9.616681e-01
%        1.111251	1.319905	1.769000e-13	1.000000e+00
%        1.111310	1.319904	1.769000e-13	1.000000e+00
%        1.111370	1.319904	1.897637e-07	9.893283e-01
%        1.111429	1.319904	4.933006e-07	9.724961e-01
%        1.111489	1.319904	6.314445e-07	9.649323e-01
%        1.111548	1.319904	5.782175e-07	9.678419e-01
%        1.111608	1.319904	6.630638e-07	9.632128e-01
%        1.111668	1.319905	4.730001e-07	9.736185e-01
%                :
%                :
%   The first column is wavelength (micro meter), "n" is the
%   real part of the optical constant of H2O, and "k" is the
%   imaginary part of the optical constant. "T" is the transmittance
%   specttrum.
%   
%    Input Parameters 
%      filepath to text file in the folder "h2o_nk"
%    Output Parameters
%      spc: struct having four fields
%             'wavelength'
%             'n'
%             'k'
%             'T'
%      units: struct having four fields
%             'wavelength: 'micro meter'
%             'n': '' (unitless)
%             'k': '' (unitless)
%             'T': ''


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
        if isempty(regexp(ld,'^#.*','once')) % skip comments
            if ~isempty(ld)
                ld = regexp(ld,'\s+','split');
                ld = cellfun(@(x) str2double(x),ld);
                data = [data;ld];
            end
        end
    end
end

fclose(fid);

spc = struct('wavelength',deal(num2cell(data(:,1))),...
             'n',deal(num2cell(data(:,2))),...
             'k',deal(num2cell(data(:,3))),...
             'T',deal(num2cell(data(:,4))));
 
units = struct('wavelength','micro meter',...
               'n','',...
               'k','',...
               'T','');
end