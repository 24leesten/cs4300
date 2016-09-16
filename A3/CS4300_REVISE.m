function D_revised = CS4300_REVISE(a,b,D,P)
% CS4300_REVISE - an implementation of the REVISE function for AC1 from the
%                   Mackworth paper 1977
% On input:
%     a (int): start node domain value
%     b (int): end node domain value
%     D (nxm array): m domain values for each of n nodes
%     P (string): predicate function name; P(i,a,j,b) takes as
%     arguments:
%        i (int): start node index
%        a (int): start node domain value
%        j (int): end node index
%        b (int): end node domain value
% On output:
%     D_revised (nxm array): revised m domain values of n nodes
% Call:
%     D = [1,1,1;1,1,1;1,1,0;1,1,0;1,1,0];
%     deleted = CS4300_REVISE(1,2,D);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

domainA = D(a, 1:end);
domainB = D(b, 1:end);

% iterate over the beginning domain
for i = 1:size(domainA, 2)
    % if the value is 0, skip it
    if D(a,i) == 0
        continue;
    end
    
    supported = false;
    
    % iterate over the ending domain
    for j = 1:size(domainB, 2)
        if D(b,j) == 0
            continue;
        end
        
        % check for support. Break if support is found.
        if feval(P,i,a,j,b) 
            supported = true;
            break;
        end
    end
    
    % if all pairwise predicates fail for the given element in the
    % beginning domain, set that element to 0 (delete it) and record the
    % choice to delete an element
    if supported == false
        D(a,i) = 0;
    end
end

D_revised = D;