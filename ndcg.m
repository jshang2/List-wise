
%NDCG   Normalized Discounted Cumulative Gain
%   NDCG(pred_relevance, y) returns nDCG, where pred_relevance is the true 
%   graded relevance of all results in the search result list (the vector 
%   has to be sorted by the estimated relevance in the descending order)  
%   and y is a vector of all relevances in the corpus (it does not have to 
%   be in any particular order as it is automatically sorted).
% 
%   This is a straightforward implementation of nDCG measure as described
%   at Wikipedia. No attempt was made to accelerate the function (e.g.
%   by caching the optimal ranking or by precomputing the logarithms).
%   And no attempt was made to deal with ties (e.g. optimistic and 
%   pessimistic estimates are not provided).
% 
%   Example from en.wikipedia.org/wiki/Discounted_cumulative_gain:
%       pred_relevance = [3;2;3;0;1;2]; % High values mean higher relevance
%       y = [3;2;3;0;1;2;3;2];          % The relevance of the whole corpus 
%       ndcg(pred_relevance, y)         % We expect nDCG=0.785
%
%   Author: Jan Motl
%   Date: 2017-12-28
%   Version: 1.0

function nDCG = ndcg(pred_relevance, y)
    %% Parameter checks
    % Two parameters are present.
    % Each of them is either a vectors or a scalar.
    % If one of the parameters is absent/empty, we do not have 
    % enough information to make a sound estimate.
    if ~(isvector(pred_relevance) || isscalar(pred_relevance))
        error('Parameter pred_relevance is not a vector or a scalar');
    end
    if ~(isvector(y) || isscalar(y))
        error('Parameter y is not a vector or a scalar');
    end

    % If pred_relevance is longer than y, we cannot calculate the ideal
    % ranking.
    if length(pred_relevance)>length(y)
        error('Parameter pred_relevance is longer than parameter y');
    end

    % Relevance is usually a non-negative number but it is not a rule.
    if any(pred_relevance < 0)
        warning('Vector pred_relevance contains negative relevances');
    end
    %if any(y <= 0)
    if any(y < 0)
        warning('Vector y contains negative relevances');
    end

    % Missing value treatment was not implemented.
    if any(isnan(pred_relevance))
        error('Parameter pred_relevance contains a missing value');
    end
    if any(isnan(y))
        error('Parameter y contains a missing value');
    end

    %% The actual computation
    % nDCG is commonly calculated only for top k items, get the k.
    len = length(pred_relevance);

    % Get "Discounted Cumulative Gain" for the provided ranking.
    DCG = sum(pred_relevance./log2(1+(1:len))');

    % Get ideal ranking for the top k items.
    sorted = sort(y, 'descend');
    ideal = sorted(1:len);

    % Get "Discounted Cumulative Gain" for the ideal ranking.
    IDCG = sum(ideal./log2(1+(1:len))');

    % Get the normalized result.
    nDCG = DCG/IDCG;
end