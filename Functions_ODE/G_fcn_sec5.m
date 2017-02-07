function G = G_fcn_sec5(in1)
%G_FCN_SEC5
%    G = G_FCN_SEC5(IN1)

%    This function was generated by the Symbolic Math Toolbox version 7.0.
%    11-Sep-2016 09:46:52

xd1 = in1(3,:);
xd2 = in1(7,:);
xd3 = in1(11,:);
xd4 = in1(15,:);
xd5 = in1(19,:);
xd6 = in1(23,:);
xv1 = in1(1,:);
xv2 = in1(5,:);
xv3 = in1(9,:);
xv4 = in1(13,:);
xv5 = in1(17,:);
xv6 = in1(21,:);
yd1 = in1(4,:);
yd2 = in1(8,:);
yd3 = in1(12,:);
yd4 = in1(16,:);
yd5 = in1(20,:);
yd6 = in1(24,:);
yv1 = in1(2,:);
yv2 = in1(6,:);
yv3 = in1(10,:);
yv4 = in1(14,:);
yv5 = in1(18,:);
yv6 = in1(22,:);
G = reshape([-yd1+yv2,0.0,0.0,0.0,0.0,1.0,0.0,0.0,xd1-xv2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-yd2+yv1,0.0,0.0,0.0,0.0,0.0,1.0,0.0,xd2-xv1,0.0,0.0,0.0,0.0,0.0,0.0,1.0,yd2-yv1,-yd2+yv3,0.0,0.0,0.0,0.0,0.0,0.0,-xd2+xv1,xd2-xv3,0.0,0.0,0.0,0.0,0.0,0.0,yd1-yv2,-yd3+yv2,0.0,0.0,0.0,0.0,0.0,0.0,-xd1+xv2,xd3-xv2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,yd3-yv2,-yd3+yv4,0.0,0.0,0.0,0.0,0.0,0.0,-xd3+xv2,xd3-xv4,0.0,0.0,0.0,0.0,0.0,0.0,yd2-yv3,-yd4+yv3,0.0,0.0,0.0,0.0,0.0,0.0,-xd2+xv3,xd4-xv3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,yd4-yv3,-yd4+yv5,0.0,0.0,0.0,0.0,0.0,0.0,-xd4+xv3,xd4-xv5,0.0,0.0,0.0,0.0,0.0,0.0,yd3-yv4,-yd5+yv4,0.0,0.0,0.0,0.0,0.0,0.0,-xd3+xv4,xd5-xv4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,yd5-yv4,-yd5+yv6,0.0,0.0,0.0,0.0,0.0,0.0,-xd5+xv4,xd5-xv6,0.0,0.0,0.0,0.0,0.0,0.0,yd4-yv5,-yd6+yv5,0.0,0.0,0.0,0.0,0.0,0.0,-xd4+xv5,xd6-xv5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,yd6-yv5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-xd6+xv5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,yd5-yv6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-xd5+xv6,0.0,0.0,0.0],[8,24]);