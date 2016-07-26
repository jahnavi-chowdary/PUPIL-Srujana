function finish_test(~, ~, val)
% A simple function to update the value of the global variable record,
% which is read by the process_videos_func callback function which is
% called every time the preview window updates. This will tell it to start
% and stop the test.

display('STOP Record')
global record;
global arduino;
global stop;
global area_pupil_left;
global area_pupil_right;
global time_left;
global time_right
global im_left;
global im_right;
global tstampstr_left;
global tstampstr_right;

record = 0;
stop = str2num(val);

fprintf(arduino, 'x') ;

tic

% figure('Name','Left Pupil')
area_of_pupil_left(im_left);
% close('Left Pupil')

% figure('Name','Right Pupil')
area_of_pupil_right(im_right);
% close('Right Pupil')

time_left = time_left - time_left(1,1);
time_right = time_right - time_right(1,1);

imrightsize = size(im_right)
time_r = size(time_right);

imleftsize = size(im_left)
time_l = size(time_left);

assignin('base', 'im_left', im_left);
assignin('base', 'im_right', im_right);
assignin('base','tstampstr_right',tstampstr_right);
assignin('base','tstampstr_left',tstampstr_left);

ys = smooth(time_left,area_pupil_left,0.1,'rloess'); % This is used to smooth the curve for better visibility
figure ;
plot(time_left,ys,'b')
hold on
ys = smooth(time_right,area_pupil_right,0.1,'rloess'); % This is used to smooth the curve for better visibility
plot(time_right,ys,'r')
legend('OS','OD')
hold on
xlabel('Time in ms');
ylabel('Radius in pixels')
    
assignin('base', 'area_pupil_left', area_pupil_left);
assignin('base', 'area_pupil_right', area_pupil_right);
assignin('base','time_left',time_left);
assignin('base','time_right',time_right);

msgbox('Analyze the Plot : If satisfactory -> Exit the Plot and Click on "Save Test" , Else -> Exit the Plot and Click on "Cancel Test" ');

toc;

end