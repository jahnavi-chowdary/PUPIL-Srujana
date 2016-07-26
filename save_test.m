function save_test()

area_pupil_left = evalin('base', 'area_pupil_left');
area_pupil_right = evalin('base', 'area_pupil_right');
time_left = evalin('base','time_left');
time_right = evalin('base','time_right');

%% Displaying the plot

ys = smooth(time_left,sqrt(area_pupil_left./pi),0.1,'rloess'); % This is used to smooth the curve for better visibility
figure ;
plot(time_left,ys,'b')
hold on
ys = smooth(time_right,sqrt(area_pupil_right./pi),0.1,'rloess'); % This is used to smooth the curve for better visibility
plot(time_right,ys,'r')
legend('OS','OD')
hold on
xlabel('Time in ms');
ylabel('Radius in pixels')

%% Saving the Areas and Times into CSV Files

dlmwrite('./Area_SOL_Time_CSV/RawAreas_Left.csv',area_pupil_left,'-append');
dlmwrite('./Area_SOL_Time_CSV/RawSize_Left.csv',size(area_pupil_left,2),'-append');
dlmwrite('./Area_SOL_Time_CSV/RawTimes_Left.csv',time_left,'-append');

dlmwrite('./Area_SOL_Time_CSV/RawAreas_Right.csv',area_pupil_right,'-append');
dlmwrite('./Area_SOL_Time_CSV/RawSize_Right.csv',size(area_pupil_right,2),'-append');
dlmwrite('./Area_SOL_Time_CSV/RawTimes_Right.csv',time_right,'-append');

%% Calculating the Areas for the 3 sets of illumunation separately and saving them in CSV Files

l_area = area_pupil_left;
r_area = area_pupil_right;

l_time = time_left;
r_time = time_right;

xql = 0:100:max(l_time);
xqr = 0:100:max(r_time);
m = min(length(xql), length(xqr));

% If the lengths don't match, insert zeros
if length(xql) ~= m
    xql = xql(1,1:m);
elseif length(xqr) ~= m
    xqr = xqr(1,1:m);
end

% Interpolation

vq2l = interp1(l_time',l_area',xql,'linear');
vq2r = interp1(r_time',r_area',xqr,'linear');

Get3SetsOfAreas(l_time,r_time,(sqrt(l_area./pi)),(sqrt(r_area./pi)));

display('3 Sets of Areas Calculation Completed!!!')

%% Calculating and saving the Coefficients of the 6th degree polynomial fit to the data

% feature_vector_450 = [vq2l(1,1:225) vq2r(1,1:225)];

% dlmwrite('./Final_XY_Vectors/FeatureVector_X_450.csv',feature_vector_450,'-append');

feature_vector_14 = GetThetas();

display('Feature Vector(14) calculation completed!!!');

%% Saving the Label

GroundTruth = evalin('base','GroundTruth');
dlmwrite('./Final_XY_Vectors/Labels_Y.csv',GroundTruth,'-append');
display('Label saved!!!')

%% Saving the Plot

F = getframe(gcf);
Image = F.cdata;
plot_area = Image;
mr_no = evalin('base','mr_no');
attempt = evalin('base','attempt');

fname_plot = strcat(mr_no,'_',num2str(attempt),'_plot','.jpg');
imwrite(plot_area,fullfile('./Plots',fname_plot));
display('Plot Saved!!!')
close;

%% Saving Patient's Data into Excel

existing_worksheet_data = evalin('base','existing_worksheet_data');

first_name = evalin('base', 'first_name');
last_name = evalin('base', 'last_name');
age = evalin('base', 'age');
gender = evalin('base', 'gender');
rapd_notes = evalin('base', 'rapd_notes');
mr_no = evalin('base', 'mr_no');
os = evalin('base', 'os');
od = evalin('base', 'od');

patient_data = [{first_name} {last_name} attempt {age} gender(1) {rapd_notes} mr_no os od];
strcat('A', num2str(existing_worksheet_data + 1));
xlswrite(strcat('PatientData', '.xls'), patient_data, 'Sheet1', strcat('A', num2str(existing_worksheet_data + 1)));

%%  Saving the Videos Separately

im_left = evalin('base','im_left');
im_right = evalin('base','im_right');
tstampstr_left = evalin('base','tstampstr_left');
tstampstr_right = evalin('base','tstampstr_right');

getvideo(im_left,im_right,tstampstr_left,tstampstr_right);
% if ~exist('./Plots','dir')
%     mkdir('./Plots');
% end

%% Saving Left and Right Concatenated Videos

video_filename_left = strcat(mr_no,'_',num2str(attempt),'_left.avi');
video_filename_right = strcat(mr_no,'_',num2str(attempt),'_right.avi');
    
vid1 = VideoReader(fullfile('./Videos',video_filename_left));
vid2 = VideoReader(fullfile('./Videos',video_filename_right));

play2videos(vid1,vid2)


%% Generating and saving the Report

GetReport(l_time,r_time,(sqrt(l_area./pi)),(sqrt(r_area./pi)),fname_plot);

display('CURRENT DATA COLLECTION COMPLETED!!!')

end