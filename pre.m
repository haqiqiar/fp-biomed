dirlist = dir('dataset/');
ecg_filtered = [];
ecg_class=[];
f1=5; 
f2=15;
fs = 360;
Wn=[f1 f2]*2/fs; 
N = 3; 
[a,b] = butter(N,Wn); 
kelas = 0;
for i = 1:length(dirlist)
    
    dirc = dir(strcat('dataset/', dirlist(i).name, '/*.mat'));
    for j = 1:length(dirc)
        load(strcat('dataset/', dirlist(i).name, '/', dirc(j).name));
        disp(dirc(j).name);
        switch(dirlist(i).name)
           case 'APB' 
               kelas = 1; 
           case 'LBBB'
               kelas = 2;
           case 'N' 
               kelas = 3;
           case 'PB'
               kelas = 4;
           case 'PVC'
               kelas = 5;
           case 'RBBB' 
               kelas = 6;
            
        end
        
%disp(val)
          val(1,:) = (val(1,:) - 1024)/200;
          ecg_h = filtfilt(a,b,val(1,:));
          ecg_h = ecg_h/ max( abs(ecg_h));

         %ecg = [ecg;filter(b,a,val(1,:))];
         
         ecg_filtered = [ecg_filtered;ecg_h];
         ecg_class=[ecg_class;kelas];
    end
end
disp('finding r peaks');

for i = 1:length(ecg_filtered)
    disp(i);
    nw = ecg_filtered(i,:);
    r= extract(nw, 360);
    vr=[];
    vq=[];
    vs=[];
    xr=[];
    xq=[];
    xs=[];
    
    for j = 1:length(r)
        
        rpoint = find(nw == r(j));
        if(rpoint<=300)
            left = 1;
        else
            left = rpoint-300;
        end
        if(length(nw)<=rpoint+400)
            right = length(nw);
        else
            right = rpoint+400;
        end
        q = min(nw(left:rpoint));
        s = min(nw(rpoint:right));
        vr = [vr,r];
        vq = [vq,q];
        vs = [vs,s];
        xr = [xr, rpoint];
        xq = [xq, find(nw==q)];
        xs = [xs, find(nw==s)];
        
        %[valq,q] = findpeaks(nw(left:rpoint));
        %[vals,s] = findpeaks(nw(rpoint:right));
    end
    avr(i,1: length(vr)) = vr;
    avq(i,1: length(vq)) = vq;
    avs(i,1: length(vs)) = vs;
    axr(i,1: length(xr)) = xr;
    axq(i,1: length(xq)) = xq;
    axs(i,1: length(xs)) = xs;

    
    
end


