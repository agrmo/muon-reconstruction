% Principles of Experimental Physics
% Experiment 11
% Agustin Romero

function Experimenta11()
    plot_small()
end

function plot_large()
    matrix = readmatrix('large.txt');
    plot(matrix(:,1), matrix(:,2), '-o');
    title('Large Plateau');
    xlabel('Voltage (V)');
    ylabel('Number of pulses per minute');    
    ax = gca;
    ax.FontSize = 18; 
end

function plot_small()
    matrix = readmatrix('small.txt');
    plot(matrix(:,1), matrix(:,2), '-o');
    title('Small Plateau');
    xlabel('Voltage (V)');
    ylabel('Number of pulses per minute');    
    ax = gca;
    ax.FontSize = 18; 
end

function centers = get_centers(edges, binwidth)
    centersex = edges + binwidth ./ 2;
    centers = centersex(1:end-1);
end

function plot_fit_pdf()
    matrix = readmatrix('trial-4.txt');
    
    h = histogram(matrix, 'normalization', 'pdf');
    
    pd = fitdist(matrix, 'exponential');
    
    hold on;
        
    x_values = 0:0.5:10;
    
    y = (1 ./ pd.mu()) .* exp(- x_values .* (1 ./ pd.mu()));
    
    plot(x_values, y);
    
    hold on;
end

function plot_fit()
    matrix = readmatrix('trial-4.txt');
    
    size(matrix)
    
    h = histogram(matrix, 13);
    
    pd = fitdist(matrix, 'exponential')
    
    hold on;
        
    x_values = 0:0.5:10;
    
    y = pdf(pd, x_values);
          
    plot(x_values, y);
    
    centers = get_centers(h.BinEdges, h.BinWidth);
            
    histfit(matrix, 13, 'exponential');
    
    errorbar(centers, h.Values, sqrt(h.Values), 'LineStyle', 'none');
    
    title('Muon Data');
    xlabel('Decay time (\mu s)');
    ylabel('Number of occurences');    
    xlim([0 10]);
    ax = gca;
    ax.FontSize = 18; 
end