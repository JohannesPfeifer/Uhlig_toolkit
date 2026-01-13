% VERSION 2.0, MARCH 1997, COPYRIGHT H. UHLIG.
% DO_IT.M performs all the calculations and calls output-
% creating routines.  It assumes, that all required variables have been set

% Copyright: H. Uhlig.  Feel free to copy, modify and use at your own risk.
% However, you are not allowed to sell this software or otherwise impinge
% on its free distribution.


[l_equ,m_states] = size(AA);
[l_equ,n_endog ] = size(CC);
[l_equ,k_exog  ] = size(DD);

message = '                                                                       ';
warnings = [];
options;
solve;
SOLVE_FLAGS = SOLVE_FLAG_PP | ( ( SOLVE_FLAG_COMPLEX | SOLVE_FLAG_VV ) & ( ~DO_IGNORE_FLAGS) );
if ( ~SOLVE_FLAGS ) & DO_SOL_OUT,
    sol_out;
end;
if ~DO_QUIET,
    if DISPLAY_LATER & (max(size(warnings)) > 1),
        disp('=======================================================================');
        disp('Your messages: (You can turn me off with DISPLAY_LATER = 0)');
        disp(warnings);
        disp('=======================================================================');
    end;
end;
if ( ~SOLVE_FLAGS ),
    if DO_IMPRESP,
        impresp;
    end;
    if DO_SIMUL,
        simul;
        if DO_SIM_OUT,
            sim_out;
        end;
    end;
    if DO_MOMENTS,
        moments;
        if DO_MOM_OUT,
            mom_out;
        end;
    end;
    if ~DO_QUIET,
        if DISPLAY_AT_THE_END & (max(size(warnings)) > 1),
            disp('=======================================================================');
            if DISPLAY_LATER | DISPLAY_IMMEDIATELY,
                disp('Again, your (warning) messages: (You can turn me off with DISPLAY_AT_THE_END = 0)');
            else
                disp('Your messages: (You can turn me off with DISPLAY_AT_THE_END = 0)');
            end;
            disp(warnings);
            disp('=======================================================================');
        else
            disp('(Note: Messages will be displayed here with DISPLAY_AT_THE_END = 1)');
        end;
    end;
else
    if ~DO_QUIET,
        if DISPLAY_AT_THE_END & (max(size(warnings)) > 1),
            disp('=======================================================================');
            if DISPLAY_LATER | DISPLAY_IMMEDIATELY,
                disp('Again, your (warning) messages: (You can turn me off with DISPLAY_AT_THE_END = 0)');
            else
                disp('Your messages: (You can turn me off with DISPLAY_AT_THE_END = 0)');
            end;
            disp(warnings);
            disp('DO_IT: stopped because of flags.');
            disp(sprintf('SOLVE_FLAG_PP      = %3.0f',SOLVE_FLAG_PP));
            disp(sprintf('SOLVE_FLAG_COMPLEX = %3.0f',SOLVE_FLAG_COMPLEX));
            disp(sprintf('SOLVE_FLAG_VV      = %3.0f',SOLVE_FLAG_VV));
            disp('=======================================================================');
        else
            disp('DO_IT: stopped because of flags.');
            disp(sprintf('SOLVE_FLAG_PP      = %3.0f',SOLVE_FLAG_PP));
            disp(sprintf('SOLVE_FLAG_COMPLEX = %3.0f',SOLVE_FLAG_COMPLEX));
            disp(sprintf('SOLVE_FLAG_VV      = %3.0f',SOLVE_FLAG_VV));
            disp(sprintf('Thus SOLVE_FLAGS   = %3.0f',SOLVE_FLAGS));
            disp('(Note: Messages will be displayed here with DISPLAY_AT_THE_END = 1)');
        end;
    end;
end;
