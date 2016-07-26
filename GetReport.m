function GetReport_Final(l_t,r_t,l,r,fname_plot)

% This function calculates the following parameters which are saved in the Report.
% Baseline Radius, Minimum Radius, Change Percentage, Constriction Time, Recovery Time for the 6 States (OS1,OD1,OS2,OD2,OS3,OD3). 

display('Saving Report...')

import mlreportgen.dom.*

rpt_type = 'docx';

mr_no = evalin('base','mr_no');
first_name = evalin('base','first_name');
last_name = evalin('base','last_name');
age = evalin('base','age');
gender = evalin('base','gender');
attempt = evalin('base','attempt');
existing_worksheet_data1 = evalin('base','existing_worksheet_data1');
s_no = existing_worksheet_data1;

% l_t = l_time;
% r_t = r_time;
% l = sqrt(l_area./pi);
% r = sqrt(r_area./pi);

l_ti = l_t;
r_ti = r_t;

l_time = l_ti(l_ti<39000);
r_time = r_ti(r_ti<39000);

frames_removed_l = size(l_t,2) - size(l_time,2);
frames_removed_r = size(r_t,2) - size(r_time,2);

l_area = l((frames_removed_l+1):(frames_removed_l+size(l_time,2)));
r_area = r((frames_removed_r+1):(frames_removed_r+size(r_time,2)));

time_left = l_time;
time_right = r_time;
area_pupil_left = l_area;
area_pupil_right = r_area;
% area_pupil_left = sqrt(area_pupil_left./pi);
% area_pupil_right = sqrt(area_pupil_right./pi);

% ys = smooth(time_left,area_pupil_left,0.1,'rloess'); % This is used to smooth the curve for better visibility
% figure ;
% plot(time_left,ys,'b')
% hold on
% ys = smooth(time_right,area_pupil_right,0.1,'rloess'); % This is used to smooth the curve for better visibility
% plot(time_right,ys,'r')
% legend('OS','OD')
% hold on
% xlabel('Time in ms');
% ylabel('Radius in pixels')


%% ------------------------- For Left Eye ------------------------------

% figure
ys = smooth(time_left,area_pupil_left,0.1,'rloess');
% plot(time_left,ys,'r')
% title('Radius of Left Pupil with Time')
[ymax_l,imax_l,ymin_l,imin_l] = extrema(ys);
% hold on
% plot(time_left(imax_l),ymax_l,'k*',time_left(imin_l),ymin_l,'g*')
% hold off

[tmp_max_l, ind_max_l] = sort(imax_l);
p = time_left(tmp_max_l);

[tmp_min_l, ind_min_l] = sort(imin_l);
t = time_left(tmp_min_l);

for k = 1:12
    k;
    if mod(k,2)== 1
        
        % figure
        % ys = smooth(time_left,area_pupil_left,0.1,'rloess');
        % plot(time_left,ys,'r')
        % title('Left 1st Set')
        % hold on
        
        q = abs(p-(3000 * k));
        r = abs(t-(3000 * (k+1)));
        [start_val, start_ind_l] = min(q);
        [last_val, last_ind_l] = min(r);
        start_l = tmp_max_l(start_ind_l);
        last_l = tmp_min_l(last_ind_l);
        time_left_l = time_left(1,start_l:last_l);
        ys_l = ys(start_l:last_l,1);
        
        baseline_left{1,((k+1)/2)} = num2str(max(ys_l));
        [tpp ind_maxval] = max(ys_l);
        min_value_left{1,((k+1)/2)} = num2str(min(ys_l));
        [tp ind_minval] = min(ys_l);
        per_change_left{1,((k+1)/2)} = strcat(num2str(str2num(sprintf('%.2f',((str2num(min_value_left{1,((k+1)/2)}) - (str2num(baseline_left{1,((k+1)/2)})))/str2num(baseline_left{1,((k+1)/2)}) * 100)))),'%');
        if per_change_left{1,((k+1)/2)} < 0
            per_change_left{1,((k+1)/2)} = strcat('-','');
        end
        constrict_time_left{1,((k+1)/2)} = abs(time_left(1,start_l) - time_left(1,last_l));
        
        % plot(time_left(1,start_l),(max(ys_l)),'y*');
        % hold on
        % plot(time_left(1,last_l),min(ys_l),'y*');
        % hold off
        
        clear q r time_left_l ys_l l_area l_time xql vq2l
    else
        
        % figure
        % ys = smooth(time_left,area_pupil_left,0.1,'rloess');
        % plot(time_left,ys,'r')
        % title('Left 1st Set')
        % hold on
        
        q = abs(t-(3000 * k));
        r = abs(p-(3000 * (k+1)));
        [start_val, start_ind_l] = min(q);
        [last_val, last_ind_l] = min(r);
        start_l = tmp_min_l(start_ind_l);
        last_l = tmp_max_l(last_ind_l);
        time_left_l = time_left(1,start_l:last_l);
        ys_l = ys(start_l:last_l,1);
        
        recovery_time_left{1,(k/2)} = abs(time_left(1,last_l) - time_left(1,start_l));
        
        % plot(time_left(1,start_l),(min(ys_l)),'y*');
        % hold on
        % plot(time_left(1,last_l),max(ys_l),'y*');
        % hold off
        
        clear q r time_left_l ys_l l_area l_time xql vq2l
        
    end
