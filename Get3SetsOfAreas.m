function Get3SetsOfAreas_Final(l_t,r_t,l,r)

% This function calculates the areas, timestamps of the 3 Sets of Tests Individually. 

% l_t , r_t -> 'RAW TIMES'
% l , r -> 'RAW RADIUS'

l_ti = l_t; % l_ti,r_ti has raw time values
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

%% Uncomment the following inorder to view the plot

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
ite = 1;

for k = 1:4:12
    k;
    
    % figure
    % ys = smooth(time_left,area_pupil_left,0.1,'rloess');
    % plot(time_left,ys,'r')
    % title('Left 1st Set')
    % hold on
    
    q = abs(p-(3000 * k));
    r = abs(p-(3000 * (k+4)));
    [start_val, start_ind_l] = min(q);
    [last_val, last_ind_l] = min(r);
    start_l = tmp_max_l(start_ind_l);
    last_l = tmp_max_l(last_ind_l);
    time_left_l = time_left(1,start_l:last_l);
    ys_l = ys(start_l:last_l,1);
    
    l_area = ys_l;
    l_time = time_left_l;
    % l_time_diff = mean(diff(l_time));
    l_time_norm = time_left_l - time_left_l(1,1);
    
    xql = 0:100:max(l_time_norm);
    
    % Interpolation
    
    vq2l = interp1(l_time_norm',l_area',xql,'linear');
    
    if size(vq2l,2) < 110
        vq2l(1,(size(vq2l,2)+1:110)) = vq2l(1,size(vq2l,2));
    end
    
    vq2l = vq2l(1:110);
    
    % area_val_l = [area_val_l;vq2l];
    % time_size_l = [time_size_l,size(xql,2)];
    % area_size_l = [area_size_l,l_time_diff];
    
    dlmwrite(strcat('Area_Size_Time_Cut_CSV\',num2str(ite),'\RawRadius_Left.csv'),l_area','-append');
    dlmwrite(strcat('Area_Size_Time_Cut_CSV\',num2str(ite),'\RawTimes_Left.csv'),time_left_l,'-append');
    dlmwrite(strcat('Area_Size_Time_Cut_CSV\',num2str(ite),'\InterpolatedRadius_Left.csv'),vq2l,'-append');
    dlmwrite(strcat('Area_Size_Time_Cut_CSV\',num2str(ite),'\RawSizes_Left.csv'),size(l_time,2),'-append');
    
    ite = ite+1;
    
    % plot(time_left(1,start_l),ys(start_l,1),'y*');
    % hold on
    % plot(time_left(1,last_l),ys(last_l,1),'y*');
    % hold off
    
    clear q r time_left_l ys_l l_area l_time xql vq2l
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

ite = 1;
for k = 1:4:12
    k;
    
    % figure
    % ys = smooth(time_right,area_pupil_right,0.1,'rloess');
    % plot(time_right,ys,'b')
    % title('Left 1st Set')
    % hold on
    
    q = abs(p-(3000 * k));
    r = abs(p-(3000 * (k+4)));
    [start_val, start_ind_r] = min(q);
    [last_val, last_ind_r] = min(r);
    start_r = tmp_max_r(start_ind_r);
    last_r = tmp_max_r(last_ind_r);
    time_right_r = time_right(1,start_r:last_r);
    ys_r = ys(start_r:last_r,1);
    
    r_area = ys_r;
    r_time = time_right_r;
    % r_time_diff = mean(diff(r_time));
    r_time_norm = time_right_r - time_right_r(1,1);
    
    xqr = 0:100:max(r_time_norm);
    
    % Interpolation
    
    vq2r = interp1(r_time_norm',r_area',xqr,'linear');
    
    if size(vq2r,2) < 110
        vq2r(1,(size(vq2r,2)+1:110)) = vq2r(1,size(vq2r,2));
    end
    
    vq2r = vq2r(1:110);
    
    % area_val_r = [area_val_r;vq2r];
    % time_size_r = [time_size_r,size(xqr,2)];
    % area_size_r = [area_size_r,r_time_diff];
    
    dlmwrite(strcat('Area_Size_Time_Cut_CSV\',num2str(ite),'\InterpolatedRadius_Right.csv'),vq2r,'-append');
    dlmwrite(strcat('Area_Size_Time_Cut_CSV\',num2str(ite),'\RawRadius_Right.csv'),r_area','-append');
    dlmwrite(strcat('Area_Size_Time_Cut_CSV\',num2str(ite),'\RawTimes_Right.csv'),time_right_r,'-append');
    dlmwrite(strcat('Area_Size_Time_Cut_CSV\',num2str(ite),'\RawSizes_Right.csv'),size(r_time,2),'-append');
    
    ite = ite+1;
    
    % plot(time_right(1,start_r),ys(start_r,1),'y*');
    % hold on
    % plot(time_right(1,last_r),ys(last_r,1),'y*');
    % hold off
    
    clear q r time_right_r ys_r r_area r_time xqr vq2r
    
end
end



