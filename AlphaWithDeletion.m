function alpha = AlphaWithDeletion(Data)
    % List-wise deletion: Remove rows with any missing values
    data_complete = Data(~any(isnan(Data), 2), :);

    % Compute the number of items (variables)
    K = size(data_complete, 2);

    % Compute variance for each item
    item_variances = var(data_complete);

    % Compute the variance of the sum of all items
    total_variance = var(sum(data_complete, 2));

    % Compute Cronbach's alpha
    alpha = (K / (K - 1)) * (1 - sum(item_variances) / total_variance);
end