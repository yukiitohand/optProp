function [ spc,units ] = readWarren1986CO2Ice( filePath )
% [ spc,units ] = readWarren21986CO2Ice( filePath )
%   Read the optical constants of CO2 ice published in [Warren 1986]
%   Data will be something like
%     # Optical constants of carbon dioxide ice
%     # Stephen G. Warren, "Optical constants of carbon dioxide ice," Applied Optics, vol. 25, no. 16, pp. 2650-2674, 1986
%     # downloaded from https://www.osapublishing.org/ao/abstract.cfm?uri=ao-25-16-2650#articleTables by Yuki Itoh
% 
%     # Wavelength(um)	m_re	m_im
%     5.2000E?2	0.509	1.16E?1
%     5.3000E?2	0.493	1.84E?1
%     5.4100E?2	0.489	2.61E?1
%     5.5100E?2	0.501	3.28E?1
%     5.6400E?2	0.539	4.21E?1
%     5.7400E?2	0.598	4.81E?1
%     5.7900E?2	0.636	4.99E?1
%     5.8500E?2	0.682	5.13E?1
%     5.9000E?2	0.720	5.13E?1
%     5.9500E?2	0.752	5.12E?1
%     6.0200E?2	0.797	5.05E?1
%     6.2000E?2	0.869	4.48E?1
%     6.2600E?2	0.880	4.28E?1
%     6.3300E?2	0.884	4.09E?1
%     6.5300E?2	0.885	3.73E?1
%     6.7000E?2	0.870	3.52E?1
%     6.8500E?2	0.858	3.55E?1
%      :
%      :
%   
%    Input Parameters 
%      filepath to 'optical_constants_CO2.txt'
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
        if isempty(regexp(ld,'^#.*','once')) % skip comments
            if ~isempty(ld)
                ld = regexp(ld,'\s+','split');
                ld = cellfun(@(x) str2double(x),ld);
                if length(ld)==2
                    ld = [ld NaN];
                end
                data = [data;ld];
            end
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