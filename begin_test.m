function begin_test(~, ~, val)
% A simple function to update the value of the global variable record,
% which is read by the process_videos_func callback function which is
% called every time the preview window updates. This will tell it to start
% and stop the test.

global area_pupil_right;
global area_pupil_left;
global time_right;
global time_left;
global record;
global arduino;
global stop;
global im_left;
global im_right;
global tstampstr_left;
global tstampstr_right;

im_left = [];
im_right = [];
tstampstr_left = [];
tstampstr_right = [];

area_pupil_right = [];
area_pupil_left = [];
time_left = [];
time_right = [];

display('DO Record')

stop = 0;
record = str2num(val);

fprintf(arduino, 's');
