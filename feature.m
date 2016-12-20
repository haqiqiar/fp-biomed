fix = [];
data=[];
for i =1:25
    for j = 1:length(avq(1,:))
        data = [avq(j), avr(j), avs(j), axq(j), axr(j), axs(j), ecg_class(i)];
        fix=[fix;data];
    end
    
end