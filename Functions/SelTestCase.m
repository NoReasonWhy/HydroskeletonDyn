function [ftest,fcv] = SelTestCase(testcase,mf,q)
%SELTESTCASE Summary of this function goes here
%   m - magnitude of a single contraction force
%		ftest - resulant forces acting on invidual masses
%   fcv - a vector that contains the magintude of the 6 contraction types


fc_vi2di   = checkFcStr(testcase,'_vi2di_',  mf);
fc_vii2dii = checkFcStr(testcase,'_vii2dii_',mf);
fc_di2dii  = checkFcStr(testcase,'_di2dii_', mf);
fc_vi2vii  = checkFcStr(testcase,'_vi2vii_', mf);
fc_di2vii  = checkFcStr(testcase,'_di2vii_', mf);
fc_vi2dii  = checkFcStr(testcase,'_vi2dii_', mf);

fcv = [fc_vi2di; fc_vii2dii; fc_di2dii; fc_vi2vii; fc_di2vii; fc_vi2dii];

%% The 1st row of TestCaseM
% Cases of a single contrction
TestCaseM{1} = 'test1_Fc_vi2di_' ;
TestCaseM{2} = 'test2_Fc_di2vii_';

% Cases of a double contraction
TestCaseM{3} = 'test3_Fc_vi2di_vii2dii_';
TestCaseM{4} = 'test4_Fc_vi2di_di2dii_' ;
TestCaseM{5} = 'test5_Fc_vi2di_di2vii_' ; 

% Cases of a triple contraction
TestCaseM{6}  = 'test6_Fc_vi2di_vii2dii_di2dii_';
TestCaseM{7}  = 'test7_Fc_vi2di_vii2dii_di2vii_';
TestCaseM{8}  = 'test8_Fc_vi2di_di2dii_di2vii_' ;
TestCaseM{9}  = 'test9_Fc_vi2di_di2dii_vi2dii_' ;
TestCaseM{10} = 'test10_Fc_vi2di_di2vii_vi2dii_' ;

% Cases of a quadruple contraction
TestCaseM{11} = 'test11_Fc_vi2di_vii2dii_di2dii_vi2vii_';
TestCaseM{12} = 'test12_Fc_vi2di_vii2dii_di2dii_di2vii_';
TestCaseM{13} = 'test13_Fc_vi2di_vii2dii_di2vii_vi2dii_';

% Cases of a pentadruple contraction
TestCaseM{14} = 'test14_Fc_vi2di_vii2dii_di2dii_vi2vii_di2vii_';
TestCaseM{15} = 'test15_Fc_vi2di_vii2dii_vi2vii_di2vii_vi2dii_';

% Cases of a hexatruple contraction
TestCaseM{16} = 'test16_Fc_vi2di_vii2dii_di2dii_vi2vii_vi2dii_di2vii_';

% Additional testcases
TestCaseM{17} = 'test17_Fc_di2dii_';
TestCaseM{18} = 'test18_Fc_vii2dii_';

%% The 2nd row of TestCaseM
r = 2;
for i = 1:length(TestCaseM(1,:))
	testcase_tmp = TestCaseM(1,i);
	TestCaseM(r,i) = strrep(testcase_tmp,'_Fc_', '_1stPC_Fc_');
end


switch testcase
	
	%% Cases of no contraction
	case 'test0_noFc'
		ftest = zeros(length(q(:)),1);
	
	%%  Cases of a single contrction
	case {TestCaseM{:,1}}
		ftest = Fi_vi2di_npair_fcn([mf 0],q);
		
	case {TestCaseM{:,2}}
		ftest = Fi_di2vii_fcn(mf,q);
		
	case {TestCaseM{:,17}}
		ftest = Fi_di2dii_fcn(mf,q);
	
	case {TestCaseM{:,18}}
		ftest = Fi_vi2di_npair_fcn([0 mf 0 0 0 0],q);
		
  %% Cases of a double contraction
% 	case {'test3_Fc_vi2di_vii2dii_','test3_1stPC_Fc_vi2di_vii2dii_'}
	case {TestCaseM{:,3}}
		ftest = Fi_vi2di_npair_fcn([mf mf],q);
		
  case {TestCaseM{:,4}}
		ftest = Fi_vi2di_npair_fcn([mf 0],q) + Fi_di2dii_fcn(mf,q);
		
	case {TestCaseM{:,5}}
		ftest = Fi_vi2di_npair_fcn([mf 0],q) + Fi_di2vii_fcn(mf,q);
		
		
	%% Cases of a triple contraction
  case {TestCaseM{:,6}}
		ftest = Fi_vi2di_npair_fcn([mf mf],q) + Fi_di2dii_fcn(mf,q);
		
	case {TestCaseM{:,7}}
		ftest = Fi_vi2di_npair_fcn([mf mf],q) + Fi_di2vii_fcn(mf,q);
		
	case {TestCaseM{:,8}}
		ftest = Fi_vi2di_npair_fcn([mf 0],q) + Fi_di2dii_fcn(mf,q) + Fi_di2vii_fcn(mf,q);
		
	case {TestCaseM{:,9}}
		ftest = Fi_vi2di_npair_fcn([mf 0],q) + Fi_di2dii_fcn(mf,q) + Fi_vi2dii_fcn(mf,q);
		
	case {TestCaseM{:,10}}
		ftest = Fi_vi2di_npair_fcn([mf 0],q) + Fi_di2vii_fcn(mf,q) + Fi_vi2dii_fcn(mf,q);
		
		
	%% Cases of a quadruple contraction
	case {TestCaseM{:,11}}
		ftest = Fi_vi2di_npair_fcn([mf mf],q) + Fi_di2dii_fcn(mf,q) + Fi_vi2vii_fcn(mf,q);
		
	case {TestCaseM{:,12}}
		ftest = Fi_vi2di_npair_fcn([mf mf],q) + Fi_di2dii_fcn(mf,q) + Fi_di2vii_fcn(mf,q);
		
	case {TestCaseM{:,13}}
		ftest = Fi_vi2di_npair_fcn([mf mf],q) + Fi_di2vii_fcn(mf,q) + Fi_vi2dii_fcn(mf,q);
		
	
	%% Cases of a pentadruple contraction
	case {TestCaseM{:,14}}
		ftest =   Fi_vi2di_npair_fcn([mf mf],q) + Fi_di2dii_fcn(mf,q) ...
		        + Fi_vi2vii_fcn(mf,q) + Fi_di2vii_fcn(mf,q);
		
	case {TestCaseM{:,15}}
		ftest =   Fi_vi2di_npair_fcn([mf mf],q) + Fi_vi2vii_fcn(mf,q) ...
		        + Fi_di2vii_fcn(mf,q) + Fi_vi2dii_fcn(mf,q);

	%% Cases of a hexatruple contraction
	case {TestCaseM{:,16}}
		ftest =   Fi_vi2di_npair_fcn([mf mf],q) + Fi_di2dii_fcn(mf,q) ...
		        + Fi_vi2vii_fcn(mf,q) + Fi_di2vii_fcn(mf,q) + Fi_vi2dii_fcn(mf,q);
		
	otherwise
		error('TestCase is not matached.')
end


end

