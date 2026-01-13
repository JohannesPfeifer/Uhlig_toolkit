% VAR_decomp.m does a variance-decomposition for the k-step ahead prediction errors
% from the recursive law of motion (RLLN).
% It needs or computes an RLLN or VAR of the form
%
% x_tilde(t) = PP_tilde x(t-1) + QQ_tilde eps(t)
%
% with Sigma, a matrix assumed diagonal, as the variance-covariance matrix of eps(t)
%
% This routine can be used "stand-alone", if PP_tilde and QQ_tilde are given, or in 
% connection with the "Toolkit", where  x_tilde is the vector [x(t)', y(t)', z(t)' ]
% and where PP_tilde and QQ_tilde are computed from the "toolkit"-RLLN. 
% It is "general purpose" and not tied to a particular example.


DO_CALC_PP_TILDE = 1;
HORIZON_VAR_decomp = 21;
VAR_decomp_TINY = .00000000001;  % to avoid divisions by zero

if DO_CALC_PP_TILDE,
    % consolidate
    % x(t) = PP x(t-1) + QQ eps(t)
    % y(t) = RR x(t-1) + SS eps(t)
    % z(t) = NN z(t-1) + eps(t)
    % 
    % to
    % 
    % x_tilde(t) = PP_tilde x(t-1) + QQ_tilde eps(t)
    %
    % where x_tilde(t)' = [ x(t)', y(t)', z(t)']
    % and PP_tilde, QQ_tilde contain the appropriate matrices, see below.
    
    if ~exist('m_states'),
        [n_endog,m_states]=size(RR);
        k_exog=min(size(NN)); % note: NN is a square matrix
    end;
    PP_tilde = [ PP,    zeros(m_states,n_endog), QQ*NN,
                 RR,    zeros(n_endog, n_endog), SS*NN,
                 zeros(k_exog,m_states+n_endog),    NN ];
    QQ_tilde = [ QQ
                 SS
                 eye(k_exog) ];
end;
[n_tilde,k_tilde]=size(QQ_tilde);
var_tab = zeros(n_tilde,k_tilde,HORIZON_VAR_decomp);
sum_tab = zeros(n_tilde,HORIZON_VAR_decomp);
frac_tab = var_tab;
QQ_multistep = QQ_tilde;
QQ_square_sum = 0*QQ_tilde;
Sigma_tilde = diag(diag(Sigma)); % to make sure of diagonality
for hor_j = 1 : HORIZON_VAR_decomp,
    QQ_square_sum = QQ_square_sum + QQ_multistep.^2;
    var_tab(:,:,hor_j)=QQ_square_sum*Sigma_tilde;
    for n_j = 1 : n_tilde,
        sum_tab(n_j,hor_j) = sum(var_tab(n_j,:,hor_j));
        frac_tab(n_j,:,hor_j)=var_tab(n_j,:,hor_j)/(sum_tab(n_j,hor_j)+VAR_decomp_TINY);
    end;
    QQ_multistep = PP_tilde*QQ_multistep;
end;
