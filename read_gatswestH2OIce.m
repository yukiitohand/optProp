function [ spc,units ] = read_gatswestH2OIce( filePath )
% [ spc,units ] = read_gatswestH2OIce( filePath )
%   Read the optical constants of H2O ice summarized at
%     http://gwest.gats-inc.com/ice_index/Ice_Refractive_Index.html
%   The format is something like:
%         Ice refractive index from Mastrapa et al., Icarus, doi:10.1016/j.icarus.2008.04.008 (2008)
%         150 K temperature, ice Ic
% 
% 
% 
% 
%         Wavelength (microns) 	 real  imaginary
%            1.1111962e+00   1.3126996e+00   1.0541223e-08
%            1.1113154e+00   1.3126978e+00   1.0542353e-08
%            1.1114346e+00   1.3126960e+00   1.0543484e-08
%            1.1115538e+00   1.3126943e+00   1.0544615e-08
%            1.1116730e+00   1.3126925e+00   1.0545746e-08
%            1.1117923e+00   1.3126907e+00   1.0546878e-08
%            1.1119117e+00   1.3126889e+00   1.0548009e-08
%            1.1120309e+00   1.3126872e+00   1.0549141e-08
%            1.1121503e+00   1.3126854e+00   1.0550273e-08
%            1.1122696e+00   1.3126836e+00   1.0551406e-08
%                :
%                :
%   
%    Input Parameters 
%      filepath to text file 
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
fgetl(fid); 
for i=1:7
    fgetl(fid); % skip the header (7 lines)
end

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