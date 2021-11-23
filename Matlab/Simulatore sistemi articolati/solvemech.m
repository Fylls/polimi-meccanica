function [X,k,F,Fx]=solvemech(mechfun,X0, ...
                    epsilonE,epsilonS,maxiter,options,varargin)
%SOLVEMECH Numerically solves a mechanism for which the loop equations and
%the Jacobian matrix are defined in the MECHFUN function handle.
%Usage SOLVEMECH(MECHFUN,X0,epsilonE,epsilonS,MAXITER,OPTIONS,VARARGIN)
%    MECHFUN has to be an external function with outputs as the evaluated loop
%            equations as a vector F and the assosiated Jacobian matrix as a matrix Fx
%
%    X0 is the initial guess values of all unknowns (**LAST ENTRY IS THE INPUT**)
%            The last entry will be removed from the vector prior to
%            calculations, so X0 will be one element shorter.
%            After calculations, the last element will be added back to X
%
%    epsilonE is a vector the size of F with individual equation error tolerances
%    epsilonS is a vector the size of F with individual solution error tolerances
%    MAXITER maximum iteration until convergence
%    OPTIONS not implemented yet, enter as []
%    VARARGIN all known variables in the same order as they appear in
%             MECHFUN's function declaration
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007

%remove the last entry, which is the input
L=length(X0);
X0=X0(1:L-1);


[F,Fx]=mechfun(X0,varargin{:});
for k=1:maxiter,
    %check the Jacobian's determinant is not zero, if so exit
    if det(Fx)==0,
        k=-k;
        return
        X=X0;
    end
    deltaX=-inv(Fx)*F;
    X=X0+deltaX;
    [F,Fx]=mechfun(X,varargin{:});
    %check if the Equation tolerance is satisfied:
    errorE=abs(F);
    passE=prod(double(errorE<epsilonE));
    %check if the Solution tolerance is satisfied:
    errorS=abs(X-X0);
    passS=prod(double(errorS<epsilonS));

    if passE*passS, %success!
        
        %replace the last entry:
        X(L)=varargin{1};
        
        return
    end
    X0=X; %continue iterations
end
k=-k;
X(L)=varargin{1};