end
% close all

%% ------------------------- For Right Eye ------------------------------

% figure
ys = smooth(time_right,area_pupil_right,0.1,'rloess');
% plot(time_right,ys,'b')
% title('Radius of Right Pupil with Time')
[ymax_r,imax_r,ymin_r,imin_r] = extrema(ys);
% hold on
% plot(time_right(imax_r),ymax_r,'k*',time_right(imin_r),ymin_r,'g*')
% hold off

[tmp_max_r, ind_max_r] = sort(imax_r);
p = time_right(tmp_max_r);

[tmp_min_r, ind_min_r] = sort(imin_r);
t = time_right(tmp_min_r);


for k = 1:12
    k;
    if mod(k,2)== 1
        
        % figure
        % ys = smooth(time_right,area_pupil_right,0.1,'rloess');
        % plot(time_right,ys,'b')
        % title('Left 1st Set')
        % hold on
        
        q = abs(p-(3000 * k));
        r = abs(t-(3000 * (k+1)));
        [start_val, start_ind_r] = min(q);
        [last_val, last_ind_r] = min(r);
        start_r = tmp_max_r(start_ind_r);
        last_r = tmp_min_r(last_ind_r);
        time_right_r = time_right(1,start_r:last_r);
        ys_r = ys(start_r:last_r,1);
        
        baseline_right{1,((k+1)/2)} = num2str(max(ys_r));
        [tpp ind_maxval] = max(ys_r);
        min_value_right{1,((k+1)/2)} = num2str(min(ys_r));
        [tp ind_minval] = min(ys_r);
        per_change_right{1,((k+1)/2)} = strcat(num2str(str2num(sprintf('%.2f',((str2num(min_value_right{1,((k+1)/2)}) - (str2num(baseline_right{1,((k+1)/2)})))/str2num(baseline_right{1,((k+1)/2)}) * 100)))),'%');
        constrict_time_right{1,((k+1)/2)} = abs(time_right(1,start_r) - time_right(1,last_r));
        
        % plot(time_right(1,start_r),(max(ys_r)),'y*');
        % hold on
        % plot(time_right(1,last_r),min(ys_r),'y*');
        % hold off
        
        clear q r time_right_r ys_r r_area r_time xqr vq2r
    else
        % figure
        % ys = smooth(time_right,area_pupil_right,0.1,'rloess');
        % plot(time_right,ys,'b')
        % title('Left 1st Set')
        % hold on
        
        q = abs(t-(3000 * k));
        r = abs(p-(3000 * (k+1)));
        [start_val, start_ind_r] = min(q);
        [last_val, last_ind_r] = min(r);
        start_r = tmp_min_r(start_ind_r);
        last_r = tmp_max_r(last_ind_r);
        time_right_r = time_right(1,start_r:last_r);
        ys_r = ys(start_r:last_r,1);
        
        recovery_time_right{1,(k/2)} = abs(time_right(1,last_r) - time_right(1,start_r));
        
        % plot(time_right(1,start_r),(min(ys_r)),'y*');
        % hold on
        % plot(time_right(1,last_r),max(ys_r),'y*');
        % hold off
        
        clear q r time_right_r ys_r r_area r_time xqr vq2r
        
    end
end
%close all

l= [];
p = ['--------------------------'];
q = ['--------------'];

spce = {p,p,p,p,p,p};

os_data = [spce;baseline_left;min_value_left;per_change_left;constrict_time_left;recovery_time_left];
od_data = [baseline_right;min_value_right;per_change_right;constrict_time_right;recovery_time_right];

heading = {l,l,'S1 (OS)','S2 (OD)','S3 (OS)','S4 (OD)','S5 (OS)','S6 (OD)'};
side_heading = {'Baseline (px)';'Minimum Radius (px)';'Change (%)';'T1 (ms)';'T2 (ms)'};
side_heading1 = {p;'Baseline (px)';'Minimum Radius (px)';'Change (%)';'T1 (ms)';'T2 (ms)'};

od_side = {l;l;'OD';l;l};
os_side = {q;l;l;'OS';l;l};
all_od = [od_side,side_heading,od_data];
all_os = [os_side,side_heading1,os_data];

