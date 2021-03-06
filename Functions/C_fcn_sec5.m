function C = C_fcn_sec5(in1)
%C_FCN_SEC5
%    C = C_FCN_SEC5(IN1)

%    This function was generated by the Symbolic Math Toolbox version 7.0.
%    05-Sep-2016 09:39:01

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
t2 = yv1.*(1.0./2.0);
t3 = yd2.*(1.0./2.0);
t4 = xd2.*(1.0./2.0);
t5 = yv2.*(1.0./2.0);
t6 = xd1.*(1.0./2.0);
t7 = xv2.*(1.0./2.0);
t8 = yd3.*(1.0./2.0);
t9 = xd3.*(1.0./2.0);
t10 = yv3.*(1.0./2.0);
t11 = xv3.*(1.0./2.0);
t12 = yd4.*(1.0./2.0);
t13 = xd4.*(1.0./2.0);
t14 = yv4.*(1.0./2.0);
t15 = xv4.*(1.0./2.0);
t16 = yd5.*(1.0./2.0);
t17 = xd5.*(1.0./2.0);
t18 = yv5.*(1.0./2.0);
t19 = xv5.*(1.0./2.0);
t20 = xd6.*(1.0./2.0);
t21 = yv6.*(1.0./2.0);
C = reshape([t5-yd1.*(1.0./2.0),t6-xv2.*(1.0./2.0),t2-yd2.*(1.0./2.0),t4-xv1.*(1.0./2.0),-t2+t3,-t4+xv1.*(1.0./2.0),-t5+yd1.*(1.0./2.0),-t6+t7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-t3+t10,t4-xv3.*(1.0./2.0),t5-yd3.*(1.0./2.0),-t7+t9,-t5+t8,t7-t9,t3-t10,-t4+t11,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-t8+t14,t9-xv4.*(1.0./2.0),t10-yd4.*(1.0./2.0),-t11+t13,-t10+t12,t11-t13,t8-t14,-t9+t15,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-t12+t18,t13-xv5.*(1.0./2.0),t14-yd5.*(1.0./2.0),-t15+t17,-t14+t16,t15-t17,t12-t18,-t13+t19,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-t16+t21,t17-xv6.*(1.0./2.0),t18-yd6.*(1.0./2.0),-t19+t20,-t18+yd6.*(1.0./2.0),t19-t20,t16-t21,-t17+xv6.*(1.0./2.0),1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],[24,8]);
