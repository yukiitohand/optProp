function [ spc ] = GhoSSTread( filePath )
% [ spc ] = GhoSSTread( filePath )
%   Read data stored in the exported file from GhoSST database
%     http://ghosst.obs.ujf-grenoble.fr

%  Input Parameters
%     filePath: path to the text-file, '*.data.ascii'
%  Output Parameters
%     spc: struct, having fields
%         'data': struct, table data in the file (field names are defined
%                 by its headers with spaces replaced with "-" and with
%                 "(*)" removed (considered as units
%                 e.g. Wavelength (µm) --> Wavelength
%                      n index --> n_index
%         other fields are basically meta-information stored in the text
%         file.
%         "wavelength_unit" is also added
%
%   The format is like
%
%     file_name="optcte-NIR-CO2cr-179-28K"
%     file_title="NIR Optical constants spectrum of CO2 crystal at 179 K completed with 28K data"
%     file_type="single spectrum"
%     spectrum_type="optical constants"
%     spectrum_uid="SPECTRUM_BS_20130215_001"
%     experiment_uid="EXPERIMENT_BS_20130215_001"
%     sample_uid="SAMPLE_BS_20130215_001"
%     date_created="2006-01-26"
%     date_last_updated="2014-08-10"
%     date_validated="2006-01-26"
%     validators_name="Bernard Schmitt"
%     history="2013-02-15: new CO2 optical constants spectrum at 179K (NIR)"
%     analysis="The imaginary part 'k' of the optical constants is derived from the absorption coefficients of Quirico et al. 1997a (Fig. 6). k values < 1e-4 come from a crystal (1 cm) at 179 K, k > 1e-4 (i.e. major bands < 5100 cm-1) are derived from thin films at 28 K. Very weak k values < 3e-8 between weak bands (above 5500 cm-1) are interpolated. The real part 'n' come from the visible value (with n = 1.43 @ 15800cm-1)"
%     quality_flag="3"
%     comments="composite k spectrum at 2 different temperatures (179K and 28K) and n spectrum at 15K. But only small band shifts (< 4 cm-1) are observed in main peaks. Waiting higher temperature thin film data!"
%
%     Wavelength (µm)	n index	k index	Error n	Error k	Quality n	Quality k
%         5.40418	 1.42280e+0	 3.23969e-6	 0.00000e+0	 0.00000e+0		
%         5.40277	 1.42277e+0	 3.35938e-6	 0.00000e+0	 0.00000e+0		

spc = [];

fid = fopen(filePath,'r','n','UTF-8');
flg=1;
% read meta information
while flg
    line = fgetl(fid);
    if line == -1
        flg=0;
    else
        eqsn = findstr(line,'=');
        if ~isempty(eqsn)
            param = strtrim(line(1:eqsn-1));
            value = rmdq(strtrim(line(eqsn+1:end)));
            spc.(param) = value;
        else
            flg = 0;
        end
    end
end

% read header
line = fgetl(fid);
hdrs = strtrim(line);
hdrs = strsplit(hdrs,'\t');
nCol = length(hdrs);
for i=1:nCol
    hdrs{i} = strtrim(hdrs{i});
    if ~isempty(regexpi(hdrs{i},'wavelength'))
        data_stru = hdrs{i};
        hdrs{i} = 'Wavelength';
        unit = regexpi(data_stru,'.*\((.*)\)','tokens');
        unit = unit{1}{1};
        spc.wavelength_unit = unit;
    else
        hdrs{i} = regexprep(strtrim(hdrs{i}),'','_');
        hdrs{i} = regexprep(strtrim(hdrs{i}),'[^a-zA-Z_0-9]','_');
    end
end

% read data
data = [];
flg_data = 1;
while flg_data
    line = fgetl(fid);
    if line == -1
        flg_data=0;
    else
        ld = strsplit(line,'\t','CollapseDelimiters',false);
        ld = cellfun(@(x) str2double(x),ld);
        data = [data;ld];
    end
end

fclose(fid);

data_stru = struct(hdrs{1},deal(num2cell(data(:,1))));
for i=2:nCol
    data_i = num2cell(data(:,i));
    [data_stru.(hdrs{i})] = deal(data_i{:});
end

spc.data = data_stru;

% for i=1:nCol
%     spc.(hdrs{i}) = data(:,i);
% end


end

