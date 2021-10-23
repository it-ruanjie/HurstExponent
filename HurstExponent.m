function H = HurstExponent(TimeSeries, scale_list, m_val)

    % Convert noise like time series to random walk like time series
    X = cumsum(TimeSeries - mean(TimeSeries));
    X = transpose(X);
    scale = scale_list;
    m = m_val;
    
    for ns = 1:length(scale)
        segments(ns) = floor(length(X)/scale(ns));
        for v = 1:segments(ns)
            Idx_start = ((v-1)*scale(ns))+1;
            Idx_stop = v*scale(ns);
            Index{v, ns} = Idx_start:Idx_stop;
            X_Idx = X(Index{v, ns});
            C = polyfit(Index{v, ns},X(Index{v, ns}), m);
            fit{v, ns} = polyval(C, Index{v, ns});
            RMS{ns}(v) = sqrt(mean((X_Idx-fit{v,ns}).^2));
        end
        F(ns) = sqrt(mean(RMS{ns}.^2));
    end
    
    C = polyfit(log2(scale), log2(F),1);
    H = C(1);
    RegLine = polyval(C, log2(scale));
    
    % figure(2);
    % plot(log2(scale), log2(F), 'LineWidth', 2, 'DisplayName', 'Original');
    
end