%% -------------------------- Generating Excel ------------------------ %
excel_cell_r = [];
for zz = 1:6
    excel_r = {baseline_right(1,zz), min_value_right(1,zz), per_change_right(1,zz), constrict_time_right(1,zz), recovery_time_right(1,zz)};
    excel_cell_r = [excel_cell_r , excel_r];
end

for zz = 1:30
    excel_all_r(zz) = excel_cell_r{zz};
end

excel_cell_l = [];
for zz = 1:6
    excel_l = {baseline_left(1,zz), min_value_left(1,zz), per_change_left(1,zz), constrict_time_left(1,zz), recovery_time_left(1,zz)};
    excel_cell_l = [excel_cell_l , excel_l];
end

for zz = 1:30
    excel_all_l(zz) = excel_cell_l{zz};
end
excel_final = [num2str(s_no) mr_no attempt age excel_all_r  excel_all_l];

strcat('A', num2str(existing_worksheet_data1 + 1));
xlswrite(strcat('ReportData', '.xls'), excel_final, 'Sheet1', strcat('A', num2str(existing_worksheet_data1 + 1)));
display('Details Entered Successfully into Excel')

%% -------------------------- Generating Report ---------------------- %

fname_report = strcat(mr_no,'_',num2str(attempt),'_Report');
doc = Document(fullfile('./Reports',fname_report),rpt_type); %Create an empty pdf document

%% Insert Date,Day,Time

time_date = char(datetime('now'));
DayForm = 'long';
[DayNumber,DayName] = weekday(date,DayForm);
paraObj = Paragraph(char(strcat({blanks(30)},DayName,{blanks(3)},time_date)));
paraObj.Style = {FontSize('10pt'),HAlign('right')};
append(doc, paraObj); % Append paragraph to document


%% Insert an image
imageObj = Image(which('Logo.png')); % Create an image object
% imageObj.Width = '1.5in';
% imageObj.Height = '1in';
append(doc,imageObj);

%% Add a Paragraph
paraObj = Paragraph('____________________________________________________________________________________');
append(doc, paraObj); % Append paragraph to document

%% Add a Paragraph
name = strcat(first_name,last_name);
% age = '20';
sex = gender;
% name = {blanks(10)};
% age = {blanks(10)};
% sex = {blanks(10)};
blnk = {blanks(10)};
paraObj = Paragraph(char(strcat('Name :',{blanks(1)},name,blnk,'Age :',{blanks(1)},age,blnk,'Sex :',{blanks(1)},sex)));
append(doc, paraObj); % Append paragraph to document

%% Add a Paragraph
paraObj = Paragraph('____________________________________________________________________________________');
append(doc, paraObj); % Append paragraph to document

%% Insert a table

t1 = Table(heading);
t1.Style = {RowHeight('0.16in'),FontSize('10pt'),Width('90%'),HAlign('center')};
t1.Border = 'solid';
t1.BorderWidth = '0.5pt';
t1.ColSep = 'solid';
t1.ColSepWidth = '0.5';
t1.RowSep = 'solid';
t1.RowSepWidth = '0.5';
append(doc,t1);

t2 = Table(all_od);
t2.Style = {RowHeight('0.14in'),FontSize('8pt'),Width('90%'),HAlign('center'),VAlign('bottom')};
t2.Border = 'solid';
t2.BorderWidth = '0.5pt';
t2.ColSep = 'solid';
t2.ColSepWidth = '0.5';
t2.RowSep = 'none';
t2.RowSepWidth = '0';
append(doc,t2);

t3 = Table(all_os);
t3.Style = {RowHeight('0.14in'),FontSize('8pt'),Width('90%'),HAlign('center'),VAlign('bottom')};
t3.Border = 'solid';
t3.BorderWidth = '0.5pt';
t3.ColSep = 'solid';
t3.ColSepWidth = '0.5';
% t3.RowSep = 'solid';
% t3.RowSepWidth = '0.01';
append(doc,t3);

%% Add a Paragraph
paraObj = Paragraph('____________________________________________________________________________________');
append(doc, paraObj); % Append paragraph to document

%% Insert an image
% fname_plot = '1.jpg';
% imageObj = Image(which('1.jpg')); % Create an image object
imageObj = Image(fullfile('./Plots',fname_plot));
imageObj.Width = '6in';
imageObj.Height = '3in';
append(doc,imageObj);

%% Add a Paragraph
paraObj = Paragraph('Remarks:');
append(doc, paraObj); % Append paragraph to document

% %% Footer
% footer = DOCXPageFooter();
% paraObj = Paragraph('Remarksnkbasjcviasvci:');
% append(footer, paraObj); % Append paragraph to document
% % append(doc,footer)

%% Close and view the report
close(doc); % Close the document and write to disk
try
    rptview(doc.OutputPath,'pdf'); % Open document in in-built PDF viewer
catch
    
end

display('Report Saved!!!')

% close all
end
