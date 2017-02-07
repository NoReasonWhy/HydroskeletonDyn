function [fc] = checkFcStr(testcase,fcstr,mf)
%CHECKFCSTR Summary of this function goes here
%   Detailed explanation goes here

k=strfind(testcase,fcstr);
if isempty(k)
	fc = 0;
else
	fc = mf;
end

