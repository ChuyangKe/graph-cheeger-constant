function H = cheeger(G)
%CHEEGER Graph Cheeger constant. 
%   
%   H =  cheeger(G) returns the Cheeger constant of a graph adjacency 
%   matrix G. G is a symmetric matrix with size n x n. 
%   G(i,j) = G(j,i) = 1 if and only if there exists an edge connecting 
%   node i and j, and G(i,j) = G(j,i) = 0 otherwise.
%
%   Reference: 
%   https://en.wikipedia.org/wiki/Cheeger_constant_(graph_theory)
% 
%   Author: 
%   Chuyang Ke (cke@purdue.edu)
%
%   Version History:
%   - 2021/04/10    Initial version

if ~issymmetric(G)
    error('Input must be a symmetric matrix.');
end

n = size(G,1);
if n < 2
    error('Size of input must be at least 2 x 2.');
end

H = inf;
for setSize = 1:n/2
    for setV = nchoosek(1:n,setSize)'
        setComplement = setdiff(1:n,setV);
        setBoundary = sum(sum(G(setV,setComplement)));
        setConductance = setBoundary/setSize;
        if setConductance < H
            H = setConductance;
        end
    end
end
end