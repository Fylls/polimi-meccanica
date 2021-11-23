function [mag,ang]=vecangle(vec)

ang=atan2(vec(:,2),vec(:,1));
mag=sqrt(vec(:,2).^2+vec(:,1).^2+vec(:,3).^2);