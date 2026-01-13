% VERSION 4.2, August 2003, COPYRIGHT H. UHLIG.
% WHATSNEW.M describes what is new in this version, which is version 4.1.


% Copyright: H. Uhlig.  Feel free to copy, modify and use at your own risk.
% However, you are not allowed to sell this software or otherwise impinge
% on its free distribution.
disp('A number of changes were made between 1997 and 2003.');
disp('The QZ-method is now the default algorithm for solving the models.');
disp('However you can still use the old solution method.');
disp('The Autocorrelation calculation in Simul.m and Moments.m interchanged lags and leads before.');
disp('This has now been corrected.');
disp('Mom_out: No "HP-filtered" in title of tables, if no HP Filtering was done.'); 
disp('There are lots of new options available. Lookup OPTIONS.M');
disp(' ');
disp('New additions since version 4.1:');
disp('- added the routine var_decomp.m, which allows a variance decomposition of k-step');
disp('  ahead prediction error variances, as calculated from the recursive law of motion');
disp('- modified the text at the beginning of impresp.m to point out that selection of');
disp('  states and shocks, for which impulse responses are calculated, is possible.');
disp('- in the code of OPTIONS.M, set DO_QZ = 1, as default, rather than DO_QZ = 0');
disp(' ');
disp('   Harald Uhlig, August 2003');
disp('   Humboldt University, uhlig@wiwi.hu-berlin.de, ');
disp('   Home page: http://www.wiwi.hu-berlin.de/wpol/');
disp('   You can get these files via: ');
disp('   http://www.wiwi.hu-berlin.de/wpol/html/toolkit.htm');